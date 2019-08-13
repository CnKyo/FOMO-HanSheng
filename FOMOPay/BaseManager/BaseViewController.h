//
//  BaseViewController.h
//  FOMOPay
//
//  Created by clkj on 2019/8/12.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : ViewController
@property (nonatomic,strong)NSString *a;
@property (nonatomic,strong)UITableView *TabView;
@property (nonatomic,strong)NSMutableArray *DataSource;

- (void)LoadNavType:(NSUInteger )type;

- (void)addTabView;

@end

NS_ASSUME_NONNULL_END
