//
//  NetWorkRequest.h
//  MDRatio
//
//  Created by fhkvsou on 2017/10/12.
//  Copyright © 2017年 fhkvsou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetWorkResponse.h"

@class NetWorkRequest;

typedef void (^MDHttpResult)(BOOL success, NetWorkResponse *response);

@interface NetWorkRequest : NSObject
    
/**接口名字 */
@property (nonatomic, strong) NSString *url;
    
/**请求参数 */
@property (nonatomic, strong) NSDictionary *params;

/**失败重试次数，超时的时候会判断，业务失败不做重试 */
@property (nonatomic, assign) NSInteger retryCount;
    
/**失败重试最大数，默认为1 */
@property (nonatomic, assign) NSInteger retryTotal;
    
/**页面标识符，用于页面dealloc时，cancel请求 */
@property (nonatomic ,copy) NSString * pageId;

@property (nonatomic, copy)MDHttpResult httpResult;

+ (NetWorkRequest *)requestWithUrl:(NSString *)url params:(NSDictionary *)params pageId:(NSString *)pageId result:(MDHttpResult)result;

@end
