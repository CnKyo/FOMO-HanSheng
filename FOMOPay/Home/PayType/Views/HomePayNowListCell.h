//
//  HomePayNowListCell.h
//  FOMOPay
//
//  Created by mac_clkj on 2019/8/28.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePayNowListCell : UITableViewCell

@property (nonatomic, copy) void (^HomePayNowListCellBlock)(NSInteger tag);

@end
