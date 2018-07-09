//
//  HomeImgCell.m
//  Photos
//
//  Created by Apple on 2018/7/7.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "HomeImgCell.h"

@implementation HomeImgCell

+(instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *cellID = @"HomeImgCell";
    HomeImgCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[HomeImgCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self.contentView addSubview:self.autoImageView];
    [self.contentView addSubview:self.aurthLabel];
    [self.autoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(1.5, 0, 0, 0));
    }];
    [self.aurthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.bottom.mas_equalTo(-12);
    }];
}

#pragma mark ------ < Getter > ------
#pragma mark
- (UIImageView *)autoImageView {
    if (!_autoImageView) {
        _autoImageView = [UIImageView new];
    }
    return _autoImageView;
}

-(UILabel *)aurthLabel {
    if (!_aurthLabel) {
        _aurthLabel = [[UILabel alloc] init];
        _aurthLabel.font = [UIFont fontWithName:kULSystemBoldFont size:12 * kScreenWidthRatio];
        _aurthLabel.textColor = [ZMColor colorWithHexString:@"#FFFFFF"];
    }
    return _aurthLabel;
}

-(void)setPhotoModel:(PhotoModel *)photoModel {
    _photoModel = photoModel;
    [self.autoImageView sd_setImageWithURL:[NSURL URLWithString:photoModel.urls.small] placeholderImage:[UIImage imageNamed:@"bg.jpg"]];
    self.aurthLabel.text = [NSString stringWithFormat:@"photo by %@",photoModel.user.name];
}

@end
