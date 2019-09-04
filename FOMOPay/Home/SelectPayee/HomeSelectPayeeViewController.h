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

@interface HomeSelectPayeeViewController : BaseViewController

@property (nonatomic, assign) ShowButtonType type;

@property (nonatomic, strong) WKRemiitableEntity *mCurrentRemmitance;

@end

