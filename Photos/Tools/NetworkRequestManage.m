//
//  NetworkRequestManage.m
//  Photos
//
//  Created by Apple on 2018/7/6.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "NetworkRequestManage.h"

static NetworkRequestManage *_sharedNetworkRequestManage = nil;

@implementation NetworkRequestManage

+ (NetworkRequestManage *)sharedManager {
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        _sharedNetworkRequestManage = [[self alloc] init];
    });
    return _sharedNetworkRequestManage;
}

- (instancetype) init
{
    if (!self) {
        self = [super init];
    }
    if (!self.requestManager) {
        self.requestManager = [[AFHTTPSessionManager alloc] init];
        self.requestManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.requestManager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        [self.requestManager.requestSerializer setValue:@"<Application Id>" forHTTPHeaderField:@"X-Parse-Application-Id"];
        [self.requestManager.requestSerializer setValue:@"<API Key>" forHTTPHeaderField:@"X-Parse-REST-API-Key"];
        [self.requestManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    return self;
}

//基本请求
-(void)requestWithUrl:(NSString *)url requestMethod:(NetworkRequestMethodENUM)requestMethod
               Params:(NSDictionary *)params
              Success:(_Nonnull Success)success
              Failure:(_Nonnull Failure)failure;
{
    
    
    NSLog(@"发送请求:%@\n",url);
    NSLog(@"发送参数:%@\n",params);
    
    
    if (requestMethod == NetworkRequestMethodGET) {
        [_sharedNetworkRequestManage.requestManager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [_sharedNetworkRequestManage processJson:responseObject AtSuccessBlock:success AtFailureBlock:failure];
           
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(error);
        }];
    } else {
        [_sharedNetworkRequestManage.requestManager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [_sharedNetworkRequestManage processJson:responseObject AtSuccessBlock:success AtFailureBlock:failure];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(error);
        }];
    }
}

- (void)processJson:(id)json AtSuccessBlock:(Success)success AtFailureBlock:(Failure)failure
{
    if (json) {
        if ([json isKindOfClass:[NSDictionary class]]||
            [json isKindOfClass:[NSArray class]]) {
            success(json);
        } else {
            failure([NSError errorWithDomain:@"服务器错误" code:-1 userInfo:nil]);
        }
    } else {
        failure([NSError errorWithDomain:@"服务器错误" code:-1 userInfo:nil]);
    }
}

@end
