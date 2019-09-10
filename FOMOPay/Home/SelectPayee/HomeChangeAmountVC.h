//
//  HomeChangeAmountVC.h
//  FOMOPay
//
//  Created by mac_clkj on 2019/8/27.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^HomeChangeAmountVCBlock)(WKRemiitableEntity *mCurrentRemmitance);
@interface HomeChangeAmountVC : BaseViewController
@property (nonatomic, strong) WKRemiitableEntity *mCurrentRemmitance;

@property (copy,nonatomic) HomeChangeAmountVCBlock mBlock;

@end

NS_ASSUME_NONNULL_END
