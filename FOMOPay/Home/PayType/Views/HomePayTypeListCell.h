//
//  HomePayTypeListCell.h
//  FOMOPay
//
//  Created by mac_clkj on 2019/8/28.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePayTypeListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel1;
@property (nonatomic, copy) void (^HomePayTypeListCellBlock)(NSInteger tag);

@end

