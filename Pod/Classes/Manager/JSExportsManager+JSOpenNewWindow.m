//
//  JSExportsManager+JSOpenNewWindow.m
//  XTWebView
//
//  Created by abc on 19/4/16.
//  Copyright © 2016年 com.xiangtian. All rights reserved.
//

#import "JSExportsManager+JSOpenNewWindow.h"

@implementation JSExportsManager (JSOpenNewWindow)

- (void)openNewWindow:(NSString *)urlStr
{
      if (self.delegate && [self.delegate respondsToSelector:@selector(openInNewWindow:)])
      {
            [self.delegate openInNewWindow:urlStr];
      }
}

- (void)openByDefaultBrowser:(NSString *)urlStr
{
      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
}

@end
