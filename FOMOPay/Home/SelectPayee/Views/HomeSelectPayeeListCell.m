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

@end
