//
//  JSExportsManager+weChatAndAplPay.h
//  XTWebView
//
//  Created by abc on 19/4/16.
//  Copyright © 2016年 com.xiangtian. All rights reserved.
//

#import <JavaScriptCore/JavaScriptCore.h>
#import "JSExportsManager.h"

@protocol JSPayProtocol <JSExport>

- (void)payByAlipay:(NSDictionary *)dic;
- (void)payByWeChat:(JSValue *)jsDic;

@end

@interface JSExportsManager (weChatAndAplPay)<JSPayProtocol>

@end
