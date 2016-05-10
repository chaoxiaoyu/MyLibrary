//
//  XTWebView.m
//  XTWebView
//
//  Created by abc on 24/3/16.
//  Copyright © 2016年 com.xiangtian. All rights reserved.
//
//http://zhidao.baidu.com/link?url=0_IF0vuHOODM55HNtPjpbewEH3LHgpvGaurJ6DKGe0aQiNZWFdcDwL0xXlVfNW6LNW1f00D4E-ErzHAkSnYWcbIoG6ZnFsOCQaCnE7tzuqq


#import "XTWebView.h"
#import "MBProgressHUD.h"
#import "WXAPI.h"
#import "NextViewController.h"
#import "AlipaySDK/AlipaySDK.h"
#import "CustomURLCache.h"

@implementation XTWebView

-(id)initWithFrame:(CGRect)frame
{
      if (self = [super initWithFrame:frame])
      {
            self.delegate = self;
            
      }
      return self;
}

//- (void)showInformation:(NSString *)information withTime:(NSNumber *)time
//{
//      if([time doubleValue] > 0)
//      {
////            __block UILabel *label;
//            self.scrollView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
//            [UIView animateWithDuration:3.0f animations:^{
//                  UILabel*label = [[UILabel alloc] initWithFrame:CGRectMake(-90, 0, self.frame.size.width, -10)];
//                  [self addSubview:label];
//                  label.text = information;
//                  label.backgroundColor = [UIColor redColor];
//                  
//            }];
////            [label removeFromSuperview];
//      }
//      else if ([time doubleValue] == -1)
//      {
//            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(-90, 0, self.frame.size.width, -10)];
//            [self addSubview:label];
//            label.text = information;
//      }
//      
//}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
      [MBProgressHUD showHUDAddedTo:self animated:YES];

      return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
      
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
      [MBProgressHUD hideHUDForView:self animated:YES];
//      self.manager = [[JSExportsManager alloc] init];
//      self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//      self.jsContext[@"XTWebView"] = _manager;
//      _manager.jsContext = self.jsContext;
//      
//      XTWebViewController *controller = [self viewController];
////      self.jsContext[@"XTWebViewController"] = controller;
//      _manager.delegate = controller;
//      
////      _manager.delegate = self;
//      controller.jsContext = self.jsContext;
      
//      self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
//            context.exception = exceptionValue;
//            NSLog(@"异常信息：%@", exceptionValue);
//      };
      
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
      [MBProgressHUD hideHUDForView:self animated:YES];
      NSLog(@"error = %@",error);
}

- (XTWebViewController *)viewController {
      for (UIView *next = [self superview]; next; next = next.superview)
      {
            UIResponder *nextResponder = [next nextResponder];
            if ([nextResponder isKindOfClass:[XTWebViewController class]])
            {
                  return (XTWebViewController *)nextResponder;
            }
      }
      return nil;
}

//- (void)payByWeChat  //微信支付
//{
//      NSLog(@"payByWeChat");
//      
//      PayReq *req = [[PayReq alloc] init];
//      JSValue *jsWeixinPay = self.jsContext[@"weixinPay"];
//      JSValue *jsDic = [jsWeixinPay callWithArguments:nil];
//      NSDictionary *dic = [jsDic toDictionary];
//      req.partnerId = dic[@"partnerId"];
//      req.prepayId = dic[@"prepayId"];
//      req.nonceStr = dic[@"nonceStr"];
//      req.timeStamp = [jsDic[@"timeStamp"] toUInt32];
//      req.package = dic[@"package"];
//      req.sign = dic[@"sign"];
//      
//      [WXApi sendReq:req];
//}
//
//- (void)payByAlipay  //支付宝快捷支付
//{
//      NSLog(@"payByAlipay");
//      JSValue *jsOrderStr = self.jsContext[@"Alipay"];
//      NSString *orderStr = [[jsOrderStr callWithArguments:nil] toString];
//      [[AlipaySDK defaultService] payOrder:orderStr fromScheme:@"zxcv" callback:^(NSDictionary *resultDic) {
//            NSString *resultStr = nil;
//            if ([resultDic[@"resultStatus"] isEqualToString:@"9000"])
//            {
//                  resultStr = @"订单支付成功";
//            }
//            
//            if ([resultDic[@"resultStatus"] isEqualToString:@"8000"])
//            {
//                  resultStr = @"正在处理中！";
//            }
//            
//            if ([resultDic[@"resultStatus"] isEqualToString:@"4000"])
//            {
//                  resultStr = @"订单支付失败！";
//            }
//            
//            if ([resultDic[@"resultStatus"] isEqualToString:@"6001"])
//            {
//                  resultStr = @"用户中途取消！";
//            }
//            
//            if ([resultDic[@"resultStatus"] isEqualToString:@"6002"])
//            {
//                  resultStr = @"网络连接出错！";
//            }
//            
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"支付结果" message:resultStr delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alertView show];
//      }];
//}
//
//- (void)scanQRcode  //扫描二维码
//{
//      NSLog(@"scanQRcode");
//      
//}
//
//- (void)openInNewWindow
//{
//      _openNewWindow = YES;
//      if (self.myDelegate && [self.myDelegate respondsToSelector:@selector(openNewWindowInController)])
//      {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                  [self.myDelegate openNewWindowInController];//主线程处理，否则会出现This application is modifying the autolayout engine from a background thread, which can lead to engine corruption and weird crashes.  This will cause an exception in a future release问题
//            });
//            
//      }
//}

@end
