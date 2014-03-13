//
//  youtubeData.m
//  test
//
//  Created by asuribha on 2/4/14.
//  Copyright (c) 2014 asuribha. All rights reserved.
//

#import "youtubeData.h"
#import "GTLYouTube.h"

@interface youtubeData ()

@end

@implementation youtubeData{
    NSMutableArray *thumbnailarray;
    NSMutableArray *title;
    NSMutableArray *playerurl;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    NSURL *videoURL = [NSURL URLWithString:@"https://gdata.youtube.com/feeds/api/videos?q=football+-soccer&orderby=published&start-index=11&max-results=10&v=2&alt=jsonc"];
    
    NSData *jsonData = [NSData dataWithContentsOfURL:videoURL];
    
    NSError *error = nil;
    
    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    NSMutableArray *dataarray = [[dataDictionary valueForKey:@"data"] valueForKey:@"items"];
    
    NSLog(@"%@", dataarray);
    
    
    thumbnailarray = [[dataarray valueForKey:@"thumbnail"] valueForKey:@"sqDefault"];
    
    title = [dataarray valueForKey:@"title"];
    
    playerurl= [[dataarray valueForKey:@"player"]valueForKey:@"mobile"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [thumbnailarray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSURL *url = [[NSURL alloc] initWithString:[thumbnailarray objectAtIndex:indexPath.row]];
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:imageData];
    
    cell.textLabel.text = [title objectAtIndex:indexPath.row];
    cell.imageView.image = image;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *url = [playerurl objectAtIndex:indexPath.row];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

@end
