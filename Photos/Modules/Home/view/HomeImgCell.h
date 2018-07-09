//
//  HomeImgCell.h
//  Photos
//
//  Created by Apple on 2018/7/7.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoModel.h"
@interface HomeImgCell : UITableViewCell
@property (nonatomic, strong) UIImageView *autoImageView;
@property (nonatomic, strong) UILabel *aurthLabel;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) PhotoModel *photoModel;
@end
