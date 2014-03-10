//
//  LocationInfo.h
//  Testsql
//
//  Created by iFactor iProject Team Spr 2013 on 4/29/13.
//  Copyright (c) 2013 iFactor iProject Team Spr 2013. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationInfo : NSObject{
    NSString *accountno;
    float latitude;
    float longitude;
    NSString *address;
}

@property (nonatomic,copy) NSString *accountno;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,assign) float latitude;
@property (nonatomic,assign)float longitude;

-(id)initWithAccountNo:(NSString *)accountno latitude:(float)latitude longitude:(float)longitude address:(NSString *)address;

@end
