//
//  DPLogInView.h
//  FOMOPay
//
//  Created by mac_clkj on 2019/8/19.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DPLogInView : UIView

@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *alertLabel;

@property (nonatomic, copy) void(^LogInViewBlock)(NSString *content);

+ (DPLogInView *)shareView;

@end

NS_ASSUME_NONNULL_END
