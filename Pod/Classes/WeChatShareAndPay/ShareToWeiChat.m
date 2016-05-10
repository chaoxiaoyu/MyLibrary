//
//  ShareToWeiChat.m
//  XTWebView
//
//  Created by abc on 28/3/16.
//  Copyright © 2016年 com.xiangtian. All rights reserved.
//

//http://www.jianshu.com/p/a1c9621a3f4e

#import "ShareToWeiChat.h"

@implementation ShareToWeiChat

+(UIActivityCategory)activityCategory{
      return UIActivityCategoryShare;
}

- (nullable NSString *)activityType
{
      return @"weixin.session";
}

- (nullable NSString *)activityTitle
{
//      return @"微信";
      return NSLocalizedString(@"微信", @"");
}

- (nullable UIImage *)activityImage
{
      return [UIImage imageNamed:@"weixin.png"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
      return YES;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems
{
      self.title = activityItems[0];
      self.descriptions = activityItems[1];
      self.urlStr = activityItems[2];
      self.imgUrlStr = activityItems[3];
}

- (void)performActivity
{
      [ShareToWeiChat shareWithTitle:self.title description:self.descriptions imageUrlString:self.imgUrlStr URLString:self.urlStr];
}

+(void)shareWithTitle:(NSString*) title description:(NSString*) description imageUrlString:(NSString *) imgUrlStr
            URLString:(NSString*) urlString
{
      WXWebpageObject *webPage = [WXWebpageObject object];
      webPage.webpageUrl = urlString;
      
      WXMediaMessage *message = [WXMediaMessage message];
      message.title = title;
      message.description = description;
      UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrlStr]]];
      [message setThumbImage:image];
      message.mediaObject = webPage;

      SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
      req.bText = NO;
      req.message = message;
      req.scene = WXSceneSession;
      
      [WXApi sendReq:req];
}

@end
