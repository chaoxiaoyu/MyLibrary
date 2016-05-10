//
//  SharePayAndScanManager.h
//  XTWebView
//
//  Created by abc on 31/3/16.
//  Copyright © 2016年 com.xiangtian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "Alipay.h"
#import "WechatPay.h"
//#import "JSExportProtocol.h"
//@protocol JavaScriptManagerDelegate <JSExport>
//
//- (void)payByAlipay:(NSDictionary *)dic;//支付宝支付
//
//- (void)payByWeChat:(JSValue *)jsDic;//微信支付
//
//- (void)openNewWindow:(NSString *)urlStr;
//- (void)openByDefaultBrowser:(NSString *)urlStr;
//
//
//JSExportAs(share, - (void)shareWithTitle:(NSString *)title andDescription:(NSString *)description andImgURLStr:(NSString *)imgURLStr andURLStr:(NSString *)urlStr);
////- (void)shareWithTitle:(NSString *)title andDescription:(NSString *)description andImgURLStr:(NSString *)imgURLStr andURLStr:(NSString *)urlStr;
//JSExportAs(sendNotification, - (void)sendNotification:(NSString *)information andTime:(NSNumber *)time);
////- (void)sendNotification:(NSString *)information andTime:(NSNumber *)time;
//
//
//
//
//- (NSString *)platform;
//- (NSString *)version;
//- (NSString *)hostVersion;
//
//
//
//@end



@protocol openNewpage <NSObject>
@optional
- (void)openInNewWindow:(NSString *)urlStr;
- (void)showActivityViewController:(UIActivityViewController *)viewController;
- (void)showInformation:(NSString *)information withTime:(NSNumber *)time;

@end

@interface JSExportsManager : NSObject

@property (nonatomic, weak) id<openNewpage>delegate;
@property (nonatomic, strong) JSContext *jsContext;


@end
