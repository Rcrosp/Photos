//
//  NetworkRequestManage.h
//  Photos
//
//  Created by Apple on 2018/7/6.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "YYKit.h"
typedef NS_ENUM(NSInteger, NetworkRequestMethodENUM) {
    NetworkRequestMethodPOST,
    NetworkRequestMethodGET
};

typedef void (^Success)(_Nonnull id json);
typedef void (^Failure)(NSError *_Nonnull error);
@interface NetworkRequestManage : NSObject
@property (nonnull, nonatomic, strong) AFHTTPSessionManager  *requestManager;

+ (NetworkRequestManage *_Nonnull)sharedManager;

-(void)requestWithUrl:(NSString *)url requestMethod:(NetworkRequestMethodENUM)requestMethod
               Params:( NSDictionary *)params
              Success:(_Nonnull Success)success
              Failure:(_Nonnull Failure)failure;
@end
