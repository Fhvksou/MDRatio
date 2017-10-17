//
//  LaunchViewController.h
//  MDRatio
//
//  Created by fhkvsou on 2017/10/13.
//  Copyright © 2017年 fhkvsou. All rights reserved.
//

#import "BaseViewController.h"

@protocol LaunchViewControllerDelegate <NSObject>

- (void)dismissLaunchViewController;

@end

@interface LaunchViewController : BaseViewController

@property (nonatomic ,weak) id<LaunchViewControllerDelegate> delegate;

@end
