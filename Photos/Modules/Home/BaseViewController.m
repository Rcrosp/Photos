//
//  BaseViewController.m
//  Photos
//
//  Created by Apple on 2018/7/5.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "BaseViewController.h"
//支持下拉刷新及无限加载；
//良好的界面风格及交互（含动画）；
//支持查看大图；
//支持离线查看；
//其他可以丰富该app的功能。

@interface BaseViewController ()<UITableViewDelegate, UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property(nonatomic, strong)NSMutableArray *imgArray;
@end

@implementation BaseViewController
-(NSMutableArray *)imgArray {
    if (_imgArray == nil) {
        _imgArray = [NSMutableArray array];
        for (int i =1; i <= 6; i ++) {
            
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading_00%d",i]];
            
            [_imgArray addObject:image];
            
        }

    }
    return _imgArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)setUI {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    tableView.top = statusbar;
    tableView.height = tableView.height - statusbar;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.emptyDataSetSource = self;
    tableView.emptyDataSetDelegate = self;
    tableView.tableFooterView = [UIView new];
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.tableView = tableView;
    __weak typeof(self) weakself = self;
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    
    [header setImages:self.imgArray forState:MJRefreshStateIdle];
    
    [header setImages:self.imgArray forState:MJRefreshStateRefreshing];
    
    self.tableView.mj_header = header;
    
    header.lastUpdatedTimeLabel.hidden =YES;
    
    header.stateLabel.hidden =YES;

    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakself loadMore];
    }];
}

- (void)loadMore {
    //交给子类实现
    [self.tableView.mj_footer endRefreshing];
}

- (void)refresh {
    //交给子类实现
    [self.tableView.mj_header endRefreshing];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 1;
}

#pragma mark - 无数据占位
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
    return YES;
}

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    return YES;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    self.isLoading = YES;
    [self.tableView reloadEmptyDataSet];
//    [self.tableView.mj_header beginRefreshing];
}

#pragma mark 设置图片动画
- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.isLoading) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"transform"];
        
        animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0)];
        
        animation.duration = 0.25;
        animation.cumulative = YES;
        animation.repeatCount = MAXFLOAT;
        
        return animation;
    }
    return nil;
}

- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView {
    if (self.isLoading) {
        return YES;
    }
    return NO;
}

//无数据占位
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    if (self.isLoading) {
         return [UIImage imageNamed:@"loading_001"];
    }
    return [UIImage imageNamed:@"img_null"];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return 0;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    if (self.isLoading) {
        return nil;
    }
    NSString *text = @"Whoops!";
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    paragraph.lineSpacing = 5;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size:24 * kScreenWidthRatio],
                                 NSForegroundColorAttributeName: [ZMColor colorWithHexString:@"#000000"],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    if (self.isLoading) {
        return nil;
    }
    NSString *text = @"Something's wrong.It's propably our fault.";
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    paragraph.lineSpacing = 5;
    
    NSDictionary *attributes = @{NSFontAttributeName:  [UIFont fontWithName:@"PingFangSC-Regular" size:14 * kScreenWidthRatio],
                                 NSForegroundColorAttributeName: [ZMColor colorWithHexString:@"#6C6C6C"],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    if (self.isLoading) {
        return nil;
    }
    NSString *text = @"Retry";
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    paragraph.lineSpacing = 5;
    
    NSDictionary *attributes = @{NSFontAttributeName:  [UIFont fontWithName:@"PingFangSC-Regular" size:14 * kScreenWidthRatio],
                                 NSForegroundColorAttributeName: [ZMColor colorWithHexString:@"#333333"],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

@end
