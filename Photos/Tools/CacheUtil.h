//
//  CacheUtil.h
//  Photos
//
//  Created by Apple on 2018/7/7.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheUtil : NSObject
+(void)saveInfo:(NSString *)cacheInfo forKey:(NSString *)key;
+(NSString *)getCacheInfoForKey:(NSString *)key;
+(void)clearCacheForkey:(NSString *)key;
@end
