//
//  XTViewController.m
//  MyLibrary
//
//  Created by cxy on 05/09/2016.
//  Copyright (c) 2016 cxy. All rights reserved.
//

#import "XTViewController.h"


@interface XTViewController ()

@end

@implementation XTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
     
      
      NSURL *url = [[NSBundle mainBundle] URLForResource:@"test" withExtension:@"html"];
      NSURL *urls = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.aishangzhoukou.cn/?accesstype=app"]];
      [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
