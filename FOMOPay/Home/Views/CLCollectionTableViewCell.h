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
@property (weak, nonatomic) IBOutlet UIImageView *CLCollectionDeleteIcon;
@property (weak, nonatomic) IBOutlet UIButton *CLCollectionDelete;
@property (weak, nonatomic) IBOutlet UIImageView *CLCollectionLeftImage;
@property (weak, nonatomic) IBOutlet UILabel *mName;
@property (weak, nonatomic) IBOutlet UILabel *mAccountNumber;
@property (weak, nonatomic) IBOutlet UILabel *mBank;
- (void)awakeFromNib1;  //cell样式1
- (void)awakeFromNib2; // cell样式2
- (void)awakeFromNib3;// cell样式3
- (void)CellStyle:(NSInteger)Type;
@end

NS_ASSUME_NONNULL_END
