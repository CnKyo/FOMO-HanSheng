//
//  HomeSureInfoViewController.h
//  FOMOPay
//
//  Created by mac_clkj on 2019/8/27.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeSureInfoViewController : BaseViewController
@property (strong,nonatomic) WKResipientInfoObj *mItem;
@property (nonatomic, strong) WKRemiitableEntity *mCurrentRemmitance;
@property (strong, nonatomic) WKOrderInfo *mItemC;

@end

NS_ASSUME_NONNULL_END
