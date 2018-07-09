//
//  HomePageViewController.m
//  Photos
//
//  Created by Apple on 2018/7/7.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "HomePageViewController.h"

@interface HomePageViewController ()<TYTabPagerControllerDelegate, TYTabPagerControllerDataSource>
@property(nonatomic, strong)NSArray *datas;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
}

- (void)setUI {
    
    self.view.backgroundColor = [ZMColor colorWithHexString:@"#F2F3F7"];
    self.layout.scrollView.scrollEnabled = YES;
    
    
    self.tabBarHeight = 44;
    self.tabBar.backgroundColor = [ZMColor colorWithHexString:@"#FFFFFF"];
    self.tabBar.layout.normalTextColor = [ZMColor colorWithHexString:@"#666666"];
    self.tabBar.layout.normalTextFont =  [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    self.tabBar.layout.selectedTextColor = [ZMColor colorWithHexString:@"#0077D1"];
    self.tabBar.layout.selectedTextFont = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    self.tabBar.layout.progressColor = [ZMColor colorWithHexString:@"#0077D1"];
    self.tabBar.layout.barStyle = TYPagerBarStyleProgressBounceView;
    self.tabBar.layout.progressWidth = 20;
    self.tabBar.layout.cellWidth = CGRectGetWidth(self.view.frame)/3;
    self.tabBar.layout.cellEdging = 0;
    self.tabBar.layout.cellSpacing = 0;
    
    self.dataSource = self;
    self.delegate = self;
    [self loadData];
}

- (void)loadData {
    //
    NSMutableArray *datas = [NSMutableArray array];
    [datas addObject:@"Latest"];
    [datas addObject:@"Popular"];
    [datas addObject:@"Oldest"];
    _datas = [datas copy];
    
    // only add controller at index 1
    
    [self reloadData];
}

#pragma mark - TYTabPagerControllerDataSource
- (NSInteger)numberOfControllersInTabPagerController {
    return _datas.count;
}

- (UIViewController *)tabPagerController:(TYTabPagerController *)tabPagerController controllerForIndex:(NSInteger)index prefetching:(BOOL)prefetching {
    if (index == 0) {
        UIViewController *VC = [[UIViewController alloc]init];
        return VC;
    }else {
        UIViewController *VC = [[UIViewController alloc]init];
        return VC;
    }
    
}

- (NSString *)tabPagerController:(TYTabPagerController *)tabPagerController titleForIndex:(NSInteger)index {
    NSString *title = _datas[index];
    return title;
}
@end
