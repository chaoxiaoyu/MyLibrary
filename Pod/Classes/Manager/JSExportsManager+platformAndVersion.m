//
//  JSExportsManager+platformAndVersion.m
//  XTWebView
//
//  Created by abc on 19/4/16.
//  Copyright © 2016年 com.xiangtian. All rights reserved.
//

#import "JSExportsManager+platformAndVersion.h"

@implementation JSExportsManager (platformAndVersion)

- (NSString *)platform
{
      return @"ios";
}

- (NSString *)hostVersion
{
      //      NSString *executableFile = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey];    //获取项目名称
      //
      //      NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];      //获取项目版本号
      
      
      
      //      NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
      //
      //      // app名称
      //      NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
      //      // app版本
      //      NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
      //      // app build版本
      //      NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
      
      //APP版本
      NSString *app_Version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
      return app_Version;
}

- (NSString *)version
{
      return @"1.0";
}

@end
