//
//  CLCollectionTableViewCell.h
//  FOMOPay
//
//  Created by clkj on 2019/8/15.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^CLCollectionTableViewCellBlock)(NSIndexPath *mIndex);
@interface CLCollectionTableViewCell : UITableViewCell
@property (copy,nonatomic)CLCollectionTableViewCellBlock mDeleteBlock;


@property (weak, nonatomic) IBOutlet UIImageView *CLCollectionDeleteIcon;
@property (weak, nonatomic) IBOutlet UIButton *CLCollectionDelete;
@property (weak, nonatomic) IBOutlet UIImageView *CLCollectionLeftImage;
@property (weak, nonatomic) IBOutlet UILabel *mName;
@property (weak, nonatomic) IBOutlet UILabel *mAccountNumber;
@property (weak, nonatomic) IBOutlet UILabel *mBank;
@property (strong,nonatomic) NSIndexPath *mInd;
- (IBAction)mDelAction:(UIButton *)sender;

- (void)awakeFromNib1;  //cell样式1

- (void)CellStyle:(NSInteger)Type;
@end

NS_ASSUME_NONNULL_END
