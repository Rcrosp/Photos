//
//  PhotoModel.m
//  Photos
//
//  Created by Apple on 2018/7/7.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "PhotoModel.h"

@implementation PhotoModel
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{@"pid":@"id",
             @"pDescription":@"description"
             };
}

//- (CGFloat)cellHeight{
//    if (_cellHeight == 0) {
//        CGFloat imageW = [UIScreen mainScreen].bounds.size.width - 2 * 15;
//        _cellHeight = (imageW / _width.floatValue) * _height.floatValue;
//    }
//    return _cellHeight;
//}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    CGFloat imageW = [UIScreen mainScreen].bounds.size.width - 2 * 15;
    _cellHeight = (imageW / _width.floatValue) * _height.floatValue;
    return YES;
}

@end
