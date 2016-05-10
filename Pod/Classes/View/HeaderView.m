//
//  HeaderView.m
//  XTWebView
//
//  Created by abc on 18/4/16.
//  Copyright © 2016年 com.xiangtian. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
      if (self = [super initWithFrame:frame])
      {
            _label = [[UILabel alloc] initWithFrame:CGRectZero];
            [self addSubview:_label];
            
            _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
            _deleteButton.frame = CGRectMake(500, 10, 20, 80);
//            [_deleteButton addTarget:self action:@selector(deleteHeaderView) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_deleteButton];
      }
      return self;
}

@end
