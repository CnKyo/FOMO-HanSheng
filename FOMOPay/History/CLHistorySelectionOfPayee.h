//
//  CLHistorySelectionOfPayee.h
//  FOMOPay
//
//  Created by clkj on 2019/9/3.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CLHistorySelectionOfPayeeBlock)(WKResipientInfoObj *mItem);

@interface CLHistorySelectionOfPayee : BaseViewController

@property (copy,nonatomic) CLHistorySelectionOfPayeeBlock mBlock;

@end

NS_ASSUME_NONNULL_END
