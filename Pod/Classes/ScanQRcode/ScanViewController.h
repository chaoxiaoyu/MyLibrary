//
//  ScanViewController.h
//  XTWebView
//
//  Created by abc on 1/4/16.
//  Copyright © 2016年 com.xiangtian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <AVFoundation/AVFoundation.h>

@interface ScanViewController : UIViewController<AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) UIButton *scanButton;
@property (nonatomic, strong) UIImageView *scanBgView;
@property (nonatomic, strong) UIImageView *scanLine;
@property (nonatomic, assign) BOOL finishReading;

@property (nonatomic, strong) AVCaptureDevice *device;
@property (nonatomic, strong) AVCaptureDeviceInput *input;
@property (nonatomic, strong) AVCaptureMetadataOutput *output;
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewlayer;


@end
