//
//  CLHiStoryTableViewCell.h
//  FOMOPay
//
//  Created by clkj on 2019/8/14.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLHiStoryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *mLImg;
@property (weak, nonatomic) IBOutlet UILabel *mName;
@property (weak, nonatomic) IBOutlet UILabel *mDate;
@property (weak, nonatomic) IBOutlet UILabel *mMoney;
@property (weak, nonatomic) IBOutlet UILabel *mStatus;
- (void)mCLHistoryHomeCellStyle:(NSInteger)Type;
@end

NS_ASSUME_NONNULL_END
