//
//  XTAppDelegate.m
//  MyLibrary
//
//  Created by cxy on 05/09/2016.
//  Copyright (c) 2016 cxy. All rights reserved.
//

#import "XTAppDelegate.h"
#import "WXApi.h"
#import "WXAPIManager.h"
#import <AlipaySDK/AlipaySDK.h>
#import "TencentOpenAPI/TencentOAuth.h"
#import "CustomURLCache.h"

@implementation XTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
      [WXApi registerApp:@"wx2591484c13230096"];
      
      CustomURLCache *cached = [[CustomURLCache alloc] initWithMemoryCapacity:4 * 1024*1024 diskCapacity:20 * 1024*1024 diskPath:nil cacheTime:0];
      [CustomURLCache setSharedURLCache:cached];
      [CustomURLCache sharedURLCache];
      
      //[[TencentOAuth alloc] initWithAppId:@"1104617571" andDelegate:nil];
      return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url options:(nonnull NSDictionary<NSString *,id> *)options
{
      //如果极简 SDK 不可用,会跳转支付宝钱包进行支付,需要将支付宝钱包的支付结果回传给 SDK
      if ([url.host isEqualToString:@"safepay"])
      {
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                  NSLog(@"result = %@",resultDic);
            }];
      }
      if ([url.host isEqualToString:@"platformapi"])
      {//支付宝钱包快登授权返回 authCode
            [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
                  NSLog(@"result = %@",resultDic);
            }];
      }
      
      //微信支付
      if ([url.host isEqualToString:@"pay"])
      {
            return [WXApi handleOpenURL:url delegate:[WXAPIManager sharedManager]];
      }
      return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
