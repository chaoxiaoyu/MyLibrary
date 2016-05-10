//
//  JSExportsManager+sendNotification.m
//  XTWebView
//
//  Created by abc on 19/4/16.
//  Copyright © 2016年 com.xiangtian. All rights reserved.
//

#import "JSExportsManager+sendNotification.h"

@implementation JSExportsManager (sendNotification)

- (void)sendNotification:(NSString *)information andTime:(NSNumber *)time
{
      if (!([information isEqualToString:@""]||[information isKindOfClass:NULL]||information == nil))
      {
            if (self.delegate && [self.delegate respondsToSelector:@selector(showInformation:withTime:)])
            {
                  [self.delegate showInformation:information withTime:time];
            }
      }
}


@end
