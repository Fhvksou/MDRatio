//
//  NitpickView.h
//  MDNitpick
//
//  Created by fhkvsou on 2017/9/22.
//  Copyright © 2017年 fhkvsou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NitpickViewModel.h"

typedef void (^requsetComplete)(id data);

@interface NitpickView : UIView

@property (nonatomic ,strong) NitpickViewModel * viewModel;

- (void)pushViewController:(NitpickView *)view;

- (void)requestNetWork:(requsetComplete)complete;

@end
