//
//  BaseViewController.h
//  FOMOPay
//
//  Created by clkj on 2019/8/12.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "ViewController.h"
#import "Header.h"

@interface BaseViewController : ViewController

@property (strong,nonatomic) NSString *mNavTitle;

@property(nonatomic,strong)UIView *mView;
@property (nonatomic,strong)UITableView *mTabView;

@property (nonatomic,strong)NSMutableArray *DataSource;



- (void)LoadCellType:(NSUInteger )Type;//列表

//- (void)addHomeTabView;
//- (void)addHiStoryTabView;
//- (void)addCollectionTabView;
//- (void)addMeTabView;
//- (void)addMeLanguageTabView;


- (void)addNavgationLine;

- (void)CLAddNavType:(CLNavType)type andModel:(CLNavModel *)model completion:(void(^)(NSInteger tag))handel;

- (void)pushToViewController:(UIViewController *)vc;

- (void)CLNavBackAction;

- (void)ResetLayout; // 针对5s小屏幕手机的底部按钮挡住tabview进行重设约束


@end

