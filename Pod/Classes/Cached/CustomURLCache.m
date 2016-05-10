//
//  CustomURLCache.m
//  LocalCache
//
//  Created by tan on 13-2-12.
//  Copyright (c) 2013年 adways. All rights reserved.
//

#import "CustomURLCache.h"


@interface CustomURLCache(private)

- (NSString *)cacheFolder;
- (NSString *)cacheFilePath:(NSString *)file;
- (NSString *)cacheRequestFileName:(NSString *)requestUrl;
- (NSString *)cacheRequestOtherInfoFileName:(NSString *)requestUrl;
- (NSCachedURLResponse *)dataFromRequest:(NSURLRequest *)request;
- (void)deleteCacheFolder;

@end

@implementation CustomURLCache

@synthesize cacheTime = _cacheTime;
@synthesize diskPath = _diskPath;
@synthesize responseDictionary = _responseDictionary;

- (id)initWithMemoryCapacity:(NSUInteger)memoryCapacity diskCapacity:(NSUInteger)diskCapacity diskPath:(NSString *)path cacheTime:(NSInteger)cacheTime
{
      if (self = [self initWithMemoryCapacity:memoryCapacity diskCapacity:diskCapacity diskPath:path]) {
            self.cacheTime = cacheTime;
            if (path)
            {
                  self.diskPath = path;
            }
            else
            {
                  self.diskPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];//
            }
            
            self.responseDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
      }
      return self;
}

- (NSCachedURLResponse *)cachedResponseForRequest:(NSURLRequest *)request
{
      NSLog(@"aaa");
      if ([request.HTTPMethod compare:@"GET"] != NSOrderedSame)
      {
            return [super cachedResponseForRequest:request];
      }
      return [self dataFromRequest:request];
}

- (void)removeAllCachedResponses
{
      [super removeAllCachedResponses];
      [self deleteCacheFolder];
}

- (void)removeCachedResponseForRequest:(NSURLRequest *)request
{
      [super removeCachedResponseForRequest:request];
      NSString *url = request.URL.absoluteString;
      NSString *fileName = [self cacheRequestFileName:url];
      NSString *otherInfoFileName = [self cacheRequestOtherInfoFileName:url];
      NSString *filePath = [self cacheFilePath:fileName];
      NSString *otherInfoPath = [self cacheFilePath:otherInfoFileName];
      NSFileManager *fileManager = [NSFileManager defaultManager];
      [fileManager removeItemAtPath:filePath error:nil];
      [fileManager removeItemAtPath:otherInfoPath error:nil];
}

#pragma mark - custom url cache

- (NSString *)cacheFolder
{
      return @"URLCACHE";
}

- (void)deleteCacheFolder
{
      NSString *path = [NSString stringWithFormat:@"%@/%@", self.diskPath, [self cacheFolder]];
      NSFileManager *fileManager = [NSFileManager defaultManager];
      [fileManager removeItemAtPath:path error:nil];
}

- (NSString *)cacheFilePath:(NSString *)file
{
      NSString *path = [NSString stringWithFormat:@"%@/%@", self.diskPath, [self cacheFolder]];
      NSFileManager *fileManager = [NSFileManager defaultManager];
      BOOL isDir;
      if (![fileManager fileExistsAtPath:path isDirectory:&isDir] && isDir)
      {
            [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
      }
      
      return [NSString stringWithFormat:@"%@/%@", path, file];
}

- (NSString *)cacheRequestFileName:(NSString *)requestUrl
{
      return [Util md5Hash:requestUrl];
}

- (NSString *)cacheRequestOtherInfoFileName:(NSString *)requestUrl
{
      return [Util md5Hash:[NSString stringWithFormat:@"%@-otherInfo", requestUrl]];
}

- (BOOL)fileExistsAtPath:(NSString *)path
{
      NSFileManager *fileManager = [NSFileManager defaultManager];
      
      if ([fileManager fileExistsAtPath:path])
      {
            return YES;
      }
      else
      {
            return NO;
      }
}

- (BOOL)fileExpireAtPath:(NSString *)path withOtherInfoPath:(NSString *)otherInfoPath
{
      NSDate *date = [NSDate date];
      if ([self fileExistsAtPath:path])
      {
            NSDictionary *otherInfo = [NSDictionary dictionaryWithContentsOfFile:otherInfoPath];
            if (self.cacheTime > 0)
            {//判断缓存是否过期
                  NSInteger createTime = [[otherInfo objectForKey:@"time"] intValue];
                  if (createTime + self.cacheTime < [date timeIntervalSince1970])
                  {
                        return YES;
                  }
            }
            
      }
      return NO;//没过期
}

- (NSCachedURLResponse *)dataFromRequest:(NSURLRequest *)request
{
      NSString *url = request.URL.absoluteString;
      NSString *fileName = [self cacheRequestFileName:url];
      NSString *otherInfoFileName = [self cacheRequestOtherInfoFileName:url];
      NSString *filePath = [self cacheFilePath:fileName];
      NSString *otherInfoPath = [self cacheFilePath:otherInfoFileName];
      NSDate *date = [NSDate date];
      
      Reachability *reachNet = [Reachability reachabilityForInternetConnection];
      NetworkStatus status = [reachNet currentReachabilityStatus];
      
      if (status == ReachableViaWiFi || status == ReachableViaWWAN)
      {
            if ([self fileExistsAtPath:filePath])
            {
                  [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
                  [[NSFileManager defaultManager] removeItemAtPath:otherInfoPath error:nil];
            }
            __block NSCachedURLResponse *cachedResponse = nil;
            //sendSynchronousRequest请求也要经过NSURLCache
            id boolExsite = [self.responseDictionary objectForKey:url];
            if (boolExsite == nil)
            {
                  [self.responseDictionary setValue:[NSNumber numberWithBool:TRUE] forKey:url];
                  
                  [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data,NSError *error)
                   {
                         if (response && data)
                         {
                               
                               [self.responseDictionary removeObjectForKey:url];
                               
                               if (error)
                               {
                                     NSLog(@"error : %@", error);
                                     NSLog(@"not cached: %@", request.URL.absoluteString);
                                     cachedResponse = nil;
                               }
                               
                               NSLog(@"cache url --- %@ ",url);
                               
                               //save to cache
                               NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%f", [date timeIntervalSince1970]], @"time",response.MIMEType, @"MIMEType",response.textEncodingName, @"textEncodingName", nil];
                               [dict writeToFile:otherInfoPath atomically:YES];
                               [data writeToFile:filePath atomically:YES];
                               
                               cachedResponse = [[NSCachedURLResponse alloc] initWithResponse:response data:data];
                         }
                         
                   }];
                  
                  return cachedResponse;
            }
      }
      
      else
      {
            if (![self fileExpireAtPath:filePath withOtherInfoPath:otherInfoPath])
            {
                  NSLog(@"读取缓存");
                  NSDictionary *otherInfo = [NSDictionary dictionaryWithContentsOfFile:otherInfoPath];
                  NSData *data = [NSData dataWithContentsOfFile:filePath];
                  NSURLResponse *response = [[NSURLResponse alloc] initWithURL:request.URL MIMEType:[otherInfo objectForKey:@"MIMEType"]expectedContentLength:data.length textEncodingName:[otherInfo objectForKey:@"textEncodingName"]];
                  NSCachedURLResponse *cachedResponse = [[NSCachedURLResponse alloc] initWithResponse:response data:data];
                  //              NSString *string = [[NSString alloc] initWithData:cachedResponse.data encoding:NSUTF8StringEncoding];
                  return cachedResponse;
            }
            else
            {
                  NSLog(@"缓存过期");
                  return nil;
            }
      }
      return nil;
}

@end
