//
//  NitpickViewModel.h
//  MDNitpick
//
//  Created by fhkvsou on 2017/9/22.
//  Copyright © 2017年 fhkvsou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NitpickViewModel : UIView

@property (nonatomic ,strong) RACSubject * updateSubject;

@property (nonatomic ,strong) RACSubject * pushSubject;

@property (nonatomic ,strong) RACCommand * requestSubject;

@end
