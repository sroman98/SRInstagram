//
//  DetailsViewController.h
//  SRInstagram
//
//  Created by sroman98 on 7/10/19.
//  Copyright © 2019 sroman98. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController

@property (nonatomic, strong) Post *post;

@end

NS_ASSUME_NONNULL_END
