//
//  CLHomeViewController.h
//  FOMOPay
//
//  Created by clkj on 2019/8/12.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    CLHomeViewControllerPushType_Create = 0,///创建汇款
    CLHomeViewControllerPushType_Modify = 1,///修改汇款
} CLHomeViewControllerPushType;///汇款View push类型

typedef void(^HomeChangeAmountVCBlock)(WKRemiitableEntity *mCurrentRemmitance);

@interface CLHomeViewController : BaseViewController

@property (nonatomic, strong) WKRemiitableEntity *mCurrentRemmitance;

@property (copy,nonatomic) HomeChangeAmountVCBlock mBlock;

@property (assign,nonatomic) CLHomeViewControllerPushType mType;

@end

NS_ASSUME_NONNULL_END
