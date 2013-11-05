//
//  MainViewController.h
//  Sailing
//
//  Created by tomaszbrue on 03.11.13.
//  Copyright (c) 2013 Thomas Brüggemann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapBox/MapBox.h>
#import "SRWebSocket.h"

@interface MainViewController : UIViewController<CLLocationManagerDelegate, SRWebSocketDelegate>

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, strong) IBOutlet RMMapView *mapView;
@property (nonatomic, retain) CLLocation *lastPosition;
@property (nonatomic, retain) RMShape *path;
@property (nonatomic, retain) RMAnnotation *annotation;
@property (nonatomic, retain) NSMutableArray *pathLocations;

@property (nonatomic, retain) IBOutlet UILabel *baumLabel;
@property (nonatomic, retain) IBOutlet UILabel *windLabel;
@property (nonatomic, retain) IBOutlet UILabel *courseLabel;
@property (nonatomic, retain) IBOutlet UILabel *speedLabel;

@end
