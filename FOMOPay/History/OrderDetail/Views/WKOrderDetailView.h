//
//  WKOrderDetailView.h
//  FOMOPay
//
//  Created by apple on 2019/9/11.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    WKOrderDetailViewBtnType_left = 0,
    WKOrderDetailViewBtnType_right = 1,
    WKOrderDetailViewBtnType_center = 2,
} WKOrderDetailViewBtnType;

typedef void(^WKOrderDetailViewBtnBlock)(WKOrderDetailViewBtnType mTag);

@interface WKOrderDetailView : UIView

@property (copy,nonatomic) WKOrderDetailViewBtnBlock mBtnBlock;

@property (weak, nonatomic) IBOutlet UILabel *mRecipientLb;

@property (weak, nonatomic) IBOutlet UILabel *mRecipient;

@property (weak, nonatomic) IBOutlet UILabel *mTransferAmountLb;

@property (weak, nonatomic) IBOutlet UILabel *mTransferAmount;

@property (weak, nonatomic) IBOutlet UILabel *mTotleAmountLb;

@property (weak, nonatomic) IBOutlet UILabel *mTotleAmount;

@property (weak, nonatomic) IBOutlet UILabel *mRemittanceProgress;

@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@property (weak, nonatomic) IBOutlet UIButton *mLeftBtn;

@property (weak, nonatomic) IBOutlet UIButton *mRightBtn;

@property (weak, nonatomic) IBOutlet UIButton *mCenterBtn;

@property (weak, nonatomic) IBOutlet UILabel *mTip;


+ (WKOrderDetailView *)shareView;

- (void)updateOrderInfo:(WKOrderInfo *)info;

@end

NS_ASSUME_NONNULL_END
