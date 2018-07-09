//
//  BaseViewController.h
//  Photos
//
//  Created by Apple on 2018/7/5.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
@property(nonatomic, assign)Boolean isLoading;
@property(nonatomic, weak)UITableView *tableView;
- (void)loadMore;
- (void)refresh;
@end
