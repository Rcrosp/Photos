//
//  PCH.h
//  Photos
//
//  Created by Apple on 2018/7/5.
//  Copyright © 2018年 Apple. All rights reserved.
//

#ifndef PCH_h
#define PCH_h
#import "api.h"
#import "NetAPIManager.h"
#import "ZMColor.h"
#import <Masonry.h>
#import <YYKit.h>
#import <UIImageView+WebCache.h>
#import "CacheUtil.h"
#import "MJRefresh.h"
#import "UIScrollView+EmptyDataSet.h"
#import "DateUtils.h"
#import "YBImageBrowser.h"
#import <MBProgressHUD+JDragon.h>
#import "PreferenceUtil.h"
#define accessKey @"e21131db7645c940e5a03115b6a3b55c10dcc1f1b13dc80b808f959d382d4242"
#define kULSystemFont                     @"Helvetica-Light"
#define kULSystemBoldFont                 @"Helvetica-Bold"
#define kULSystemRegularFont              @"Helvetica-Regular"



#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)
//字体图片适配
#define kScreenWidthRatio  (SCREEN_WIDTH / 414.0)
#define kScreenHeightRatio (SCREEN_HEIGHT / 736.0)
#define statusbar (SCREEN_HEIGHT == 812.0 ? 44 : 20)
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_IPHONE_X (IS_IPHONE && SCREEN_MAX_LENGTH == 812.0)

#define SafeAreaTopHeight1 (SCREEN_HEIGHT == 812.0 ? 88 : 64)
#define baseUrl @"https://api.unsplash.com"
#endif /* PCH_h */
