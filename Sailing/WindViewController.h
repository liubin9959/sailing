//
//  WindViewController.h
//  Sailing
//
//  Created by tomaszbrue on 03.11.13.
//  Copyright (c) 2013 Thomas Brüggemann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MainViewController.h"

@interface WindViewController : UIViewController<CLLocationManagerDelegate>

@property (nonatomic,retain) CLLocationManager *locationManager;
@property (nonatomic, retain) IBOutlet UIButton *setWindButton;
@property (nonatomic, retain) IBOutlet UILabel *headingLabel;
@property double lastHeading;
@property (nonatomic, retain) MainViewController *mainViewController;

- (IBAction)windButtonTapped:(id)sender;

@end
