//
//  FirstViewController.h
//  iFactor
//
//  Created by iFactor iProject Team Spr 2013 on 4/29/13.
//  Copyright (c) 2013 iFactor iProject Team Spr 2013. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapViewController.h"


@interface FirstViewController : UIViewController<UIAlertViewDelegate>



@property (weak, nonatomic) IBOutlet UIButton *reportbutton;
- (IBAction)AccuracyBest:(id)sender;
- (IBAction)Accuracy10m:(id)sender;
- (IBAction)Accuracy100m:(id)sender;

@end
