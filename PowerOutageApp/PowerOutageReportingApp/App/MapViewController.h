//
//  MapViewController.h
//  iFactor
//
//  Created by iFactor iProject Team Spr 2013 on 4/29/13.
//  Copyright (c) 2013 iFactor iProject Team Spr 2013. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "LastScreen.h"

@interface MapViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapview;
@property (weak, nonatomic) IBOutlet UITableView *tableview2;
@property (strong,nonatomic) CLLocationManager *location;
@property (strong,nonatomic) CLLocation *currentLocation;
@property(strong,nonatomic) NSString *accuracyfactor;
- (IBAction)back:(id)sender;
-(void)populatedatabase;
@end
