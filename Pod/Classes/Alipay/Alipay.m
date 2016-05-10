//
//  Alipay.m
//  XTWebView
//
//  Created by abc on 31/3/16.
//  Copyright © 2016年 com.xiangtian. All rights reserved.
//

#import "Alipay.h"

@implementation Alipay

- (void)payByAlipay:(NSDictionary *)dic  //支付宝快捷支付
{
      NSLog(@"payByAlipay");
//      JSValue *jsOrderStr = self.jsContext[@"Alipay"];
      NSString *orderStr = @"从dic拼接出的订单信息";
      [[AlipaySDK defaultService] payOrder:orderStr fromScheme:@"scheme" callback:^(NSDictionary *resultDic) {
            NSString *resultStr = nil;
            if ([resultDic[@"resultStatus"] isEqualToString:@"9000"])
            {
                  resultStr = @"订单支付成功";
            }
            
            if ([resultDic[@"resultStatus"] isEqualToString:@"8000"])
            {
                  resultStr = @"正在处理中！";
            }
            
            if ([resultDic[@"resultStatus"] isEqualToString:@"4000"])
            {
                  resultStr = @"订单支付失败！";
            }
            
            if ([resultDic[@"resultStatus"] isEqualToString:@"6001"])
            {
                  resultStr = @"用户中途取消！";
            }
            
            if ([resultDic[@"resultStatus"] isEqualToString:@"6002"])
            {
                  resultStr = @"网络连接出错！";
            }
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"支付结果" message:resultStr delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
      }];
}


@end
