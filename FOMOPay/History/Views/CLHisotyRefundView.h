//
//  CLHisotyRefundView.h
//  FOMOPay
//
//  Created by clkj on 2019/9/26.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLHisotyRefundView : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mLeftName;
@property (weak, nonatomic) IBOutlet UILabel *mRightData;
@property (nonatomic,strong)UILabel *BankLabel;
@property (nonatomic,strong)UIImageView *mImg;
-(void)mTitleViewStyle:(NSInteger)Typel;
@end

NS_ASSUME_NONNULL_END
