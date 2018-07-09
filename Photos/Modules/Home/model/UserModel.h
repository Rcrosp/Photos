//
//  UserModel.h
//  Photos
//
//  Created by Apple on 2018/7/7.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProfileImageModel.h"
#import "LinksModel.h"
@interface UserModel : NSObject
@property(nonatomic, strong)NSString *uid;
@property(nonatomic, strong)NSString *username;
@property(nonatomic, strong)NSString *name;
@property(nonatomic, strong)NSString *portfolio_url;
@property(nonatomic, strong)NSString *bio;
@property(nonatomic, strong)NSString *location;
@property(nonatomic, strong)NSNumber *total_likes;
@property(nonatomic, strong)NSNumber *total_photos;
@property(nonatomic, strong)NSNumber *total_collections;
@property(nonatomic, strong)NSString *instagram_username;
@property(nonatomic, strong)NSString *twitter_username;
@property(nonatomic, strong)NSString *first_name;
@property(nonatomic, strong)NSString *last_name;
@property(nonatomic, strong)ProfileImageModel *profile_image;
@property(nonatomic, strong)LinksModel *links;
@end
