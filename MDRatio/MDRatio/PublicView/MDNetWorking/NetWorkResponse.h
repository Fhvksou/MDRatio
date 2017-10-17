//
//  NetWorkResponse.h
//  MDRatio
//
//  Created by fhkvsou on 2017/10/12.
//  Copyright © 2017年 fhkvsou. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NetWorkRequest;

@interface NetWorkResponse : NSObject

/**原始数据字典 */
@property (nonatomic, strong) NSDictionary *responseData;

/**data数据 */
@property (nonatomic, strong) id data;

/**状态码 */
@property (nonatomic, assign) NSInteger code;
    
/**状态信息 */
@property (nonatomic, strong) NSString *msg;
    
/**参数 */
@property (nonatomic, strong) NetWorkRequest *request;

@end
