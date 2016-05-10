//
//  SharePayAndScanManager.m
//  XTWebView
//
//  Created by abc on 31/3/16.
//  Copyright © 2016年 com.xiangtian. All rights reserved.
//

#import "JSExportsManager.h"
#import "ScanViewController.h"

#import "ShareToWeiChat.h"
#import "ShareToWeChatfriends.h"
#import "ShareToQQ.h"
#import "ShareToQQZone.h"



@implementation JSExportsManager

//- (void)payByAlipay:(NSDictionary *)dic//支付宝支付
//{
//      Alipay *aliPay = [[Alipay alloc] init];
//      aliPay.jsContext = self.jsContext;
//      [aliPay payByAlipay:dic];
//}
//
//- (void)payByWeChat:(JSValue *)jsDic//微信支付
//{
//      WechatPay *weChatPay = [[WechatPay alloc] init];
//      weChatPay.jsContext = self.jsContext;
//      [weChatPay payByWeChat:jsDic];
//}


//- (void)shareWithTitle:(NSString *)title andDescription:(NSString *)description andImgURLStr:(NSString *)imgURLStr andURLStr:(NSString *)urlStr
//{
////      JSValue *jsShare = _webView.jsContext[@"share"];
////      JSValue *jsDic = [jsShare callWithArguments:nil];
////      NSDictionary *dic = [jsDic toDictionary];
////      NSString *title = dic[@"title"];
////      NSString *descriptions = dic[@"description"];
////      NSString *urlStr = dic[@"urlStr"];
////      NSString *imgURLStr = dic[@"imgURLStr"];
//      
//      ShareToWeiChat *weixin = [[ShareToWeiChat alloc] init];
//      
//      ShareToWeChatfriends *weixinFriends = [[ShareToWeChatfriends alloc] init];
//      
//      ShareToQQ *qq = [[ShareToQQ alloc] init];
//      
//      ShareToQQZone *qqZone = [[ShareToQQZone alloc] init];
//      
//      NSMutableArray *activitys = [[NSMutableArray alloc] initWithObjects:weixin,weixinFriends,qq,qqZone, nil];
//      NSArray *activityItems = [NSArray arrayWithObjects:title, description, urlStr, imgURLStr, nil];
//      UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:activitys];
//      if (self.delegate && [self.delegate respondsToSelector:@selector(showActivityViewController:)])
//      {
//            [self.delegate showActivityViewController:activityViewController];
//      }
////      [self presentViewController:activityViewController animated:YES completion:nil];
//}

//- (void)openNewWindow:(NSString *)urlStr
//{
//      if (self.delegate && [self.delegate respondsToSelector:@selector(openInNewWindow:)])
//      {
//            [self.delegate openInNewWindow:urlStr];
//      }
//}
//
//- (void)sendNotification:(NSString *)information andTime:(NSNumber *)time
//{
//      if (!([information isEqualToString:@""]||[information isKindOfClass:NULL]||information == nil))
//      {
//            if (self.delegate && [self.delegate respondsToSelector:@selector(showInformation:withTime:)])
//            {
//                  [self.delegate showInformation:information withTime:time];
//            }
//      }
//}

//- (NSString *)platform
//{
//      return @"ios";
//}
//
//- (NSString *)hostVersion
//{
//      //      NSString *executableFile = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey];    //获取项目名称
//      //
//      //      NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];      //获取项目版本号
//      
//      
//      
//      //      NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//      //
//      //      // app名称
//      //      NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
//      //      // app版本
//      //      NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//      //      // app build版本
//      //      NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
//
//      //APP版本
//      NSString *app_Version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
//      return app_Version;
//}
//
//- (NSString *)version
//{
//      return @"1.0";
//}



//- (void)openByDefaultBrowser:(NSString *)urlStr
//{
//      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
//}

@end
