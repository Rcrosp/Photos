
//
//  HomeHeadView.m
//  Photos
//
//  Created by Apple on 2018/7/7.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "HomeHeadView.h"

@implementation HomeHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    UILabel *dateLabel =  [[UILabel alloc] init];
    dateLabel.font = [UIFont fontWithName:kULSystemBoldFont size:16 * kScreenWidthRatio];
    dateLabel.textColor = [ZMColor colorWithHexString:@"#666666"];
    [self addSubview:dateLabel];
    NSDate *now = [NSDate date];
    dateLabel.text = [NSString stringWithFormat:@"%@,%@ %@",[DateUtils getWeekByTimeStr:now],[DateUtils getMonthByTimeStr:now],[DateUtils getDayByTimeStr:now]];
//    @"STATURDAY,JULY 7";
    
    UILabel *titleLabel =  [[UILabel alloc] init];
    titleLabel.font = [UIFont fontWithName:kULSystemBoldFont size:24 * kScreenWidthRatio];
    titleLabel.textColor = [ZMColor colorWithHexString:@"#333333"];
    [self addSubview:titleLabel];
    titleLabel.text = @"今日为您推荐的作品集";
    
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(34);
        make.left.mas_equalTo(16);
    }];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(dateLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(16);
    }];
}

@end
