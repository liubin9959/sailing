//
//  WindViewController.m
//  Sailing
//
//  Created by tomaszbrue on 03.11.13.
//  Copyright (c) 2013 Thomas Brüggemann. All rights reserved.
//

#import "WindViewController.h"
#import "AppDelegate.h"

@interface WindViewController ()

@end

@implementation WindViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // start heading observation
    self.locationManager = [[CLLocationManager alloc] init];
	self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	self.locationManager.headingFilter = 1;
	self.locationManager.delegate = self;
	[self.locationManager startUpdatingHeading];
    
    // button events
    [self.setWindButton addTarget:self action:@selector(windButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Events

- (IBAction)windButtonTapped:(id)sender
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.wind.heading = self.lastHeading;
    [self.locationManager stopUpdatingHeading];
    
    self.mainViewController.windLabel.text = [Helper courseToDirection:appDelegate.wind.heading];
    
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma LocationDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
	self.lastHeading = newHeading.trueHeading;
    self.headingLabel.text = [NSString stringWithFormat:@"%@", [Helper courseToDirection:self.lastHeading]];
}

@end
