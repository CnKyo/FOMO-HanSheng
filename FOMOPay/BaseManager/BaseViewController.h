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
@property(nonatomic,strong)UIView *mView;
@property (nonatomic,strong)UITableView *mTabView;
@property (nonatomic,strong)NSMutableArray *DataSource;

- (void)LoadNavType:(NSUInteger )Type;

- (void)addTabView;


@end

NS_ASSUME_NONNULL_END
