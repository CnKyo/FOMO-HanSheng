//
//  HomeRefundSelectBankView.h
//  FOMOPay
//
//  Created by mac_clkj on 2019/8/24.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeRefundSelectBankView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, copy) void (^HomeRefundSelectBankViewBlock)(NSString *string,NSInteger tag);

+ (HomeRefundSelectBankView *)shareView;

- (void)updataSource:(NSArray *)array;

@end
