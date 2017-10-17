//
//  Config.m
//  MDRatio
//
//  Created by fhkvsou on 2017/10/12.
//  Copyright © 2017年 fhkvsou. All rights reserved.
//

#import "Config.h"

@implementation Config

+ (instancetype)shareConfig{
    static Config * _config = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_config) {
            _config = [[self alloc]init];
            [_config updateServers];
        }
    });
    return _config;
}

- (void)updateServers{
    NSDictionary * configureInfo = [[NSBundle mainBundle]objectForInfoDictionaryKey:@"MDSInfoConfigurations"];
    if ([configureInfo isKindOfClass:[NSDictionary class]]) {
        _serverAddress = [configureInfo objectForKey:@"MDSServerAddress"];
    }
}

@end
