//
//  HomeListCell.h
//  FOMOPay
//
//  Created by mac_clkj on 2019/8/20.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HomeDataObject.h"

typedef NS_ENUM(NSInteger,HomeListCellType) {
    
    HomeListCellTypeHome = 0,
    HomeListCellTypeChangeAmount,
};

@interface HomeListCell : UITableViewCell

@property (nonatomic, assign) HomeListCellType type;
@property (nonatomic, copy) void(^HomeListCellBlock)(NSString *string,NSInteger tag);
@property (nonatomic, copy) void(^HomeListCellButtonBlock)(NSString *unit);

@end

