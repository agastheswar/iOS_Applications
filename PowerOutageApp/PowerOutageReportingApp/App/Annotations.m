//
//  Annotations.m
//  MapswithLocation
//
//  Created by iFactor iProject Team Spr 2013 on 4/29/13.
//  Copyright (c) 2013 iFactor iProject Team Spr 2013. All rights reserved.
//

#import "Annotations.h"

//@implementation Annotations
//
//@synthesize subtitle,title,coordinate;
//
//@end
@implementation Annotations

@synthesize subtitle,title,coordinate,imageForMyAnnotation,annotationId;

- (CLLocationCoordinate2D)coordinate
{
    return coordinate;
}

- (UIImage *)imageForMyAnnotation{
    return imageForMyAnnotation;
}

// optional
- (NSString *)title
{
    return title;
}
- (NSString *)subtitle
{
    return subtitle;
}

@end