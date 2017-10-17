//
//  NetWorkRequest.m
//  MDRatio
//
//  Created by fhkvsou on 2017/10/12.
//  Copyright © 2017年 fhkvsou. All rights reserved.
//

#import "NetWorkRequest.h"

@implementation NetWorkRequest
    
- (instancetype)init{
        self = [super init];
        if (self) {
            self.retryTotal = 1;
        }
        return self;
}

+ (NetWorkRequest *)requestWithUrl:(NSString *)url params:(NSDictionary *)params pageId:(NSString *)pageId result:(MDHttpResult)result{
    NetWorkRequest * request = [[NetWorkRequest alloc]init];
    request.url = url;
    request.params = params;
    request.pageId = pageId;
    request.httpResult = result;
    return request;
}
    
@end
