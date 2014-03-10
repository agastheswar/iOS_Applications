//
//  MapViewController.m
//  iFactor
//
//  Created by iFactor iProject Team Spr 2013 on 4/29/13.
//  Copyright (c) 2013 iFactor iProject Team Spr 2013. All rights reserved.
//

#import "MapViewController.h"
#import "Annotations.h"
#import "LocationInfo.h"
#import "LocationDatabase.h"
#import "CustomAnnotationView.h"
#import "FirstViewController.h"


@interface MapViewController ()

@end

@implementation MapViewController
{
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    Annotations *myannotation;
    NSInteger count;
    NSInteger count1;
    NSInteger countrecords;
    NSMutableArray *addressarray;
    NSMutableArray *latsarray;
    NSMutableArray *longsarray;
    NSMutableArray *accountarray;
    NSString *string;
    NSInteger addressNumber;
    NSArray* imageName;
    NSArray* annId;
    NSMutableArray *annArray;
    NSMutableDictionary *imageIdDict;
}

@synthesize mapview;
@synthesize location;
@synthesize currentLocation;
@synthesize tableview2;
@synthesize accuracyfactor;

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
    
     self.mapview.delegate=self;
     self.location=[[CLLocationManager alloc]init];
     self.location.delegate=self;
    //initialize array of image names
    imageName=[NSArray arrayWithObjects:
                            @"Location1",@"Location2",@"Location3",@"Location4",@"Location5",
                            @"Location6",@"Location7",@"Location8",@"Location9",@"Location10",
                            @"Location11",@"Location12",@"Location13",@"Location14",@"Location15", nil];
    //initialize array of annotation identifiers
    annId= [NSArray arrayWithObjects:
                            @"1",@"2",@"3",@"4",@"5",
                            @"6",@"7",@"8",@"9",@"10",
                            @"11",@"12",@"13",@"14",@"15", nil];
   //initialize array to hold annotations
    annArray=[[NSMutableArray alloc] init];
    //initialize dictionary to hold annotation identifiers and associated image name.
    imageIdDict = [NSMutableDictionary dictionary];
    [imageIdDict setObject:@"Location1" forKey:@"1"];
    [imageIdDict setObject:@"Location2" forKey:@"2"];
    [imageIdDict setObject:@"Location3" forKey:@"3"];
     [imageIdDict setObject:@"Location4" forKey:@"4"];
     [imageIdDict setObject:@"Location5" forKey:@"5"];
     [imageIdDict setObject:@"Location6" forKey:@"6"];
     [imageIdDict setObject:@"Location7" forKey:@"7"];
     [imageIdDict setObject:@"Location8" forKey:@"8"];
     [imageIdDict setObject:@"Location9" forKey:@"9"];
     [imageIdDict setObject:@"Location10" forKey:@"10"];
     [imageIdDict setObject:@"Location11" forKey:@"11"];
     [imageIdDict setObject:@"Location12" forKey:@"12"];
     [imageIdDict setObject:@"Location13" forKey:@"13"];
     [imageIdDict setObject:@"Location14" forKey:@"14"];
     [imageIdDict setObject:@"Location15" forKey:@"15"];
    
    //Best Accuracy
    if([accuracyfactor isEqualToString:@"best"])
        {
            self.location.desiredAccuracy=kCLLocationAccuracyBest;
            self.location.distanceFilter=kCLLocationAccuracyBest;
        }
    //Accuracy upto 10 meter
    else if ([accuracyfactor isEqualToString:@"10m"])
    {
        self.location.desiredAccuracy=kCLLocationAccuracyNearestTenMeters;
        self.location.distanceFilter=kCLLocationAccuracyNearestTenMeters;
    }
    //Accuracy upto 100 meter
    else if ([accuracyfactor isEqualToString:@"100m"])
    {
        self.location.desiredAccuracy=kCLLocationAccuracyHundredMeters;
        self.location.distanceFilter=kCLLocationAccuracyHundredMeters;
    }
    geocoder=[[CLGeocoder alloc]init];
    addressarray=[[NSMutableArray alloc]init];
    latsarray=[[NSMutableArray alloc]init];
    longsarray=[[NSMutableArray alloc]init];
    accountarray=[[NSMutableArray alloc]init];

    [self.location startUpdatingLocation];
    self.tableview2.scrollEnabled = NO;
    [tableview2 reloadData];
    countrecords=0;
    count=0;
    count1=0;
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //Assign the last updated value to current location
    currentLocation = (CLLocation *)[locations lastObject];
    
    // Assign Geographic Coordinate to variables
    // Work around a bug in MapKit where user location is not initially zoomed to.
	if (currentLocation != nil) {
		// Zoom to the current user location.
		MKCoordinateRegion userLocation = MKCoordinateRegionMakeWithDistance(currentLocation.coordinate, 500.0, 500.0);
		[mapview setRegion:userLocation animated:YES];
	}
    
    [location stopUpdatingLocation];
    self.location.delegate=nil;
    
    [self populatedatabase];
    
}

    
    
-(void)populatedatabase
    {
    
    if([accuracyfactor isEqualToString:@"best"])
    {   //displays circular region 
        MKCircle *circle = [MKCircle circleWithCenterCoordinate:currentLocation.coordinate radius:75];
        [self.mapview addOverlay:circle];
    }
    
    if([accuracyfactor isEqualToString:@"10m"])
    {
        MKCircle *circle = [MKCircle circleWithCenterCoordinate:currentLocation.coordinate radius:100];
        [self.mapview addOverlay:circle];
    }
    if([accuracyfactor isEqualToString:@"100m"])
    {
        MKCircle *circle = [MKCircle circleWithCenterCoordinate:currentLocation.coordinate radius:150];
        [self.mapview addOverlay:circle];
    }

    //current user location
    CLLocation *locA = [[CLLocation alloc] initWithLatitude:currentLocation.coordinate.latitude longitude:currentLocation.coordinate.longitude];
    //get all the locations from DB
    NSArray *locationInfo = [[LocationDatabase database] getAllLocations];
    //loop through each of the location to find if they are within the circular region
    for (LocationInfo *locx in locationInfo) {
        
       CLLocation *locB = [[CLLocation alloc] initWithLatitude:locx.latitude longitude:locx.longitude];
        //get the distance current user location from the location present in DB
       CLLocationDistance distance = [locA distanceFromLocation:locB];
        
       NSLog(@"distance is %f",distance);
       
        if([accuracyfactor isEqualToString:@"best"])
        {
            
        if(distance < 25.0)
        {
            [addressarray addObject:locx.address];
            [accountarray addObject:locx.accountno];
            
            CLLocationCoordinate2D cord;
            cord.latitude=locx.latitude;
            cord.longitude=locx.longitude;
            
            NSString *latitudeString = [NSString stringWithFormat:@"%f",cord.latitude];
            NSString *longitudeString = [NSString stringWithFormat:@"%f",cord.longitude];
            
            [latsarray addObject:latitudeString];
            [longsarray addObject:longitudeString];
        }
            
        }
        
        if([accuracyfactor isEqualToString:@"10m"])
        {
            
            if(distance < 50.0)
            {
                [addressarray addObject:locx.address];
                [accountarray addObject:locx.accountno];
                CLLocationCoordinate2D cord;
                cord.latitude=locx.latitude;
                cord.longitude=locx.longitude;
                
                NSString *latitudeString = [NSString stringWithFormat:@"%f",cord.latitude];
                NSString *longitudeString = [NSString stringWithFormat:@"%f",cord.longitude];
                
                [latsarray addObject:latitudeString];
                [longsarray addObject:longitudeString];
            }
            
        }
        if([accuracyfactor isEqualToString:@"100m"])
        {
            
            if(distance < 100.0)
            {
                [addressarray addObject:locx.address];
                [accountarray addObject:locx.accountno];
                [tableview2 reloadData];
                CLLocationCoordinate2D cord;
                cord.latitude=locx.latitude;
                cord.longitude=locx.longitude;
                
                NSString *latitudeString = [NSString stringWithFormat:@"%f",cord.latitude];
                NSString *longitudeString = [NSString stringWithFormat:@"%f",cord.longitude];
                
                [latsarray addObject:latitudeString];
                [longsarray addObject:longitudeString];
            }
            
        }
        
    }
   
   NSLog(@" length of address array is %d",[addressarray count]);
    
    count=[addressarray count];
    [tableview2 reloadData];

}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSString *errorType = (error.code == kCLErrorDenied) ? @"Access Denied" : @"Unknown Error";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error getting location" message:errorType delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    [alert show];
}

//Replaces all the annotaions present on the map by images
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{

    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    Annotations *myAnn = (Annotations *)annotation;
    CustomAnnotationView *customAnnotationView=(CustomAnnotationView *) [self.mapview dequeueReusableAnnotationViewWithIdentifier:myAnn.annotationId];
    if(!customAnnotationView)
    {
        NSLog(@" Reuse Id is: %@, image name is: %@",myAnn.annotationId,[imageIdDict objectForKey:myAnn.annotationId]);
        customAnnotationView=[[CustomAnnotationView alloc] initWithAnnotationWithImage:annotation reuseIdentifier:myAnn.annotationId annotationViewImage:[UIImage imageNamed:[imageIdDict objectForKey:myAnn.annotationId]]];
        
        customAnnotationView.canShowCallout=YES;
    }
    return customAnnotationView;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger num;
    
    if([addressarray count]<6)
    {
         num=[addressarray count];
        
    }else {
       num=6;
    }
    return num;
}
//Displaying the circular region 
- (MKOverlayView *)mapView:(MKMapView *)map viewForOverlay:(id <MKOverlay>)overlay
{
    MKCircleView *circleView = [[MKCircleView alloc] initWithOverlay:overlay];
    circleView.strokeColor = [UIColor blueColor];
    circleView.fillColor = [[UIColor blueColor] colorWithAlphaComponent:0.05];
    circleView.lineWidth = 1.5;
    return circleView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView2 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableview2 dequeueReusableCellWithIdentifier:@"Maincell"];
    
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Maincell"];
    }
    
    if(count>=1)
    {
        if((indexPath.row==5))
        {
            if (count>=1) {
                
                NSLog(@"count is %d-------",count);
                
                cell.textLabel.text=@"More addresses";
            }
        }else{
            
            addressNumber=countrecords+1;
            NSString *tableRow = [NSString stringWithFormat:@"%d. ", addressNumber];
            cell.textLabel.text=[tableRow stringByAppendingString:[addressarray objectAtIndex:countrecords]];
            NSLog(@" countrecords value is %d and count value is %d",countrecords,count);
            countrecords++;
            count--;
        }
        
    }else{
        cell.textLabel.text=@" ";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.userInteractionEnabled = NO;
    }
    //displaying annotations at the address specified
    CLLocationCoordinate2D cord;
    cord.latitude=[[latsarray objectAtIndex:countrecords-1] doubleValue];
    cord.longitude=[[longsarray objectAtIndex:countrecords-1] doubleValue];
    CLLocation *annLoc=[[CLLocation alloc] initWithLatitude:cord.latitude longitude:cord.longitude];
    myannotation=[Annotations alloc];
    myannotation.coordinate=annLoc.coordinate;
    myannotation.title=[addressarray objectAtIndex:countrecords-1];
    myannotation.annotationId=[annId objectAtIndex:countrecords-1];
    [self.mapview addAnnotation:myannotation];
    [annArray addObject:myannotation];
   
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
 
    if([cell.textLabel.text isEqualToString:@"More addresses"] )
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
         NSMutableArray *tempArray = [[NSMutableArray alloc] init];
      
         for (int i=0; i<6; i++) {
            [tempArray addObject:[NSIndexPath indexPathForRow:i inSection:0]];
         }
        
         NSLog(@" countrecords value is --------- %d",countrecords);
        
        if (count>=1) {
            //removes all the annotations present on the map
            [self.mapview removeAnnotations:self.mapview.annotations];
            [tableView beginUpdates];
            [tableView deleteRowsAtIndexPaths:tempArray withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:tempArray withRowAnimation:UITableViewRowAnimationFade];
            [tableView endUpdates];
        }
    }
    
    else{
        
        LastScreen *ls=[self.storyboard instantiateViewControllerWithIdentifier:@"LastScreen"];
        ls.viewcell=cell;
        ls.accno=[accountarray objectAtIndex:indexPath.row];
        ls.lats=[latsarray objectAtIndex:indexPath.row];
        ls.longs=[longsarray objectAtIndex:indexPath.row];
        ls.address=[addressarray objectAtIndex:indexPath.row];
        ls.accuracy=accuracyfactor;
        [self presentViewController:ls animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    
    FirstViewController *fvc=[self.storyboard instantiateViewControllerWithIdentifier:@"FirstViewController"];
    [self presentViewController:fvc animated:YES completion:nil];
    
}
@end
