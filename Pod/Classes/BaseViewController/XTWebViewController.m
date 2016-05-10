//
//  XTWebViewController.m
//  XTWebView
//
//  Created by abc on 5/4/16.
//  Copyright © 2016年 com.xiangtian. All rights reserved.
//

#import "XTWebViewController.h"
#import "NextViewController.h"
#import "ScanViewController.h"
#import "CustomURLCache.h"
#import "Reachability.h"

@interface XTWebViewController ()
{
      __block UILabel *label;
      UIButton *deleteButton;
}

@end

@implementation XTWebViewController

- (void)viewDidLoad {
      [super viewDidLoad];
      
      _webView = [[XTWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
      _webView.scalesPageToFit = YES;
      _webView.scrollView.bounces = NO;
      [self.view addSubview:_webView];
      self.automaticallyAdjustsScrollViewInsets = NO;
      self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
      UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(share)];
      self.navigationItem.rightBarButtonItem = rightItem;
      deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
      [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
      [deleteButton addTarget:self action:@selector(deleteHeaderView) forControlEvents:UIControlEventTouchUpInside];
      deleteButton.frame = CGRectMake(self.view.frame.size.width-20, -90, 20, 80);
      deleteButton.backgroundColor = [UIColor brownColor];
      [self.webView.scrollView addSubview:deleteButton];
      
      self.manager = [[JSExportsManager alloc] init];
      self.jsContext = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
      self.jsContext[@"XTWebView"] = _manager;
      _manager.jsContext = self.jsContext;
      _manager.delegate = self;
      self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
            context.exception = exceptionValue;
            NSLog(@"异常信息：%@", exceptionValue);
      };
      
      Reachability *reachability = [Reachability reachabilityForInternetConnection];
      NetworkStatus status = [reachability currentReachabilityStatus];
      if (status == NotReachable)
      {
            [self NOInternetConnect];
      }
}

- (void)viewDidAppear:(BOOL)animated
{
      [super viewDidAppear:YES];
}

- (void)NOInternetConnect
{
      dispatch_async(dispatch_get_main_queue(), ^{
            
                  [UIView animateWithDuration:1.0f animations:^{
                        self.webView.scrollView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
                        self.webView.scrollView.contentOffset = CGPointMake(0, -90);
                        label = [[UILabel alloc] initWithFrame:CGRectMake(0, -90, self.view.frame.size.width, 80)];
                        [self.webView.scrollView addSubview:label];
                        label.text = @"当前无网络连接，请检查网络";
                        label.backgroundColor = [UIColor redColor];
                  }];
            
                  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [label removeFromSuperview];
                        self.webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
                  });
      
      });
}

- (void)showInformation:(NSString *)information withTime:(NSNumber *)time
{
      dispatch_async(dispatch_get_main_queue(), ^{
            if([time doubleValue] > 0)
            {
                  [UIView animateWithDuration:1.0f animations:^{
                        self.webView.scrollView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
                        self.webView.scrollView.contentOffset = CGPointMake(0, -90);
                        label = [[UILabel alloc] initWithFrame:CGRectMake(0, -90, self.view.frame.size.width, 80)];
                        [self.webView.scrollView addSubview:label];
                        label.text = information;
                        label.backgroundColor = [UIColor redColor];
                  }];
                  
                  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)([time doubleValue] * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [label removeFromSuperview];
                        self.webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
                  });
            }
            
            else if ([time doubleValue] == -1)
            {
                  [UIView animateWithDuration:1.0f animations:^{
                        self.webView.scrollView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
                        self.webView.scrollView.contentOffset = CGPointMake(0, -90);
                        label = [[UILabel alloc] initWithFrame:CGRectMake(0, -90, self.view.frame.size.width, 80)];
                        [self.webView.scrollView addSubview:label];
                        label.text = information;
                        label.backgroundColor = [UIColor redColor];
                  }];
                  UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(GestureAction:)];
                  label.userInteractionEnabled = YES;
                  [label addGestureRecognizer:panGesture];
            }
      });
}

//
- (void)GestureAction:(UIPanGestureRecognizer *)sender
{
      label = (UILabel *)sender.view;
      __block CGPoint originPoint = label.center;
      __block CGRect frame;
      
      CGPoint startPoint;
      if (sender.state == UIGestureRecognizerStateBegan)
      {
            startPoint = [sender locationInView:label];
            
            [UIView animateWithDuration:1.0 animations:^{
                  label.alpha = 0.6;
            }];
      }
      else if (sender.state == UIGestureRecognizerStateChanged)
      {
            CGPoint newPoint = [sender locationInView:label];
            CGFloat x = newPoint.x - startPoint.x;
            [UIView animateWithDuration:1.0 animations:^{
                  label.center = CGPointMake(x, -50);
                  originPoint = label.center;
//                  deleteButton.frame = CGRectMake(self.view.frame.size.width-x, -90, x, 80);
                  deleteButton.center = CGPointMake(self.view.frame.size.width-x/2.0, -50);
//                  [self.webView.scrollView addSubview:deleteButton];
                  frame = deleteButton.frame;
            }];
      }
      else if (sender.state == UIGestureRecognizerStateEnded)
      {
            label.center = originPoint;
            deleteButton.frame = frame;
      }
}

- (void)share
{
      //      [_webView stringByEvaluatingJavaScriptFromString:@"jsFunc()"];
      //      JSContext *context = [_webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
      JSValue *jsShare = _webView.jsContext[@"share"];
      JSValue *jsDic = [jsShare callWithArguments:nil];
      NSDictionary *dic = [jsDic toDictionary];
      NSString *title = dic[@"title"];
      NSString *descriptions = dic[@"description"];
      NSString *urlStr = dic[@"urlStr"];
      NSString *imgURLStr = dic[@"imgURLStr"];
      
      ShareToWeiChat *weixin = [[ShareToWeiChat alloc] init];
      
      ShareToWeChatfriends *weixinFriends = [[ShareToWeChatfriends alloc] init];
      
      ShareToQQ *qq = [[ShareToQQ alloc] init];
      
      ShareToQQZone *qqZone = [[ShareToQQZone alloc] init];
      
      NSMutableArray *activitys = [[NSMutableArray alloc] initWithObjects:weixin,weixinFriends,qq,qqZone, nil];
      NSArray *activityItems = [NSArray arrayWithObjects:title, descriptions, urlStr, imgURLStr, nil];
      UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:activitys];
      [self presentViewController:activityViewController animated:YES completion:nil];
}

- (void)openInNewWindow:(NSString *)urlStr
{
      dispatch_async(dispatch_get_main_queue(),^{
            NextViewController *next = [[NextViewController alloc] init];
            NSURL *url = [NSURL URLWithString:urlStr];
            next.URL = url;
            [self.navigationController pushViewController:next animated:YES];
      });
}

- (void)showActivityViewController:(UIActivityViewController *)viewController
{
      dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:viewController animated:YES completion:nil];
      });
}

//- (void)openNewPage:(NSString *)urlStr
//{
//      dispatch_async(dispatch_get_main_queue(),^{
//            NextViewController *next = [[NextViewController alloc] init];
//            NSURL *url = [NSURL URLWithString:urlStr];
//            next.URL = url;
//            [self.navigationController pushViewController:next animated:YES];
//      });
//}
//
//- (void)scanQRViewController
//{
//      ScanViewController *scanQRController = [[ScanViewController alloc] init];
//      [self presentViewController:scanQRController animated:YES completion:nil];
//}
//
//- (void)donotOpenNewPage:(NSString *)urlStr
//{
//      dispatch_async(dispatch_get_main_queue(), ^{
//            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
//      });
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
