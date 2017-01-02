//
//  WUOHTTPRequest.h
//  WUO
//
//  Created by mofeini on 17/1/2.
//  Copyright © 2017年 com.test.demo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XYNetworkRequest.h"

@class XYNetworkRequest;
@interface WUOHTTPRequest : NSObject

// 开启菊花
+ (void)setActivityIndicator:(BOOL)enabled;

+ (void)loginWithAccount:(NSString *)account pwd:(NSString *)pwd finished:(FinishedCallBack)finishedCallBack;

@end
