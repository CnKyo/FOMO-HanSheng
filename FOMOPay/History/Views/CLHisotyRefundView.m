//
//  CLHisotyRefundView.m
//  FOMOPay
//
//  Created by clkj on 2019/9/26.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLHisotyRefundView.h"

@implementation CLHisotyRefundView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.BankLabel = [UILabel new];
     self.mImg = [UIImageView new];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)mTitleViewStyle:(NSInteger)Type{
    if(Type == 0){
        self.mRightData.hidden = YES;
//        UIImageView *mImg = [UIImageView new];
        self.mImg.image = [UIImage yh_imageNamed:@"pdf_collection_select"];
        [self.contentView addSubview:self.mImg];
        
        
        _BankLabel.font=kCommonFont(14);
        _BankLabel.text= @"DSB bank Ltd";
        [self.contentView addSubview:_BankLabel];
        
        [self.mImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-10);
            make.centerY.equalTo(self.mLeftName);
        }];
        
        [_BankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mImg.mas_left).mas_offset(-8);
            make.centerY.equalTo(self.mLeftName);
        }];
    }
}


@end
