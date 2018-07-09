//
//  PreferenceUtil.m
//  Photos
//
//  Created by Apple on 2018/7/8.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "PreferenceUtil.h"
#define IsFirst @"isFirst"
@implementation PreferenceUtil
+(Boolean)isFirst{
    return [self getBoolean:IsFirst];
}

+(void)saveIsFirst:(Boolean)isFirst{
    [self saveBoolean:IsFirst booleanValue:isFirst];
}

+ (Boolean)getBoolean:(NSString *)key{
    //1.获取NSUserDefaults对象
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //读取保存的数据
    Boolean value = [defaults boolForKey:key];
    return value;
}

+ (void)saveBoolean:(NSString *)key booleanValue:(Boolean)value {
    //1.获取NSUserDefaults对象
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setBool:value forKey:key];
    //3.强制让数据立刻保存
    [defaults synchronize];
}
@end
