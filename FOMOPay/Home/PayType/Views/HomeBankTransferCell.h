//
//  HomeBankTransferCell.h
//  FOMOPay
//
//  Created by mac_clkj on 2019/8/28.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeBankTransferCell : UITableViewCell

@property (nonatomic, copy) void (^HomeBankTransferCellBlock)(NSInteger tag);

@end

