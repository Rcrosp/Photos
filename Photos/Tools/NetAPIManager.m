//
//  NetAPIManager.m
//  Photos
//
//  Created by Apple on 2018/7/7.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "NetAPIManager.h"

@implementation NetAPIManager
+ (instancetype)sharedManager {
    static NetAPIManager *shared_manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        shared_manager = [[self alloc] init];
    });
    return shared_manager;
}

- (void)requestPhotos:(NSInteger)page per_page:(NSInteger)per_page order_by:(NSString *)order_by success:(Success)success failure:(Failure)failure {
    NSDictionary *dict = @{@"page":@(page),@"per_page":@(per_page),@"order_by":order_by,@"client_id":accessKey};
    [[NetworkRequestManage sharedManager] requestWithUrl:[NetAPIManager getUrl:api_photos] requestMethod:NetworkRequestMethodGET Params:dict Success:^(id  _Nonnull json) {
        success(json);
    } Failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}

- (void)requestRandomPhotoWithCount:(NSInteger)count success:(_Nonnull Success)success
                              failure:(_Nonnull Failure)failure{
    NSDictionary *dict = @{@"client_id":accessKey,@"count":@(count)};
    [[NetworkRequestManage sharedManager] requestWithUrl:[NetAPIManager getUrl:api_random_photo] requestMethod:NetworkRequestMethodGET Params:dict Success:^(id  _Nonnull json) {
        success(json);
    } Failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}

+ (NSString *)getUrl:(NSString *)url {
    if (url.length == 0) {
        return nil;
    }
    return [NSString stringWithFormat:@"%@%@",baseUrl,url];
}
@end
