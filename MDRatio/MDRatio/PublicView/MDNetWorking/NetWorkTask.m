//
//  NetWorkTask.m
//  MDRatio
//
//  Created by fhkvsou on 2017/10/12.
//  Copyright © 2017年 fhkvsou. All rights reserved.
//

#import "NetWorkTask.h"

@implementation NetWorkTask
    
- (void)dealloc{
    self.delegate = nil;
}

- (void)start{
    self.request.retryCount++;

    if ([MDNetWorkingManager shareManager].isMonitorNetworkStatus){
        AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
        if (reachabilityManager.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
            NSError *error = [NSError errorWithDomain:@"当前网络不可用" code:MD_NETWORK_NOT_REACHABILITY userInfo:nil];
            [self requestFail:error];
            return;
        }
    }
    
    __weak NetWorkTask * weakSelf = self;
    NSURLSessionTask * task = [[MDNetWorkingManager shareManager]POST:self.request.url parameters:self.request.params progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf requestSuccess:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (weakSelf.request.retryCount < self.request.retryTotal) {
            [weakSelf start];
        } else {
            [weakSelf requestFail:error];
        }
    }];

    self.task = task;
}

- (NSString *)taskIdentifier{
    if (self.task){
        return [NSString stringWithFormat:@"%lu", (unsigned long)self.task.taskIdentifier];
    }
    return nil;
}

- (void)requestSuccess:(NSData *)responseObject{
    NSDictionary * info = [DataTurn JSONDataWithData:responseObject];
    
    _response = [self responseInfo:info];
    
    NSLog(@"============================接口返回日志分割线============================");
    NSLog(@"返回值:%@",[DataTurn toJSONData:info]);
    NSLog(@"调用的接口:%@,发送的数据:%@", self.request.url, [DataTurn toJSONData:self.request.params]);
    
    if (_delegate && [_delegate respondsToSelector:@selector(didTaskSuccess:)]) {
        [_delegate didTaskSuccess:self];
    }
}

- (NetWorkResponse *)responseInfo:(NSDictionary *)responseObject{
    NetWorkResponse * response = [[NetWorkResponse alloc]init];
    
    if (!responseObject || ![responseObject isKindOfClass:[NSDictionary class]]) {
        response.code = -1;
        response.request = self.request;
        return response;
    }
    
    NSInteger code = -1;
    NSString *message;
    id data;
    
    code = [responseObject[@"code"] integerValue];
    message = responseObject[@"message"];
    data = responseObject[@"data"];
    
    response.code = code;
    response.msg = message;
    response.data = data;
    response.responseData = responseObject;
    response.request = self.request;
    
    return response;
}

- (void)requestFail:(NSError *)error{
    
    _response = [self responseWithError:error];

    NSLog(@"============================非业务错误日志分割线============================");
    NSLog(@"返回值:%@",error.domain);
    NSLog(@"调用的接口:%@,发送的数据:%@", self.request.url, [DataTurn toJSONData:self.request.params]);
    
    if (_delegate && [_delegate respondsToSelector:@selector(didTaskError:)]) {
        [_delegate didTaskError:self];
    }
}

- (NetWorkResponse *)responseWithError:(NSError *)error
{
    NetWorkResponse *response = [[NetWorkResponse alloc] init];
    response.code = error.code;
    response.request = self.request;
    response.msg = @"";
    return response;
}

@end
