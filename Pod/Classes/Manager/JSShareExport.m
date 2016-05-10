//
//  share.m
//  XTWebView
//
//  Created by finfo on 4/19/16.
//  Copyright © 2016 com.xiangtian. All rights reserved.
//

#import "JSShareExport.h"
#import "ShareToWeiChat.h"
#import "ShareToWeChatfriends.h"
#import "ShareToQQ.h"
#import "ShareToQQZone.h"



@implementation JSExportsManager (JSShareExport)

- (void)shareWithTitle:(NSString *)title andDescription:(NSString *)description andImgURLStr:(NSString *)imgURLStr andURLStr:(NSString *)urlStr
{
    //      JSValue *jsShare = _webView.jsContext[@"share"];
    //      JSValue *jsDic = [jsShare callWithArguments:nil];
    //      NSDictionary *dic = [jsDic toDictionary];
    //      NSString *title = dic[@"title"];
    //      NSString *descriptions = dic[@"description"];
    //      NSString *urlStr = dic[@"urlStr"];
    //      NSString *imgURLStr = dic[@"imgURLStr"];
    
    ShareToWeiChat *weixin = [[ShareToWeiChat alloc] init];
    
    ShareToWeChatfriends *weixinFriends = [[ShareToWeChatfriends alloc] init];
    
    ShareToQQ *qq = [[ShareToQQ alloc] init];
    
    ShareToQQZone *qqZone = [[ShareToQQZone alloc] init];
    
    NSMutableArray *activitys = [[NSMutableArray alloc] initWithObjects:weixin,weixinFriends,qq,qqZone, nil];
    NSArray *activityItems = [NSArray arrayWithObjects:title, description, urlStr, imgURLStr, nil];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:activitys];
    if (self.delegate && [self.delegate respondsToSelector:@selector(showActivityViewController:)])
    {
        [self.delegate showActivityViewController:activityViewController];
    }
    //      [self presentViewController:activityViewController animated:YES completion:nil];
}


@end