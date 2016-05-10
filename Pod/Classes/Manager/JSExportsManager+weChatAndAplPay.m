//
//  JSExportsManager+weChatAndAplPay.m
//  XTWebView
//
//  Created by abc on 19/4/16.
//  Copyright © 2016年 com.xiangtian. All rights reserved.
//

#import "JSExportsManager+weChatAndAplPay.h"

@implementation JSExportsManager (weChatAndAplPay)

- (void)payByAlipay:(NSDictionary *)dic//支付宝支付
{
      Alipay *aliPay = [[Alipay alloc] init];
      aliPay.jsContext = self.jsContext;
      [aliPay payByAlipay:dic];
}

- (void)payByWeChat:(JSValue *)jsDic//微信支付
{
      WechatPay *weChatPay = [[WechatPay alloc] init];
      weChatPay.jsContext = self.jsContext;
      [weChatPay payByWeChat:jsDic];
}

@end
