//
//  LastScreen.m
//  iFactor
//
//  Created by iFactor iProject Team Spr 2013 on 4/29/13.
//  Copyright (c) 2013 iFactor iProject Team Spr 2013. All rights reserved.
//

#import "LastScreen.h"
#import "Annotations.h"

@interface LastScreen ()

@end

@implementation LastScreen

{
    Annotations  *myannotation;
    
}

@synthesize mapview,viewcell;
@synthesize addresslabel;
@synthesize textforlabel;
@synthesize indexPath;
@synthesize displayLocation,lats,longs ,accno,address,accuracy;

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
    addresslabel.text=viewcell.textLabel.text;
    NSLog(@"Came here  %@ and %@",lats,longs);
    MKCoordinateRegion region;
    region.center.latitude= [lats floatValue];
    region.center.longitude=[longs floatValue];
    region.span.latitudeDelta=0.005;
    region.span.longitudeDelta=0.005;
    CLLocationCoordinate2D coordinate;
    coordinate.latitude=[lats floatValue];
    coordinate.longitude=[longs floatValue];
    //set annotation co-ordinate
    myannotation=[Annotations alloc];
    myannotation.coordinate=coordinate;
    //add annotion to the map
    [self.mapview addAnnotation:myannotation];
    [self.mapview setRegion:region animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)no:(id)sender {
            
    MapViewController *mvc=[self.storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
        mvc.accuracyfactor=accuracy;
    [self presentViewController:mvc animated:YES completion:nil];
    
    
}
//For sending email
- (IBAction)yesbutton:(id)sender {
        
   /* Use this code to get phone identifier. This has been deprecated in ios 5  
    UIDevice *myDevice = [UIDevice currentDevice];
    NSString *identifier= myDevice.uniqueIdentifier;
    NSLog(@" identifier : %@",identifier);*/
    
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDateComponents * components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSSecondCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit
                                                fromDate:[NSDate date]];
    NSString * stringDate = [NSString stringWithFormat:@"%d-%d-%d %d:%d:%d", components.year, components.month, components.day, components.hour, components.minute, components.second];
    NSString *modelname= [[UIDevice currentDevice]localizedModel];
    NSString *systemversion=[[UIDevice currentDevice] systemVersion];
    NSString * version = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
    //Message displayed in the body of email
    NSString *message1=[NSString stringWithFormat:@"Power Outage reported for address: %@ \n Latitude: %@ \n longitude: %@ \n Account number: %@ \n Date: %@ \n Model number of reporting phone: %@ \n System version: %@ \n Application version: %@ \n accuracy %@ \n",address,lats,longs,accno,stringDate,modelname,systemversion,version,accuracy];
    //canSendMail returns YES if the device is configured for sending email or NO if it is not.
    if ([MFMailComposeViewController canSendMail]) {
        
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        mailViewController.mailComposeDelegate = self;
        [mailViewController setSubject:@"Power Outage!"];
        [mailViewController setToRecipients:[NSArray arrayWithObject:@"agastheswar@gmail.com"]];
        [mailViewController setMessageBody:message1 isHTML:NO];
        [self presentViewController:mailViewController animated:YES completion:nil];
         
    }else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Email not sent" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
        [alert addButtonWithTitle:@"Ok"];
        [alert show];
        
        NSLog(@"Device is unable to send email in its current state.");
    }
          
    FirstViewController *fvc=[self.storyboard instantiateViewControllerWithIdentifier:@"FirstViewController"];
    [self.navigationController pushViewController:fvc animated:YES];
}


- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    // Notifies users about errors associated with the interface
    switch (result)
    {
        case MFMailComposeResultCancelled:
            //NSLog(@"Result: canceled");
            break;
        case MFMailComposeResultSaved:
            //NSLog(@"Result: saved");
            break;
        case MFMailComposeResultSent:
        {
            //Pop-up alert
            [self pushviewcontroller];
        }
            break;
        case MFMailComposeResultFailed:
            //NSLog(@"Result: failed");
            break;
        default:
            //NSLog(@"Result: not sent");
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

//Method defines action to be peformed when MFMailComposeResultSent is true
-(void)pushviewcontroller
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Thank You" message:@"Power Outage has been reported" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    [alert addButtonWithTitle:@"Ok"];
    [alert show];
}

/*Action to perform upon clicking the button in Alert*/
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //NSLog(@"Alert action ");
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"Ok"])
    {
        FirstViewController *fvc=[self.storyboard instantiateViewControllerWithIdentifier:@"FirstViewController"];
        [self presentViewController:fvc animated:YES completion:nil];
    }
    
}

- (IBAction)back:(id)sender {
    
    //Opens MapViewController Screen
    MapViewController *mvc=[self.storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
    [self presentViewController:mvc animated:YES completion:nil];
}
@end