//
//  JSExportsManager+sendNotification.h
//  XTWebView
//
//  Created by abc on 19/4/16.
//  Copyright © 2016年 com.xiangtian. All rights reserved.
//

#import "JSExportsManager.h"
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JSSendNotificationProtocol <JSExport>

JSExportAs(sendNotification, - (void)sendNotification:(NSString *)information andTime:(NSNumber *)time);

@end

@protocol showNotification <NSObject>

- (void)showInformation:(NSString *)information withTime:(NSNumber *)time;

@end

@interface JSExportsManager (sendNotification)<JSSendNotificationProtocol>

@property (nonatomic, weak)id <showNotification>myDelegate;

@end
