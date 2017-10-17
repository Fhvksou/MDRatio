//
//  Config.h
//  MDRatio
//
//  Created by fhkvsou on 2017/10/12.
//  Copyright © 2017年 fhkvsou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Config : NSObject

@property (nonatomic ,copy) NSString * serverAddress;

@property (nonatomic ,copy) NSString * version;

+ (instancetype)shareConfig;

@end
