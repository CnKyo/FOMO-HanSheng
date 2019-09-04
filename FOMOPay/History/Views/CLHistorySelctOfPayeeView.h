//
//  CLHistorySelctOfPayeeView.h
//  FOMOPay
//
//  Created by clkj on 2019/9/3.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLHistorySelctOfPayeeView : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *mLogoImg;
@property (weak, nonatomic) IBOutlet UILabel *mName;
@property (weak, nonatomic) IBOutlet UILabel *mAccountNumber;
@property (weak, nonatomic) IBOutlet UILabel *mBank;

@property (weak, nonatomic) IBOutlet UIImageView *mSelectImg;
- (void)mCellStyle:(NSInteger)Type;


@property (strong,nonatomic) WKResipientInfoObj *mItem;
@end

NS_ASSUME_NONNULL_END
