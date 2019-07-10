//
//  ComposeViewController.h
//  SRInstagram
//
//  Created by sroman98 on 7/9/19.
//  Copyright © 2019 sroman98. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ComposeViewControllerDelegate

- (void)didPostImage:(UIImage *)photo withCaption:(NSString *)caption;

@end

@interface ComposeViewController : UIViewController

@property (nonatomic, weak) id<ComposeViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
