//
//  CLHistoryDetailsOfRemittancesCellTableViewCell.h
//  FOMOPay
//
//  Created by clkj on 2019/8/29.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



@interface CLHistoryDetailsOfRemittancesCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mLeftName;
@property (weak, nonatomic) IBOutlet UILabel *mRightData;
@property (nonatomic,strong)UILabel *BankLabel;
- (void)mTitleViewStyle:(NSInteger)Type;
@end

NS_ASSUME_NONNULL_END
