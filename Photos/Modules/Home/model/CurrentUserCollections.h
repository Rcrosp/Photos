//
//  CurrentUserCollections.h
//  Photos
//
//  Created by Apple on 2018/7/7.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrentUserCollections : NSObject
@property(nonatomic, strong)NSString *cucId;
@property(nonatomic, strong)NSString *title;
@property(nonatomic, strong)NSString *published_at;
@property(nonatomic, strong)NSString *updated_at;
@property(nonatomic, assign)NSString *curated;
@property(nonatomic, strong)NSString *cover_photo;
@property(nonatomic, strong)NSString *user;
@end
