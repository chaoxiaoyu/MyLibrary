//
//  ShareToWeiChat.h
//  XTWebView
//
//  Created by abc on 28/3/16.
//  Copyright © 2016年 com.xiangtian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"

@interface ShareToWeiChat : UIActivity<WXApiDelegate>

@property NSString *urlStr;
@property NSString *title;
@property NSString *descriptions;
@property NSString *imgUrlStr;

+(void)shareWithTitle:(NSString*) title description:(NSString*) description imageUrlString:(NSString *) imgUrlStr
            URLString:(NSString*) urlString;

@end
