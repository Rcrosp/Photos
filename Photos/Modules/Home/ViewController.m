//
//  ViewController.m
//  Photos
//
//  Created by Apple on 2018/7/3.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "PhotoModel.h"
#import "HomeImgCell.h"
#import "NSArray+JSON.h"
#import "NSString+JSON.h"
#import "HomeHeadView.h"
#import "CustomLabel.h"
#define pageSize 10
@interface ViewController ()<YBImageBrowserDelegate,YBImageBrowserDataSource>
@property(nonatomic, assign)int page;
@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, strong) NSMutableDictionary *heightDict;
@property(nonatomic, strong)YBImageBrowser *browse;
@property(nonatomic, strong)NSIndexPath *currentTouchIndexPath;
@property(nonatomic, strong)UIView *titleView;
@property(nonatomic, strong)UILabel *titleLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    [self setupUI];
    [self creatTitleView];
    Boolean haveCacheData = [self loadCacheData];
    if (haveCacheData == NO) {
        self.isLoading = YES;
        [self loadData:YES];
    }else {
       [self.tableView.mj_header beginRefreshing];
    }
   
}

- (void)loadMore {
    [self loadData:NO];
}

- (void)refresh {
    [self loadData:YES];
}

- (void)loadData:(Boolean)flag {
    int page = 0;
    if (flag) {
        self.page = 1;
        page = self.page;
    }else {
        page = self.page + 1;
    }
    [[NetAPIManager sharedManager] requestPhotos:page per_page:pageSize order_by:@"latest" success:^(id  _Nonnull json) {
        self.isLoading = NO;
       NSArray *arr = [NSArray modelArrayWithClass:[PhotoModel class] json:json];
        if (flag) {
            //只缓存第一页
            self.dataArray = nil;
            [self.dataArray addObjectsFromArray:arr];
            [self.tableView reloadData];
            [CacheUtil saveInfo:[json toJSONString] forKey:self.className];
            [self.tableView.mj_header endRefreshing];
           
        }else {
            [self.tableView.mj_footer endRefreshing];

            [self.dataArray addObjectsFromArray:arr];
            [self.tableView reloadData];
            self.page = self.page + 1;
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD showErrorMessage:@"加载失败，请重试"];
        if (flag) {
             [self.tableView.mj_header endRefreshing];
        }else{
             [self.tableView.mj_footer endRefreshing];
        }
        self.isLoading = NO;
        [self.tableView reloadEmptyDataSet];
    }];
}

#pragma mark --emptyDelegate
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    self.isLoading = YES;
    [self loadData:YES];
    [self.tableView reloadEmptyDataSet];
    //    [self.tableView.mj_header beginRefreshing];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PhotoModel *model = self.dataArray[indexPath.row];
    HomeImgCell *cell = [HomeImgCell cellWithTableView:tableView];
    cell.photoModel = model;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UIImageView *)getImageViewOfCellByIndexPath:(NSIndexPath *)indexPath {
    HomeImgCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (!cell) return nil;
    return cell.autoImageView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    PhotoModel *model = self.dataArray[indexPath.row];
    return model.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.currentTouchIndexPath = indexPath;
    YBImageBrowser *browser = [YBImageBrowser new];
    browser.downloaderShouldDecompressImages = NO;
    browser.dataSource = self;
    browser.currentIndex = indexPath.row;
    [browser show];
}

- (UIImageView * _Nullable)imageViewOfTouchForImageBrowser:(YBImageBrowser *)imageBrowser{
     return [self getImageViewOfCellByIndexPath:self.currentTouchIndexPath];
}

- (NSInteger)numberInYBImageBrowser:(YBImageBrowser *)imageBrowser {
    return self.dataArray.count;
}

- (YBImageBrowserModel *)yBImageBrowser:(YBImageBrowser *)imageBrowser modelForCellAtIndex:(NSInteger)index{
     PhotoModel *photoModel = self.dataArray[index];
    YBImageBrowserModel *model = [YBImageBrowserModel new];
    model.url = [NSURL URLWithString:photoModel.urls.regular];
    model.sourceImageView = [self getImageViewOfCellByIndexPath:[NSIndexPath indexPathForRow:index inSection:1]];
    return model;
}

-(NSMutableArray *)dataArray {
    if(_dataArray == nil){
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableDictionary *)heightDict {
    if (!_heightDict) {
        _heightDict = @{}.mutableCopy;
    }
    return _heightDict;
}

- (Boolean)loadCacheData {
    NSString *jsonStr = [CacheUtil getCacheInfoForKey:self.className];
    NSArray *arr = [NSArray modelArrayWithClass:[PhotoModel class] json:[jsonStr stringToArray]];
    if (arr && arr.count > 0) {
        [self.dataArray addObjectsFromArray:arr];
        [self.tableView reloadData];
        return YES;
    }
    
    return NO;
}


- (void)setupUI {
    HomeHeadView *headView = [[HomeHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90)];
    self.tableView.tableHeaderView = headView;
}

- (void)creatTitleView {
    self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, SCREEN_WIDTH, SafeAreaTopHeight1)];
    self.titleView.backgroundColor = [ZMColor colorWithHexString:@"#FFFFFF" alpha:0.f];
    [self.view addSubview:self.titleView];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 100) /2, statusbar + 8, 100, 22)];
    title.text = @"个人资料";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [ZMColor colorWithHexString:@"#333333" alpha:0.f];
    title.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:16];
    self.titleLabel = title;
    [self.titleView addSubview:title];
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (@available(iOS 11.0, *)) {
//        [self.titleView setBackgroundColor:[ZMColor colorWithHexString:@"FFFFFF" alpha:scrollView.contentOffset.y / SafeAreaTopHeight1]];
//        self.titleLabel.textColor = [ZMColor colorWithHexString:@"#333333" alpha:scrollView.contentOffset.y / SafeAreaTopHeight1];
//    }else {
//        CGFloat y = 64 - (-scrollView.contentOffset.y);
//        [self.titleView setBackgroundColor:[ZMColor colorWithHexString:@"FFFFFF" alpha:y / SafeAreaTopHeight1]];
//        self.titleLabel.textColor = [ZMColor colorWithHexString:@"#333333" alpha:y / SafeAreaTopHeight1];
//    }
//}
@end
