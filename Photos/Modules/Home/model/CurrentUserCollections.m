//
//  CurrentUserCollections.m
//  Photos
//
//  Created by Apple on 2018/7/7.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "CurrentUserCollections.h"

@implementation CurrentUserCollections
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{@"cucId":@"id"};
}
@end
