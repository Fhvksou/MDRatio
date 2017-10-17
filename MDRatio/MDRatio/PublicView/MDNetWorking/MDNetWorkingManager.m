//
//  MDNetWorkingManager.m
//  MDRatio
//
//  Created by fhkvsou on 2017/10/12.
//  Copyright © 2017年 fhkvsou. All rights reserved.
//

#import "MDNetWorkingManager.h"

static MDNetWorkingManager * _manager = nil;

NSString * const kPageWillDeallocInManager = @"kPageWillDeallocInManager";

@interface MDNetWorkingManager ()<NetWorkTaskDelegate>
    
@property (nonatomic ,strong) NSMutableArray * noTipUrls;
    
@property (nonatomic ,strong) NSMutableArray * mdTasks;

@property (nonatomic, assign) BOOL isMonitorNetworkStatus;

@property (nonatomic ,strong) HttpHeadData * headerData;

@end

@implementation MDNetWorkingManager

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)registerNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didPageWillDealloc:)
                                                 name:kPageWillDeallocInManager object:nil];
}

- (void)didPageWillDealloc:(NSNotification*)aNotification{
    NSString *pageId = aNotification.object;
    if ([pageId isKindOfClass:[NSString class]]) {
        [self cancelTask:pageId];
    }
}

+ (instancetype)shareManager{
    if (!_manager) {
        [self registerNetWorkWithBaseUrl:nil];
    }
    return _manager;
}
    
+ (void)registerNetWorkWithBaseUrl:(NSString *)baseUrl{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfiguration.HTTPMaximumConnectionsPerHost = 10;
        
        _manager = [[self alloc]initWithBaseURL:[NSURL URLWithString:baseUrl] sessionConfiguration:sessionConfiguration];
        
        [_manager registerNotification];
        
        // 设置请求头
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [_manager.requestSerializer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
        [_manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        
        // 设置响应方式
        _manager.responseSerializer  = [AFHTTPResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes =  [_manager.responseSerializer.acceptableContentTypes setByAddingObjectsFromSet:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain",@"application/atom+xml",@"application/xml",@"text/xml",nil]];
    });
}
    
+ (void)startMonitoring{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}
    
+ (void)registerTimeoutIntervalForRequest:(NSTimeInterval)timeoutIntervalForRequest{
    [MDNetWorkingManager shareManager].requestSerializer.timeoutInterval = timeoutIntervalForRequest;
}

- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field{
    [[MDNetWorkingManager shareManager].requestSerializer setValue:value forHTTPHeaderField:field];
}

- (void)updateHttpHeaderPageName:(NSString *)pageName{
    [MDNetWorkingManager shareManager].headerData.pageName = pageName;
}
    
+ (void)setNoTipsWhenFailedUrls:(NSArray *)Urls{
    [[MDNetWorkingManager shareManager].noTipUrls addObjectsFromArray:Urls];
}
    
+ (void)addNoTipsWhenFailedUrl:(NSString *)Url{
    [[MDNetWorkingManager shareManager].noTipUrls addObject:Url];
}
    
+ (void)setIsMonitorNetworkStatus:(BOOL)isMonitorNetworkStatus {
    [MDNetWorkingManager shareManager].isMonitorNetworkStatus = isMonitorNetworkStatus;
    if (isMonitorNetworkStatus) {
        [self startMonitoring];
    }
}
    
#pragma mark ------------私有方法-------------------
    
- (void)post:(NetWorkRequest *)request{
    NetWorkTask * task = [[NetWorkTask alloc]init];
    task.request = request;
    task.delegate = self;
    [self addTask:task];
}

- (void)addTask:(NetWorkTask *)task{
    [task start];
    [self.mdTasks addObject:task];
}

- (void)removeTask:(NSString *)taskId{
    NSMutableArray * removeTasks = [NSMutableArray array];
    for (NetWorkTask * task in self.mdTasks) {
        if ([[task taskIdentifier] isEqualToString:taskId]){
            [removeTasks addObject:task];
        }
    }
    
    for (NetWorkTask * task in removeTasks) {
        [self.mdTasks removeObject:task];
    }
}

- (void)cancelTask:(NSString *)pageId{
    if (pageId == nil || pageId.length <= 0){
        return;
    }
    NSMutableArray * cancelTasks = [NSMutableArray array];
    for (NetWorkTask * cancelTask in self.mdTasks) {
        if ([pageId isEqualToString:cancelTask.request.pageId]){
            [cancelTasks addObject:cancelTask];
            [cancelTask.task cancel];
        }
    }
    
    for (NetWorkTask * task in cancelTasks) {
        [self.mdTasks removeObject:task];
    }
}

- (void)progressTaskSuccess:(NetWorkTask *)task{
    
    NetWorkResponse * response = task.response;
    NSInteger code = response.code;
    
    if (response && code == 0) {
        if (response.request.httpResult) {
            response.request.httpResult(YES, response);
        }
        return;
    }
    
    if (response.request.httpResult) {
        response.request.httpResult(NO, response);
    }
}

#pragma mark NetWorkTaskDelegate

- (void)didTaskSuccess:(NetWorkTask *)task{
    [self progressTaskSuccess:task];
    [self removeTask:[task taskIdentifier]];
}
    
- (void)didTaskError:(NetWorkTask *)task{
    
    NetWorkResponse *response = task.response;
    if (response.request.httpResult) {
        response.request.httpResult(NO, response);
    }
    
    [self removeTask:[task taskIdentifier]];
}
    
- (HttpHeadData *)headerData{
    if (!_headerData){
        _headerData = [[HttpHeadData alloc]init];
    }
    return _headerData;
}
    
- (NSMutableArray *)noTipUrls{
    if (!_noTipUrls){
        _noTipUrls = [[NSMutableArray alloc]init];
    }
    return _noTipUrls;
}
    
- (NSMutableArray *)mdTasks{
    if (!_mdTasks){
        _mdTasks = [[NSMutableArray alloc]init];
    }
    return _mdTasks;
}
    
@end
