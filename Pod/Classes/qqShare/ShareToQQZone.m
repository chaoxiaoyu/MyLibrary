//
//  ShareToQQZone.m
//  XTWebView
//
//  Created by abc on 31/3/16.
//  Copyright © 2016年 com.xiangtian. All rights reserved.
//

#import "ShareToQQZone.h"

@implementation ShareToQQZone

+ (UIActivityCategory)activityCategory
{
      return UIActivityCategoryShare;
}

- (nullable NSString *)activityType
{
      return @"tencent.qqzone";
}

- (nullable NSString *)activityTitle
{
      return @"qqzone";
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
      self.url = activityItems[2];
      self.imageStr = activityItems[3];
}

- (void)performActivity
{
      [ShareToQQZone shareWithTitle:self.title description:self.descriptions imageStr:self.imageStr URLString:self.url];
}

+(void)shareWithTitle:(NSString*) title description:(NSString*) description imageStr:(NSString *) imagestring
            URLString:(NSString*) urlString
{
      QQApiNewsObject *newsObject = [QQApiNewsObject objectWithURL:[NSURL URLWithString:urlString] title:title description:description previewImageURL:[NSURL URLWithString:imagestring]];
      SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObject];
      [QQApiInterface SendReqToQZone:req];
}


@end
