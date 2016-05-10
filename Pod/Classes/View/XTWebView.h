//
//  XTWebView.h
//  XTWebView
//
//  Created by abc on 24/3/16.
//  Copyright © 2016年 com.xiangtian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

//@protocol  JavaScriptCoreDelegate <JSExport>
//
//- (void)payByAlipay;//支付宝支付
//
//- (void)payByWeChat;//微信支付
//
//- (void)scanQRcode;//扫描二维码
//
//- (void)openInNewWindow;
//
//@end
//
//@protocol openNewWindowDelegate <NSObject>
//
//- (void)openNewWindowInController;
//
//@end


@interface XTWebView : UIWebView<UIWebViewDelegate>

@property(nonatomic, strong) JSContext *jsContext;
@property(nonatomic, assign) BOOL openNewWindow;
//@property(nonatomic, strong) JSExportsManager *manager;


@end
