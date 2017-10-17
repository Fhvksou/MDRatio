//
//  BaseViewController.m
//  MDRatio
//
//  Created by fhkvsou on 2017/10/13.
//  Copyright © 2017年 fhkvsou. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self configContentView];
}

- (void)configContentView{
    _contentView = [[UIView alloc]init];
    _contentView.backgroundColor = [UIColor whiteColor];
    if (self.navigationController.navigationBar.hidden) {
        _contentView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    }else{
        _contentView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64);
    }
    [self.view addSubview:_contentView];
}

- (NSString *)memoryAddress{
    return [NSString stringWithFormat:@"%X", (unsigned int) self];
}

- (NSString *)pageName{
    return NSStringFromClass([self class]);
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]postNotificationName:kPageWillDealloc object:[self memoryAddress]];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
