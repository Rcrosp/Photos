//
//  PhotoModel.h
//  Photos
//
//  Created by Apple on 2018/7/7.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LinksModel.h"
#import "UrlsModel.h"
#import "UserModel.h"
@interface PhotoModel : NSObject
@property(nonatomic, strong)NSString *pid;
@property(nonatomic, strong)NSString *created_at;
@property(nonatomic, strong)NSString *updated_at;
@property(nonatomic, strong)NSNumber *width;
@property(nonatomic, strong)NSNumber *height;
@property(nonatomic, strong)NSString *color;
@property(nonatomic, strong)NSNumber *likes;
@property(nonatomic, assign)Boolean liked_by_user;
@property(nonatomic, strong)NSString *pDescription;
@property(nonatomic, strong)LinksModel *links;
@property(nonatomic, strong)UrlsModel *urls;
@property(nonatomic, strong)UserModel *user;
@property(nonatomic, assign)CGFloat cellHeight;
@end

