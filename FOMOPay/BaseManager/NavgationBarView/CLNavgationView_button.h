//
//  CLNavgationView_button.h
//  FOMOPay
//
//  Created by clkj on 2019/8/15.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^CLNavgationView_buttonBtnBlock)(NSInteger tag);
@interface CLNavgationView_button : UIView
@property (copy,nonatomic) CLNavgationView_buttonBtnBlock mBtnBlock;
@property (weak, nonatomic) IBOutlet UIView *mRightView;
@property (weak, nonatomic) IBOutlet UIButton *mRightButton;

+ (CLNavgationView_button *)shareDefaultNavRightButton;

@end

NS_ASSUME_NONNULL_END
