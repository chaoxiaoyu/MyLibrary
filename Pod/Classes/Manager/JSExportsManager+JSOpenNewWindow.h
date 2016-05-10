//
//  JSExportsManager+JSOpenNewWindow.h
//  XTWebView
//
//  Created by abc on 19/4/16.
//  Copyright © 2016年 com.xiangtian. All rights reserved.
//

#import "JSExportsManager.h"
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JSOpenNewWindow <JSExport>

- (void)openNewWindow:(NSString *)urlStr;
- (void)openByDefaultBrowser:(NSString *)urlStr;

@end

@interface JSExportsManager (JSOpenNewWindow)<JSOpenNewWindow>

@end
