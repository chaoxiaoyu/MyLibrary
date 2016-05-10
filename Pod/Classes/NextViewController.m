//
//  NextViewController.m
//  XTWebView
//
//  Created by abc on 5/4/16.
//  Copyright © 2016年 com.xiangtian. All rights reserved.
//

#import "NextViewController.h"
#import "CustomURLCache.h"
@interface NextViewController ()

@end

@implementation NextViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.URL]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
