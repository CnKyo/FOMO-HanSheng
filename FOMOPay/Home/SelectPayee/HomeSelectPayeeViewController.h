//
//  HomeSelectPayeeViewController.h
//  FOMOPay
//
//  Created by mac_clkj on 2019/8/26.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger,ShowButtonType) {
    
    ShowButtonTypeDefault = 0,
    ShowButtonTypeChange,
};

typedef void(^HomeSelectPayeeViewControllerBackBlock)(WKResipientInfoObj *mItem);

@interface HomeSelectPayeeViewController : BaseViewController

@property (nonatomic, assign) ShowButtonType type;

@property (nonatomic, strong) WKRemiitableEntity *mCurrentRemmitance;
///返回几级视图
@property (nonatomic, assign) NSInteger backVCS;

@property (copy,nonatomic) HomeSelectPayeeViewControllerBackBlock mBlock;



@property (strong,nonatomic) WKResipientInfoObj *mItem;


@property (nonatomic,strong) NSIndexPath *mInx;

@end

