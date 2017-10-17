//
//  MDNetWorkingManager.h
//  MDRatio
//
//  Created by fhkvsou on 2017/10/12.
//  Copyright © 2017年 fhkvsou. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "HttpHeadData.h"
#import "NetWorkTask.h"
#import "NetWorkRequest.h"

#define MD_NETWORK_NOT_REACHABILITY (-888888)

@interface MDNetWorkingManager : AFHTTPSessionManager

@property (nonatomic ,strong ,readonly) HttpHeadData * headerData;

@property (nonatomic, assign ,readonly) BOOL isMonitorNetworkStatus;

/****获取实例 */
+ (instancetype)shareManager;
    
/****注册BaseUrl */
+ (void)registerNetWorkWithBaseUrl:(NSString *)baseUrl;

+ (void)registerTimeoutIntervalForRequest:(NSTimeInterval)timeoutIntervalForRequest;

/****开启网络状态监控 */
+ (void)startMonitoring;
    
/****设置HTTP头 */
- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field;
   
/****POST请求 */
- (void)post:(NetWorkRequest *)request;

/****Other */
- (void)updateHttpHeaderPageName:(NSString *)pageName;
    
+ (void)setNoTipsWhenFailedUrls:(NSArray *)Urls;
+ (void)addNoTipsWhenFailedUrl:(NSString *)Url;
+ (void)setIsMonitorNetworkStatus:(BOOL)isMonitorNetworkStatus;

@end
