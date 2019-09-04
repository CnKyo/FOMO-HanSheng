//
//  CLHistoryDetailsOfRemittancesCellTableViewCell.m
//  FOMOPay
//
//  Created by clkj on 2019/8/29.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLHistoryDetailsOfRemittancesCellTableViewCell.h"
@interface CLHistoryDetailsOfRemittancesCellTableViewCell() 

@end
@implementation CLHistoryDetailsOfRemittancesCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _BankLabel = [UILabel new];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)mTitleViewStyle:(NSInteger)Type{
    if(Type == 0){
        self.mRightData.hidden = YES;
        UIImageView *mImg = [UIImageView new];
        mImg.image = [UIImage yh_imageNamed:@"pdf_collection_select"];
        [self.contentView addSubview:mImg];
        
        
        _BankLabel.font=kCommonFont(14);
        _BankLabel.text= @"DSB bank Ltd";
        [self.contentView addSubview:_BankLabel];

        [mImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-10);
            make.centerY.equalTo(self.mLeftName);
        }];
        
        [_BankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(mImg.mas_left).mas_offset(-8);
            make.centerY.equalTo(self.mLeftName);
        }];
    }
}





@end
