//
//  NetAPIManager.h
//  Photos
//
//  Created by Apple on 2018/7/7.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkRequestManage.h"
@interface NetAPIManager : NSObject
+ (instancetype)sharedManager ;
- (void)requestPhotos:(NSInteger)page per_page:(NSInteger)per_page order_by:(NSString *)order_by  success:(_Nonnull Success)success
              failure:(_Nonnull Failure)failure;
- (void)requestRandomPhotoWithCount:(NSInteger)count success:(_Nonnull Success)success
                              failure:(_Nonnull Failure)failure;
@end
