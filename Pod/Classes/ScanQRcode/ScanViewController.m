//
//  ScanViewController.m
//  XTWebView
//
//  Created by abc on 1/4/16.
//  Copyright © 2016年 com.xiangtian. All rights reserved.
//

#import "ScanViewController.h"

@interface ScanViewController ()

@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      self.view.backgroundColor = [UIColor grayColor];
      _scanBgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/4.0, 120, self.view.frame.size.width/2.0, self.view.frame.size.width/2.0)];
      _scanBgView.backgroundColor = [UIColor clearColor];
      _scanBgView.image = [UIImage imageNamed:@"pick_bg.png"];
      [self.view addSubview:_scanBgView];
      
      _scanLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.scanBgView.frame.size.width, 2)];
      _scanLine.backgroundColor = [UIColor clearColor];
      _scanLine.image = [UIImage imageNamed:@"line.png"];
      [_scanBgView addSubview:_scanLine];
      
      _scanButton = [UIButton buttonWithType:UIButtonTypeCustom];
      _scanButton.frame = CGRectMake(self.view.frame.size.width/2-30, _scanBgView.frame.origin.y + _scanBgView.frame.size.height + 30, 60, 30);
      _scanButton.backgroundColor = [UIColor clearColor];
      [_scanButton setTitle:@"扫描" forState:UIControlStateNormal];
      [_scanButton addTarget:self action:@selector(beginScanQR) forControlEvents:UIControlEventTouchUpInside];
      [self.view addSubview:_scanButton];
      _finishReading = NO;
}

- (void)beginScanQR
{
      if ([_scanButton.titleLabel.text isEqualToString:@"扫描"])
      {
            [_scanButton setTitle:@"停止" forState:UIControlStateNormal];
            
            
            
            [self scanAnimation];
            _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
            
            _input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:nil];
            
            _output = [[AVCaptureMetadataOutput alloc] init];
            dispatch_queue_t queue = dispatch_queue_create(nil, DISPATCH_QUEUE_SERIAL);
            [_output setMetadataObjectsDelegate:self queue:queue];
//            _output.metadataObjectTypes = _output.availableMetadataObjectTypes;
//            _output.rectOfInterest = CGRectMake(0.25, 0.25, self.view.frame.size.width/self.view.frame.size.height, 0.5);
            
            
            _session = [[AVCaptureSession alloc] init];
            [_session setSessionPreset:AVCaptureSessionPresetHigh];
            if ([_session canAddInput:_input])
            {
                  [_session addInput:_input];
            }
            if ([_session canAddOutput:self.output])
            {
                  [_session addOutput:self.output];
            }
//            NSString *c = @"zz";
            
            _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
            _previewlayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
            _previewlayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
            _previewlayer.frame = _scanBgView.frame;
            [self.view.layer insertSublayer:_previewlayer atIndex:0];
            [_session startRunning];
            
            
      }
      else if ([_scanButton.titleLabel.text isEqualToString:@"停止"])
      {
            [_scanButton setTitle:@"扫描" forState:UIControlStateNormal];
            [_scanLine.layer removeAnimationForKey:@"move"];
            [_session stopRunning];
            [self dismissViewControllerAnimated:YES completion:^{
                  
            }];
            
      }
}

//扫描动画
- (void)scanAnimation
{
      CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];

      animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.view.frame.size.width/4, 2)];
      animation.toValue = [NSValue valueWithCGPoint:CGPointMake(_scanBgView.frame.origin.x, _scanBgView.frame.size.height-2)];
      animation.repeatCount = MAXFLOAT;
      animation.autoreverses = YES;
      animation.duration = 2.0;
      [_scanLine.layer addAnimation:animation forKey:@"move"];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
      NSString *scanResult;
      if ([metadataObjects count] > 0 && _finishReading == NO)
      {
            AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex:0];
            scanResult = metadataObject.stringValue;
            [_session stopRunning];
            [self dismissViewControllerAnimated:YES completion:^{
                  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"扫描结果" message:scanResult delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"打开URL", nil];
                  [alert show];
                  _finishReading = YES;
            }];
      }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
      if (buttonIndex == 1)
      {
            UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
            webView.scalesPageToFit = YES;
            [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:alertView.message]]];
            [self.view addSubview:webView];
      }
}

- (void)alertViewCancel:(UIAlertView *)alertView
{
      
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
