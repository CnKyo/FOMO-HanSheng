//
//  CLCollectionTableViewCell.h
//  FOMOPay
//
//  Created by clkj on 2019/8/15.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLCollectionTableViewCell : UITableViewCell
- (void)awakeFromNib1;  //cell样式1
- (void)awakeFromNib2; // cell样式2
- (void)awakeFromNib3;// cell样式3
- (void)CellStyle:(NSInteger)Type;
@end

NS_ASSUME_NONNULL_END
