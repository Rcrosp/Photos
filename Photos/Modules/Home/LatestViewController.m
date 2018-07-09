//
//  LatestViewController.m
//  Photos
//
//  Created by Apple on 2018/7/7.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "LatestViewController.h"
#import "PhotoModel.h"
#import "HomeImgCell.h"
#import "NSArray+JSON.h"
#import "NSString+JSON.h"
#import "HomeHeadView.h"
#define pageSize 10
@interface LatestViewController ()
@property(nonatomic, assign)int page;
@property(nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableDictionary *heightDict;
@end

@implementation LatestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    [self setupUI];
    [self loadCacheData];
    [self.tableView.mj_header beginRefreshing];
}

- (void)setupUI {
    HomeHeadView *headView = [[HomeHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 90)];
    //    headView.backgroundColor = [ZMColor colorWithHexString:@"#F2F3F7"];
    self.tableView.tableHeaderView = headView;
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
        self.dataArray = nil;
    }else {
        page = self.page + 1;
    }
    
    [[NetAPIManager sharedManager] requestPhotos:page per_page:pageSize order_by:@"latest" success:^(id  _Nonnull json) {
        NSLog(@"%@",json);
        NSArray *arr = [NSArray modelArrayWithClass:[PhotoModel class] json:json];
        [self.dataArray addObjectsFromArray:arr];
        [self.tableView reloadData];
        if (flag) {
            //只缓存第一页
            [CacheUtil saveInfo:[json toJSONString] forKey:self.className];
            [self.tableView.mj_header endRefreshing];
        }else {
            self.page = self.page + 1;
            [self.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"%@",error);
        if (flag) {
            [self.tableView.mj_header endRefreshing];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
    }];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    PhotoModel *model = self.dataArray[indexPath.row];
    return model.cellHeight;
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

- (void)loadCacheData {
    NSString *jsonStr = [CacheUtil getCacheInfoForKey:self.className];
    NSArray *arr = [NSArray modelArrayWithClass:[PhotoModel class] json:[jsonStr stringToArray]];
    if (arr && arr.count > 0) {
        [self.dataArray addObjectsFromArray:arr];
        [self.tableView reloadData];
    }
}
@end
