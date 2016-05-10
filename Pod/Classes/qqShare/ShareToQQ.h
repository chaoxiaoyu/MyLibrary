//
//  ShareToQQ.h
//  XTWebView
//
//  Created by abc on 31/3/16.
//  Copyright © 2016年 com.xiangtian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TencentOpenAPI/QQApiInterfaceObject.h"
#import "TencentOpenAPI/QQApiInterface.h"

@interface ShareToQQ : UIActivity

@property NSString* url;
@property NSString *title;
@property NSString *descriptions;
@property NSString *imageStr;

@end
