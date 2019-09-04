//
//  HomeSelectPayeeListCell.m
//  FOMOPay
//
//  Created by mac_clkj on 2019/8/26.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "HomeSelectPayeeListCell.h"

@implementation HomeSelectPayeeListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _bgImageView.image = [UIImage yh_imageNamed:@"pdf_home_selectPayee_bg_gray"];
    _selectImage.image = [UIImage yh_imageNamed:@"pdf_home_selectPayee_icon"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

//- (void)setMItem:(WKResipientInfoObj *)mItem{
//    self.nameLabel.text = mItem.fullName;
//    self.accountLabel.text = [NSString stringWithFormat:@"账户号码:%@",mItem.accountNumber];
//    self.cityLabel.text = [NSString stringWithFormat:@"%@(%@)",mItem.bankName,mItem.bankCity];
//}

@end
