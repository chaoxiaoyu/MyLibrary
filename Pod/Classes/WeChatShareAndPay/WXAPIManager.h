//
//  WXAPIManager.h
//  XTWebView
//
//  Created by abc on 29/3/16.
//  Copyright © 2016年 com.xiangtian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXAPI.h"

@interface WXAPIManager : NSObject<WXApiDelegate>

+ (instancetype)sharedManager;

@end
