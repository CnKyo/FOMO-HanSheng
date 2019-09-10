//
//  HomeBankTransferCell.h
//  FOMOPay
//
//  Created by mac_clkj on 2019/8/28.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeBankTransferCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *secondStepLabel;

@property (weak, nonatomic) IBOutlet UILabel *bankNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *accountNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *accountLabel;

@property (weak, nonatomic) IBOutlet UILabel *orderLabel;

@property (nonatomic, copy) void (^HomeBankTransferCellBlock)(NSInteger tag);

@end

