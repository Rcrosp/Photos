
//
//  DateUtils.m
//  Analyst1
//
//  Created by Apple on 2018/6/7.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "DateUtils.h"
@implementation DateUtils
+ (NSString *)getYMDWeekHMByTimeStr:(NSDate *)date {
    NSString *ymdStr = [self getYMDByTimeStr:date];
    NSString *week = [self getWeekByTimeStr:date];
    NSString *hmStr = [self getHMByTimeStr:date];
    return [NSString stringWithFormat:@"%@  (%@)  %@",ymdStr,week,hmStr];
}

+ (NSString *)getYMDHMByTimeStr:(NSDate *)date {
    NSString *ymdStr = [self getYMDByTimeStr:date];
    NSString *hmStr = [self getHMByTimeStr:date];
    return [NSString stringWithFormat:@"%@  %@",ymdStr,hmStr];

}

+ (NSString *)getYMDByTimeStr:(NSDate *)date {
    NSDateFormatter *formatter  = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY年MM月dd日"];//可以根据自己的需要设置格式（如@"MM，dd"）
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

+ (NSString *)getHMMByTimeStr:(NSDate *)date {
    NSDateFormatter *formatter  = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];//可以根据自己的需要设置格式（如@"MM，dd"）
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

+ (NSString *)getHMByTimeStr:(NSDate *)date {
    NSDateFormatter *formatter  = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];//可以根据自己的需要设置格式（如@"MM，dd"）
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

+ (NSString *)getDayByTimeStr:(NSDate *)date {
    NSDateComponents *comps = [self getDateComponents:date];
    if(comps.day > 9) {
      return [NSString stringWithFormat:@"%ld",comps.day];
    }else {
       return [NSString stringWithFormat:@"0%ld",comps.day];
    }
}

+ (NSString *)getWeekByTimeStr:(NSDate *)date {
    NSDateComponents *comps = [self getDateComponents:date];
    switch (comps.weekday) {
        case 1:
            return @"SUNDAY";
            break;
        case 2:
            return @"MONDAY";
            break;
        case 3:
            return @"TUESDAY";
            break;
        case 4:
            return @"WEDNESDAY";
            break;
        case 5:
            return @"THURSDAY";
            break;
        case 6:
            return @"FRIDAY";
            break;
        default:
            return @"SATURDAY";
            break;
    }
}


+ (NSString *)getMonthByTimeStr:(NSDate *)date {
    NSDateComponents *comps = [self getDateComponents:date];
    switch (comps.month) {
        case 1:
            return @"JAN";
            break;
        case 2:
            return @"FEB";
            break;
        case 3:
            return @"MAR";
            break;
        case 4:
            return @"APR";
            break;
        case 5:
            return @"MAY";
            break;
        case 6:
            return @"JUN";
            break;
        case 7:
            return @"JULY";
            break;
        case 8:
            return @"AUG";
            break;
        case 9:
            return @"SEPT";
            break;
        case 10:
            return @"OCT";
            break;
        case 11:
            return @"NOV";
            break;
        case 12:
            return @"DEC";
            break;
        default:
            break;
    }
    return @"";
}

+ (NSDateComponents *)getDateComponents:(NSDate *)date {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
        NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
//    now=[NSDate date];
    comps = [calendar components:unitFlags fromDate:date];
//    NSLog(@"-----------weekday is %ld",(long)[comps weekday]);
    return comps;

}

+ (NSString *)transformDateTime:(NSTimeInterval)time withFormate:(NSString *)formate{
    
    NSDate *now = [NSDate date];
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:time];
    NSTimeInterval dateDif = [now timeIntervalSinceDate:date];
    
    if (dateDif < 60)
    {
        return [NSString stringWithFormat:@"刚刚"];
        //        return [NSString stringWithFormat:@"%@秒前",@(fmaxf(dateDif, 0))];
    }
    
    else if (dateDif < 900) {
        
        NSInteger minute = dateDif / 60;
        
        return [NSString stringWithFormat:@"%@分钟前", @(minute)];
        
    } else if (dateDif >= 900 && dateDif <= 1800) {
        
        return @"半小时前";
        
    } else if (dateDif > 1800 && dateDif <= 3600) {
        
        return @"1小时前";
        
    } else if (dateDif > 3600 && dateDif <= 3600*24) {
        
        NSInteger hour = dateDif / 3600;
        
        return [NSString stringWithFormat:@"%@小时前", @(hour)];
        
    } else if (dateDif > 3600*24 && dateDif <= 3600*48) {
        
        return @"昨天";
        
    } else if (dateDif > 3600*48 && dateDif <= 3600*72) {
        
        return @"前天";
        
    } else {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        [formatter setDateFormat:formate];
        
        NSString *formatterStr = [formatter stringFromDate:date];
        
        return formatterStr;
        
    }
}

/**
 *  是否为同一天
 */
+ (BOOL)isSameDay:(NSTimeInterval)time1 date2:(NSTimeInterval)time2
{
    NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:time1 * 0.001];
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:time2 * 0.001];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    
    return [comp1 day]   == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}
@end
