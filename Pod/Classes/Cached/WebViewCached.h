//
//  WebViewCached.h
//  XTWebView
//
//  Created by abc on 21/4/16.
//  Copyright © 2016年 com.xiangtian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Util.h"

@interface WebViewCached : NSURLCache

@property (nonatomic, assign) NSInteger cacheTime;
@property (nonatomic, strong) NSString *diskPath;
@property (nonatomic, strong) NSMutableDictionary *responsesDic;

- (id)initWithMemoryCapacity:(NSUInteger)memoryCapacity diskCapacity:(NSUInteger)diskCapacity diskPath:(NSString *)path cacheTime:(NSInteger)cacheTime;


@end
