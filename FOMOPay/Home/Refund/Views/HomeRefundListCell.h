//
//  HomeRefundListCell.h
//  FOMOPay
//
//  Created by mac_clkj on 2019/8/24.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeRefundListCell : UITableViewCell

@property (nonatomic, copy) void(^HomeRefundListCellBlock)(NSString *string,NSInteger tag);
@property (nonatomic, copy) void(^HomeRefundListCellButtonBlock)(void);

- (void)updateTitle:(NSString *)title;

@end

