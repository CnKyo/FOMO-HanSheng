//
//  BaseViewController.h
//  FOMOPay
//
//  Created by clkj on 2019/8/12.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "ViewController.h"
#import "Header.h"
NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : ViewController

@property (strong,nonatomic) NSString *mNavTitle;

@property(nonatomic,strong)UIView *mView;
@property (nonatomic,strong)UITableView *mTabView;

@property (nonatomic,strong)NSMutableArray *DataSource;


- (void)LoadCellType:(NSUInteger )Type;

- (void)addTabView1;
- (void)addTabView2;
- (void)addTabView3;
- (void)addTabView4;



- (void)addNavgationLine;

- (void)CLAddNavType:(CLNavType)type andModel:(CLNavModel *)model completion:(void(^)(NSInteger tag))handel;

- (void)pushToViewController:(UIViewController *)vc;

- (void)CLNavBackAction;



@end

NS_ASSUME_NONNULL_END
