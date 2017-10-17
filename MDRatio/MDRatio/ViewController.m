//
//  ViewController.m
//  MDRatio
//
//  Created by fhkvsou on 2017/10/11.
//  Copyright © 2017年 fhkvsou. All rights reserved.
//

#import "ViewController.h"
#import "LaunchViewController.h"

static UIViewController * viewController = nil;

@interface ViewController ()<LaunchViewControllerDelegate>

@property (nonatomic ,strong) UITabBarController * mainTabbarController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    viewController = self;
    
    [self configNav];
    
    [self addNotice];
    
    if ([self needShowLaunchView]) {
        [self loadLaunchView];
    }else{
        
    }
}

- (void)configNav{
    self.navigationBar.hidden = YES;
}

- (void)addNotice{
    
}

- (void)loadLaunchView{
    LaunchViewController * launchVc = [[LaunchViewController alloc]init];
    launchVc.delegate = self;
    [self setViewControllers:@[launchVc] animated:YES];
    [self setCurrentVersionToLocal];
}

- (void)requestAdvertisData{
    
}

//判断是否需要显示欢迎界面
- (BOOL)needShowLaunchView {
    NSString *localVersion = [self localVersion];
    NSString *currentVersion = [self currentVersion];
    if (localVersion.length == 0) {
        return YES;
    } else {
        if (![localVersion isEqualToString:currentVersion]) {
            return YES;
        }
    }
    return NO;
}

- (NSString *)localVersion {
    NSUserDefaults *projectUserDefaults = [NSUserDefaults standardUserDefaults];
    return [projectUserDefaults stringForKey:@"MDSTORE_LOCAL_VERSION"];
}

- (NSString *)currentVersion {
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return version;
}

- (void)setCurrentVersionToLocal {
    NSUserDefaults *projectUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString *currentVersion = [self currentVersion];
    
    [projectUserDefaults setObject:currentVersion forKey:@"MDSTORE_LOCAL_VERSION"];
    [projectUserDefaults synchronize];
}

#pragma mark Delegate

- (void)dismissLaunchViewController{
    [self requestAdvertisData];
    [self setViewControllers:@[_mainTabbarController] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
