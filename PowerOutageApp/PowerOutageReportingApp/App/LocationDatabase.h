//
//  LocationDatabase.h
//  Testsql
//
//  Created by iFactor iProject Team Spr 2013 on 4/29/13.
//  Copyright (c) 2013 iFactor iProject Team Spr 2013. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "/usr/include/sqlite3.h"
@interface LocationDatabase : NSObject{
    sqlite3 *database;
    
}

+(LocationDatabase *)database;

-(NSArray *)getAllLocations;

@end
