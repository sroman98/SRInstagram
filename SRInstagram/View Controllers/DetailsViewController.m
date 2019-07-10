//
//  DetailsViewController.m
//  SRInstagram
//
//  Created by sroman98 on 7/10/19.
//  Copyright © 2019 sroman98. All rights reserved.
//

#import "DetailsViewController.h"
#import "NSDate+DateTools.h"
@import Parse;

@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet PFImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *username;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.photoImageView.file = self.post[@"image"];
    [self.photoImageView loadInBackground];
    self.captionLabel.text = self.post.caption;
    PFUser *author = self.post.author;
    NSString *username = author.username;
    self.username.text = [NSString stringWithFormat:@"@%@", username];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // Configure the input format to parse the date string
    formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    // Convert String to Date
    NSDate *date = self.post.createdAt;
    // Configure output format
    NSDate *timeAgoDate = [NSDate dateWithTimeInterval:0 sinceDate:date];
    // Convert Date to String
    self.createdAtLabel.text = timeAgoDate.shortTimeAgoSinceNow;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
