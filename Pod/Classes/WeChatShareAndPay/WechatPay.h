//
//  WechatPay.h
//  XTWebView
//
//  Created by abc on 31/3/16.
//  Copyright © 2016年 com.xiangtian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface WechatPay : NSObject

@property (nonatomic, strong) JSContext *jsContext;

- (void)payByWeChat:(JSValue *)jsDic;//微信支付

@end
