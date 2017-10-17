//
//  NetWorkTask.h
//  MDRatio
//
//  Created by fhkvsou on 2017/10/12.
//  Copyright © 2017年 fhkvsou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpHeadData.h"
#import "NetWorkRequest.h"
#import "NetWorkResponse.h"

@class NetWorkTask;
@protocol NetWorkTaskDelegate <NSObject>
    
- (void)didTaskSuccess:(NetWorkTask *)task;
    
- (void)didTaskError:(NetWorkTask *)task;
    
@end

@interface NetWorkTask : NSObject

@property (nonatomic, strong) NSURLSessionTask *task;

@property (nonatomic ,strong) NetWorkRequest * request;

@property (nonatomic ,strong) NetWorkResponse * response;

@property (nonatomic ,strong) id<NetWorkTaskDelegate> delegate;
    
- (void)start;

/**每个任务的唯一标识 */
- (NSString *)taskIdentifier;

@end
