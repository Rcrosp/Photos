//
//  CustomLabel.m
//  Photos
//
//  Created by Apple on 2018/7/7.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "CustomLabel.h"

@implementation CustomLabel
- (instancetype)init {
    if (self = [super init]) {
        _textInsets = UIEdgeInsetsZero;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _textInsets = UIEdgeInsetsZero;
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, _textInsets)];
}


@end
