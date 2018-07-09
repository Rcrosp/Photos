//
//  UserModel.m
//  Photos
//
//  Created by Apple on 2018/7/7.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{@"uid":@"id"};
}
@end
