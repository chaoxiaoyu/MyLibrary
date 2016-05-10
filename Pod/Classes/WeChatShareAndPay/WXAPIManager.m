//
//  WXAPIManager.m
//  XTWebView
//
//  Created by abc on 29/3/16.
//  Copyright © 2016年 com.xiangtian. All rights reserved.
//

#import "WXAPIManager.h"

@implementation WXAPIManager

+ (instancetype)sharedManager
{
      static dispatch_once_t onceToken;
      static WXAPIManager *sharedManager;
      dispatch_once(&onceToken, ^{
            sharedManager = [[WXAPIManager alloc] init];
      });
      return sharedManager;
}

-(void) onReq:(BaseReq*)req
{
      
}

-(void) onResp:(BaseResp*)resp
{
      if([resp isKindOfClass:[PayResp class]])
      {
            NSString *strTitle = [NSString stringWithFormat:@"支付结果"];
            NSString *resultMsg = nil;
            switch (resp.errCode) {
                  case WXSuccess:
                        resultMsg = [NSString stringWithFormat:@"支付成功！"];
                        break;
                        
                  default:
                        resultMsg = [NSString stringWithFormat:@"支付失败:errStr = %@",resp.errStr];
                        break;
            }
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:strTitle message:resultMsg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
      }
}

@end
