//
//  NitpickViewModel.m
//  MDNitpick
//
//  Created by fhkvsou on 2017/9/22.
//  Copyright © 2017年 fhkvsou. All rights reserved.
//

#import "NitpickViewModel.h"
#import "NitpickNetHelper.h"

@interface NitpickViewModel ()

@end

@implementation NitpickViewModel

- (instancetype)init{
    if (self = [super init]) {
        [self registRequestComplete];
    }
    return self;
}

- (void)registRequestComplete{
    [self.requestSubject.executionSignals.switchToLatest subscribeNext:^(id x) {
        [self.updateSubject sendNext:x];
    }];
}

#pragma mark  -------------------------------LazyLoad--------------------------------------

- (RACSubject *)updateSubject{
    if (!_updateSubject) {
        _updateSubject = [RACSubject subject];
    }
    return _updateSubject;
}

- (RACSubject *)pushSubject{
    if (!_pushSubject) {
        _pushSubject = [RACSubject subject];
    }
    return _pushSubject;
}

- (RACCommand *)requestSubject{
    if (!_requestSubject) {
        _requestSubject = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [[MDNetWorkManager sharedManager]post:[MDRequest requestWith:@"" params:@{} paramType:1 result:^(BOOL success, MDResponse *response) {
                    NitpickNetHelper * netHelper = [[NitpickNetHelper alloc]init];
                    netHelper.success = success;
                    netHelper.response = response;
                    [subscriber sendNext:response.responseData];
                    [subscriber sendCompleted];
                }]];
                return nil;
            }];
        }];
    }
    return _requestSubject;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
