//
//  ViewController.m
//  test
//
//  Created by asuribha on 2/4/14.
//  Copyright (c) 2014 asuribha. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)getVideos:(id)sender{
    youtubeData *ytd = [self.storyboard instantiateViewControllerWithIdentifier:@"youtubeData"];
    [self presentViewController:ytd animated:YES completion:nil];
}

@end
