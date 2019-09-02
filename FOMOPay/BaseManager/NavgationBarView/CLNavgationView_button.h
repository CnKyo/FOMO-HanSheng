//
//  CLNavgationView_button.h
//  FOMOPay
//
//  Created by clkj on 2019/8/15.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^CLNavgationView_buttonBtnBlock)(NSInteger tag);

@interface CLNavgationView_button : UIView
@property (copy,nonatomic) CLNavgationView_buttonBtnBlock  mRightBtnBlock;
@property (weak, nonatomic) IBOutlet UIView *mRightView;
@property (weak, nonatomic) IBOutlet UIImageView *mRightImg;
@property (weak, nonatomic) IBOutlet UIButton *mRightBtn;

+ (CLNavgationView_button *)shareDefaultNavRightButton;
+ (CLNavgationView_button *)shareDefaultNavRightButtonOther;
+(CLNavgationView_button *)shareDefaultNavRightButtonAlter;

@end


