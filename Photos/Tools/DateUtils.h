//
//  DateUtils.h
//  Analyst1
//
//  Created by Apple on 2018/6/7.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtils : NSObject
+ (NSString *)getYMDByTimeStr:(NSDate *)date;
+ (NSString *)getDayByTimeStr:(NSDate *)date;
+ (NSString *)getWeekByTimeStr:(NSDate *)date;
+ (NSString *)getMonthByTimeStr:(NSDate *)date;
+ (NSString *)getHMMByTimeStr:(NSDate *)date;
+ (NSString *)getHMByTimeStr:(NSDate *)date;
+ (NSString *)transformDateTime:(NSTimeInterval)time withFormate:(NSString *)formate;
+ (NSString *)getYMDWeekHMByTimeStr:(NSDate *)date;
+ (NSString *)getYMDHMByTimeStr:(NSDate *)date;
+ (BOOL)isSameDay:(NSTimeInterval)time1 date2:(NSTimeInterval)time2;
@end
