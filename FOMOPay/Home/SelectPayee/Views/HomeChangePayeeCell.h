//
//  HomeChangePayeeCell.h
//  FOMOPay
//
//  Created by mac_clkj on 2019/8/27.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeChangePayeeCell : UITableViewCell

@property (nonatomic, copy) void(^HomeChangePayeeCellText)(NSString *text,NSInteger tag);
@property (nonatomic, copy) void(^HomeChangePayeeCellButton)(NSInteger tag);
@property (strong,nonatomic) WKResipientInfoObj *mItem;

@end

