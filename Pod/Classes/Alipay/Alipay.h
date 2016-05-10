//
//  Alipay.h
//  XTWebView
//
//  Created by abc on 31/3/16.
//  Copyright © 2016年 com.xiangtian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AlipaySDK/AlipaySDK.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface Alipay : NSObject

@property(nonatomic, strong) JSContext *jsContext;
- (void)payByAlipay:(NSDictionary *)dic;

@end
