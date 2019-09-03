//
//  HomeRefundViewController.h
//  FOMOPay
//
//  Created by mac_clkj on 2019/8/24.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "BaseViewController.h"

typedef enum : NSUInteger {
    ///首页进入
    HomeRefundViewControllerPushType_home,
    ///退款账户列表进入
    HomeRefundViewControllerPushType_refundList,
    ///其他页面进入
    HomeRefundViewControllerPushType_other,
} HomeRefundViewControllerPushType;

typedef void(^HomeRefundViewControllerBackBlock)(BOOL isRefresh);

@interface HomeRefundViewController : BaseViewController

@property (nonatomic,copy) HomeRefundViewControllerBackBlock mBackBlock;

@property (nonatomic, copy) NSString *unitString;

@property (nonatomic, assign) HomeRefundViewControllerPushType mPushType;

@end

