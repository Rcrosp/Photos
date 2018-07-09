//
//  UrlsModel.h
//  Photos
//
//  Created by Apple on 2018/7/7.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UrlsModel : NSObject
@property(nonatomic, strong)NSString *raw;
@property(nonatomic, strong)NSString *full;
@property(nonatomic, strong)NSString *regular;
@property(nonatomic, strong)NSString *small;
@property(nonatomic, strong)NSString *thumb;
@end
