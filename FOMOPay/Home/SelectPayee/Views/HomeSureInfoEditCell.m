//
//  HomeSureInfoEditCell.m
//  FOMOPay
//
//  Created by mac_clkj on 2019/8/26.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "HomeSureInfoEditCell.h"

@implementation HomeSureInfoEditCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _iconImage.image = [UIImage yh_imageNamed:@"pdf_home_sureInfo_edit"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
