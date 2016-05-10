//
//  Util.m
//  XTWebView
//
//  Created by abc on 21/4/16.
//  Copyright © 2016年 com.xiangtian. All rights reserved.
//

#import "Util.h"
#import <CommonCrypto/CommonDigest.h>

@implementation Util
//加密后的字符串都是唯一的，保证文件名唯一
+ (NSString *)md5Hash:(NSString *)str
{
      const char *constStr = [str UTF8String];
      unsigned char result[16];
      CC_MD5(constStr, (uint32_t)strlen(constStr), result);
      NSString *md5Result = [NSString stringWithFormat:
                             @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                             result[0], result[1], result[2], result[3],
                             result[4], result[5], result[6], result[7],
                             result[8], result[9], result[10], result[11],
                             result[12], result[13], result[14], result[15]
                             ];
      return md5Result;
}

@end
