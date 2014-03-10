//
//  LastScreen.h
//  iFactor
//
//  Created by iFactor iProject Team Spr 2013 on 3/29/13.
//  Copyright (c) 2013 iFactor iProject Team Spr 2013. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapViewController.h"
#import <CFNetwork/CFNetwork.h>
#import "FirstViewController.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <sys/utsname.h>


@interface LastScreen : UIViewController <CLLocationManagerDelegate,MFMailComposeViewControllerDelegate,UIAlertViewDelegate>
{
    UIViewController *mapviewcontroller;
    UIViewController *viewcontrl;
}

-(void)pushviewcontroller;

- (IBAction)back:(id)sender;

@property (weak, nonatomic) IBOutlet MKMapView *mapview;
@property (strong, nonatomic) IBOutlet UILabel *addresslabel;
@property(weak,nonatomic) UITableViewCell *viewcell;
@property(nonatomic) NSString *lats;
@property(nonatomic) NSString *longs;
@property(nonatomic) NSString *address;
@property(retain,nonatomic) NSString *accno;
@property(retain,nonatomic) NSString *textforlabel;
@property(retain,nonatomic) NSNumber *indexPath;
@property (strong,nonatomic) CLLocation *displayLocation;
@property (strong,nonatomic) CLLocation *currentLocation;
@property(strong,nonatomic) NSString *accuracy;

- (IBAction)no:(id)sender;
- (IBAction)yesbutton:(id)sender;
@end
