//
//  ShareToWeChatfriends.m
//  XTWebView
//
//  Created by abc on 31/3/16.
//  Copyright © 2016年 com.xiangtian. All rights reserved.
//

#import "ShareToWeChatfriends.h"

@implementation ShareToWeChatfriends

+ (UIActivityCategory)activityCategory
{
      return UIActivityCategoryShare;
}

- (nullable NSString *)activityType
{
      return @"weixin.timeline";
}

- (nullable NSString *)activityTitle
{
      return @"朋友圈";
}

- (nullable UIImage *)activityImage
{
      return [UIImage imageNamed:@""];
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
      [ShareToWeChatfriends shareWithTitle:self.title description:self.description imageUrlString:self.imgUrlStr URLString:self.urlStr];
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
      req.scene = WXSceneTimeline;
      
      [WXApi sendReq:req];
}


@end
