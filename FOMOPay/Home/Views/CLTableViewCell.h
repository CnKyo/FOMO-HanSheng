//
//  CLTableViewCell.h
//  FOMOPay
//
//  Created by clkj on 2019/8/13.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *CLTableViewCellImage;
@property (weak, nonatomic) IBOutlet UIView *CLTableViewCellRightViewOne;
@property (weak, nonatomic) IBOutlet UIView *CLTableViewCellRightViewTwo;
@property (weak, nonatomic) IBOutlet UIButton *CLTabViewCellLeftOutButton;
- (void)awakeFromNib1;  //cell样式1
- (void)awakeFromNib2; // cell样式2
- (void)awakeFromNib3;// cell样式3
- (void)CellStyle:(NSInteger)Type;
@end

NS_ASSUME_NONNULL_END
