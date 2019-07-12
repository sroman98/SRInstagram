//
//  PostCell.m
//  SRInstagram
//
//  Created by sroman98 on 7/9/19.
//  Copyright © 2019 sroman98. All rights reserved.
//

#import "PostCell.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCell:(Post *)post {
    self.post = post;
    
    self.postImageView.file = post[@"image"];
    [self.postImageView loadInBackground];
    self.captionLabel.text = post.caption;
    
    PFUser *author = post.author;
    NSString *username = author.username;
    self.usernameLabel.text = [NSString stringWithFormat:@"@%@", username];
    
    self.profilePicImageView.file = author[@"image"];
    [self.profilePicImageView loadInBackground];
}

@end
