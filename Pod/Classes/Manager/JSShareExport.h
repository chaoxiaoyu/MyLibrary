//
//  share.h
//  XTWebView
//
//  Created by finfo on 4/19/16.
//  Copyright © 2016 com.xiangtian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "JSExportsManager.h"

@protocol JSShareExport <JSExport>

JSExportAs(share,- (void)shareWithTitle:(NSString *)title andDescription:(NSString *)description andImgURLStr:(NSString *)imgURLStr andURLStr:(NSString *)urlStr);

@end

@protocol showActivityViewController <NSObject>

- (void)showActivityViewController:(UIActivityViewController *)viewController;

@end

@interface JSExportsManager (JSShareExport)<JSShareExport>

@end 