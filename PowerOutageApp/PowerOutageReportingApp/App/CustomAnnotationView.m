//
//  CustomAnnotationView.m
//  iFactor
//
//  Created by iFactor iProject Team Spr 2013 on 4/29/13.
//  Copyright (c) 2013 iFactor iProject Team Spr 2013. All rights reserved.
//

#import "CustomAnnotationView.h"

@implementation CustomAnnotationView


-(id) initWithAnnotationWithImage:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier annotationViewImage:(UIImage *) anonViewImage
{
    self=[super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    self.image=anonViewImage;
    return self;
}

@end
