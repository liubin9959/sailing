//
//  MainViewController.m
//  Sailing
//
//  Created by tomaszbrue on 03.11.13.
//  Copyright (c) 2013 Thomas Brüggemann. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"
#import "TBEnums.h"
#import "WindViewController.h"
#import "TBHelper.h"
#import "SRWebSocket.h"
#import <MapBox/RMOpenSeaMapSource.h>

@interface MainViewController ()

@end

@implementation MainViewController {
    SRWebSocket *_webSocket;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    self.locationManager.delegate = self;
    self.locationManager.pausesLocationUpdatesAutomatically = YES;
    self.locationManager.activityType = CLActivityTypeOtherNavigation;
    
    [self.locationManager startUpdatingLocation];
    
    // Map
    self.mapView.tileSource = [[RMMapBoxSource alloc] initWithMapID:@"tomaszbrue.g91ic4gb"];
    self.mapView.centerCoordinate = CLLocationCoordinate2DMake(0, 0);
    self.mapView.userTrackingMode = RMUserTrackingModeFollow;
    self.mapView.minZoom = 1;
    self.mapView.zoom = 16;
}

- (void)viewWillAppear:(BOOL)animated
{
    _webSocket.delegate = nil;
    [_webSocket close];
    
    _webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://192.168.0.136:9000"]]];
    _webSocket.delegate = self;
    [_webSocket open];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"windSelector"]) {
        WindViewController *windViewController = segue.destinationViewController;
        windViewController.mainViewController = self;
    }
}

#pragma mark - Location Services

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [self fanOut:newLocation];
}

- (void)fanOut:(CLLocation *)location
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // position tracking
    self.lastPosition = location;
    appDelegate.boat.position = location.coordinate;
    
    [self.mapView setCenterCoordinate:self.lastPosition.coordinate animated:YES];
    
    // draw path
    if (location.horizontalAccuracy <= 5) {
        if (self.path == nil) {
            self.path = [[RMShape alloc] initWithView:self.mapView];
            self.path.lineColor = [UIColor redColor];
            self.path.lineWidth = 2;
            self.annotation = [[RMAnnotation alloc] initWithMapView:self.mapView coordinate:location.coordinate andTitle:nil];
            self.annotation.layer = self.path;
            [self.path moveToCoordinate:location.coordinate];
            self.pathLocations = [[NSMutableArray alloc] init];
        }
        
        [self.pathLocations addObject:location];
        [self.path addLineToCoordinate:location.coordinate];
        [self.annotation setBoundingBoxFromLocations:self.pathLocations];
        [self.mapView addAnnotation:self.annotation];
    }
    
    // course
    appDelegate.boat.heading = location.course;

    if (location.course > 0) {
        self.courseLabel.text = [NSString stringWithFormat:@"%.0f° (%@)", location.course, [TBHelper courseToDirection:location.course]];
    }
    
    // speed
    double knots = 0;
    if (location.speed > 0) {
        knots = location.speed * 1.94384449;
    }
    self.speedLabel.text = [NSString stringWithFormat:@"%.1f kn", knots];
    
    // boom
    switch ([appDelegate.boat getBoom])
    {
        case Portside:
            self.baumLabel.text = @"Backbord";
            break;
            
        case Starboard:
            self.baumLabel.text = @"Steuerbord";
            break;
            
        case Spilling:
            self.baumLabel.text = @"Mitte/Killt";
            break;
            
        case Either:
            self.baumLabel.text = @"Egal";
            
        default:
            break;
    }
}

#pragma mark - SRWebSocket

- (void)webSocketDidOpen:(SRWebSocket *)webSocket;
{
    NSLog(@"Websocket Connected");
    [self.locationManager stopUpdatingLocation];
    [webSocket send:@"CONNECTED"];
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error;
{
    NSLog(@":( Websocket Failed With Error %@", error);
    _webSocket = nil;
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message;
{
    NSLog(@"Received \"%@\"", message);
    
    // check if the message could be a location
    if (![message isEqualToString:@"CONNECTED"]) {

        NSMutableString *mutable = [NSMutableString stringWithString:message];
        [mutable setString: [mutable stringByReplacingOccurrencesOfString:@"(" withString:@""]];
        [mutable setString: [mutable stringByReplacingOccurrencesOfString:@")" withString:@""]];
        [mutable setString: [mutable stringByReplacingOccurrencesOfString:@" " withString:@""]];
        NSArray *parts = [mutable componentsSeparatedByString:@","];
        
        CLLocationCoordinate2D coord = CLLocationCoordinate2DMake([[parts objectAtIndex:0] doubleValue], [[parts objectAtIndex:1] doubleValue]);
        CLLocation *a = [[CLLocation alloc] initWithCoordinate:coord
                                                      altitude:50
                                            horizontalAccuracy:1
                                              verticalAccuracy:1
                                                        course:90
                                                         speed:10
                                                     timestamp:[NSDate date]];
        
        [self fanOut:a];
    }
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean;
{
    NSLog(@"WebSocket closed");
    self.title = @"Connection Closed! (see logs)";
    _webSocket = nil;
}

@end
