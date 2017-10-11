//
//  NitpickView.m
//  MDNitpick
//
//  Created by fhkvsou on 2017/9/22.
//  Copyright © 2017年 fhkvsou. All rights reserved.
//

#import "NitpickView.h"

@interface NitpickView ()

@end

@implementation NitpickView

- (instancetype)init{
    if (self = [super init]) {

    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)requestNetWork{
    [self.viewModel.requestSubject execute:nil];
}

- (void)pushViewController:(NitpickView *)view{
    [self.viewModel.pushSubject sendNext:view];
}

#pragma mark  -------------------------------LazyLoad--------------------------------------

- (NitpickViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[NitpickViewModel alloc]init];
    }
    return _viewModel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
