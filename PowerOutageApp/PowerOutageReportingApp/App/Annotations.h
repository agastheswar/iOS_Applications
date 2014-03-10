//
//  Annotations.h
//  MapswithLocation
//
//  Created by iFactor iProject Team Spr 2013 on 4/29/13.
//  Copyright (c) 2013 iFactor iProject Team Spr 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Annotations : MKPinAnnotationView <MKAnnotation>
{
    CLLocationCoordinate2D coordinate;
    UIImage *imageForMyAnnotation;
}


@property(nonatomic,assign) CLLocationCoordinate2D coordinate;
@property (nonatomic,retain) UIImage *imageForMyAnnotation;
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString *subtitle;
@property(nonatomic)NSString *annotationId;


@end

