//
//  ShareToWeChatfriends.h
//  XTWebView
//
//  Created by abc on 31/3/16.
//  Copyright © 2016年 com.xiangtian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"


@interface ShareToWeChatfriends : UIActivity<WXApiDelegate>

@property NSString* urlStr;
@property NSString *title;
@property NSString *descriptions;
@property NSString *imgUrlStr;

@end
