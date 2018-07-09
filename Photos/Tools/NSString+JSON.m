//
//  NSString+JSON.m
//  Photos
//
//  Created by Apple on 2018/7/7.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "NSString+JSON.h"

@implementation NSString (JSON)
- (NSArray *)stringToArray{
    if (self) {
        id tmp = [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments | NSJSONReadingMutableLeaves | NSJSONReadingMutableContainers error:nil];
        
        if (tmp) {
            if ([tmp isKindOfClass:[NSArray class]]) {
                
                return tmp;
                
            } else if([tmp isKindOfClass:[NSString class]]
                      || [tmp isKindOfClass:[NSDictionary class]]) {
                
                return [NSArray arrayWithObject:tmp];
                
            } else {
                return nil;
            }
        } else {
            return nil;
        }
        
    } else {
        return nil;
    }
}
@end
