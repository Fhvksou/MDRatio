//
//  NitPickViewController.m
//  MDNitpick
//
//  Created by fhkvsou on 2017/9/22.
//  Copyright © 2017年 fhkvsou. All rights reserved.
//

#import "NitPickViewController.h"

@interface NitPickViewController ()

@property (nonatomic ,strong) NitpickView * nitpickView;
@end

@implementation NitPickViewController

- (instancetype)initWithView:(NitpickView *)view{
    if (self = [super init]) {
        _nitpickView = view;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registPushSubject];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.nitpickView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)registPushSubject{
    @weakify(self);
    [self.nitpickView.viewModel.pushSubject subscribeNext:^(NitpickView * x) {
        @strongify(self);
        NitPickViewController * vc = [[NitPickViewController alloc]initWithView:x];
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

- (void)dealloc{
    NSLog(@"%@已经被释放了",NSStringFromClass([self class]));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
