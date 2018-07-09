//
//  CacheUtil.m
//  Photos
//
//  Created by Apple on 2018/7/7.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "CacheUtil.h"
#define yyCache [YYCache cacheWithName:@"CacheUtil"]
@implementation CacheUtil
+(void)saveInfo:(NSString *)cacheInfo forKey:(NSString *)key {
    //根据key写入缓存value
    [yyCache setObject:cacheInfo forKey:key];
}

+ (NSString *)getCacheInfoForKey:(NSString *)key {
   
    //判断缓存是否存在
    BOOL isContains=[yyCache containsObjectForKey:key];
    NSLog(@"containsObject : %@", isContains?@"YES":@"NO");
    //根据key读取数据
    NSString *value = (NSString *)[yyCache objectForKey:key];
    NSLog(@"value : %@",value);
    return value;
}

+ (void)clearCacheForkey:(NSString *)key {
    //根据key移除缓存
    [yyCache removeObjectForKey:key];
    //移除所有缓存
    [yyCache removeAllObjects];
}

@end
