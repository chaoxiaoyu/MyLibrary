//
//  XTWebViewController.h
//  XTWebView
//
//  Created by abc on 5/4/16.
//  Copyright © 2016年 com.xiangtian. All rights reserved.
//

#import "XTWebView.h"
#import "ShareToWeiChat.h"
#import "ShareToQQ.h"
#import "ShareToQQZone.h"
#import "ShareToWeChatfriends.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "JSExportsManager.h"
#import "WebViewCached.h"

@protocol isOrNotOpenNewPageDelegate <JSExport>

//- (void)openNewPage:(NSString *)urlStr;
//- (void)donotOpenNewPage:(NSString *)urlStr;
//- (void)scanQRViewController;


@end

@interface XTWebViewController : UIViewController<UIWebViewDelegate,isOrNotOpenNewPageDelegate,openNewpage>

@property(nonatomic, strong) XTWebView *webView;
@property(nonatomic, strong) JSContext *jsContext;
@property(nonatomic, strong) JSExportsManager *manager;




@end

