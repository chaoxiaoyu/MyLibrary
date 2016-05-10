//
//  WebViewCached.m
//  XTWebView
//
//  Created by abc on 21/4/16.
//  Copyright © 2016年 com.xiangtian. All rights reserved.
//

#import "WebViewCached.h"

@implementation WebViewCached

- (id)initWithMemoryCapacity:(NSUInteger)memoryCapacity diskCapacity:(NSUInteger)diskCapacity diskPath:(NSString *)path cacheTime:(NSInteger)cacheTime
{
      if(self = [super initWithMemoryCapacity:memoryCapacity diskCapacity:diskCapacity diskPath:path])
      {
            self.cacheTime = cacheTime;
            self.responsesDic = [[NSMutableDictionary alloc] initWithCapacity:1];
            if (path)
            {
                  self.diskPath = path;
            }
            else
            {
                  self.diskPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            }
            self.responsesDic = [[NSMutableDictionary alloc] initWithCapacity:1];
      }
      return self;
}

- (NSString *)cacheFilePath:(NSString *)file
{
      NSString *path = [NSString stringWithFormat:@"%@/WebCached", self.diskPath];
      NSFileManager *fileManager = [NSFileManager defaultManager];
      BOOL isDir;
      if ([fileManager fileExistsAtPath:path isDirectory:&isDir] && isDir) {
            
      } else {
            [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
      }
      return [NSString stringWithFormat:@"%@/%@", path, file];
}

- (NSCachedURLResponse *)cachedResponseForRequest:(NSURLRequest *)request
{
      if ([request.HTTPMethod compare:@"GET"] != NSOrderedSame)
      {
            return [super cachedResponseForRequest:request];
      }
      return [self saveResponseWithRequest:request];
}

- (NSCachedURLResponse *)saveResponseWithRequest:(NSURLRequest *)request
{
      NSString *url = request.URL.absoluteString;
      NSString *fileName = [Util md5Hash:url];
      NSString *otherInfoName = [Util md5Hash:url];
      NSString *path = [self cacheFilePath:fileName];
      NSString *InfoPath = [self cacheFilePath:otherInfoName];
      NSDate *date = [NSDate date];
      
      NSFileManager *fileManager = [NSFileManager defaultManager];
      if ([fileManager fileExistsAtPath:path])
      {
            BOOL exists = YES;
            NSDictionary *otherInfoDic = [NSDictionary dictionaryWithContentsOfFile:InfoPath];
            if (self.cacheTime > 0)
            {
                  NSInteger createTime = [[otherInfoDic objectForKey:@"cachedTime"] integerValue];
                  if (createTime + self.cacheTime < [date timeIntervalSince1970])
                  {
                        exists = NO;
//                        [super removeAllCachedResponses];
                  }
            }
            if (exists)
            {
                  NSLog(@"读取缓存");
                  NSData *cacheData = [NSData dataWithContentsOfFile:path];
                  NSURLResponse *response = [[NSURLResponse alloc] initWithURL:request.URL MIMEType:[otherInfoDic objectForKey:@"MIMEType"] expectedContentLength:cacheData.length textEncodingName:[otherInfoDic objectForKey:@"textEncodingName"]];
                  NSCachedURLResponse *cachedResponse = [[NSCachedURLResponse alloc] initWithResponse:response data:cacheData];
                  return cachedResponse;
            }
            else
            {
                  [fileManager removeItemAtPath:path error:nil];
                  [fileManager removeItemAtPath:InfoPath error:nil];
            }
      }
      
      __block NSCachedURLResponse *cachedResponse = nil;
      //sendSynchronousRequest请求也要经过NSURLCache
      id boolExsite = [self.responsesDic objectForKey:url];
      if (boolExsite == nil)
      {
            [self.responsesDic setValue:[NSNumber numberWithBool:TRUE] forKey:url];
            
            [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data,NSError *error)
             {
                   if (response && data)
                   {
                         
                         [self.responsesDic removeObjectForKey:url];
                         
                         if (error)
                         {
                               NSLog(@"error : %@", error);
                               NSLog(@"not cached: %@", request.URL.absoluteString);
                               cachedResponse = nil;
                         }
                         
                         NSLog(@"cache url --- %@ ",url);
                         
                         //save to cache
                         NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%f", [date timeIntervalSince1970]], @"cachedTime",
                                               response.MIMEType, @"MIMEType",
                                               response.textEncodingName, @"textEncodingName", nil];
                         [dict writeToFile:InfoPath atomically:YES];
                         [data writeToFile:path atomically:YES];
                         
                         cachedResponse = [[NSCachedURLResponse alloc] initWithResponse:response data:data];
                   }
                   
             }];
      
      }
      return cachedResponse;
}



//- (void)removeCachedResponseForRequest:(NSURLRequest *)request
//{
//      
//}
//
//- (void)removeAllCachedResponses
//{
//      
//}
//
//- (void)removeCachedResponsesSinceDate:(NSDate *)date
//{
//      
//}

@end
