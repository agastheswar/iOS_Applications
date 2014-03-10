//
//  FirstViewController.m
//  iFactor
//
//  Created by iFactor iProject Team Spr 2013 on 4/29/13.
//  Copyright (c) 2013 iFactor iProject Team Spr 2013. All rights reserved.
//

#import "FirstViewController.h"
#import "Reachability.h"
#import <QuartzCore/QuartzCore.h>

@interface FirstViewController ()

@end

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"photo.jpg"]];
    [[self.reportbutton layer] setCornerRadius:2.0f];
    
    [[self.reportbutton layer]setBorderColor:[UIColor brownColor].CGColor];
    [[self.reportbutton layer]setBorderWidth:5.0f];
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    if(status == NotReachable)
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Turn on Wifi/3G GPS" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        [alert show];

        
    }
      
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)AccuracyBest:(id)sender {
    
    MapViewController *mvc=[self.storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
    [self presentViewController:mvc animated:YES completion:nil];
    mvc.accuracyfactor=@"best";
    
}

- (IBAction)Accuracy10m:(id)sender {
    
    MapViewController *mvc=[self.storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
    [self presentViewController:mvc animated:YES completion:nil];
    mvc.accuracyfactor=@"10m";
}

- (IBAction)Accuracy100m:(id)sender {
    MapViewController *mvc=[self.storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
    [self presentViewController:mvc animated:YES completion:nil];
    mvc.accuracyfactor=@"100m";
}
@end
