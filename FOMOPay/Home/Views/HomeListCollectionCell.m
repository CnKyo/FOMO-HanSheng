//
//  HomeListCollectionCell.m
//  FOMOPay
//
//  Created by mac_clkj on 2019/8/20.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "HomeListCollectionCell.h"

@implementation HomeListCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconImage.layer.borderWidth = 1;
    self.iconImage.layer.borderColor = ssRGBHex(0xE6E6E6).CGColor;
    self.iconImage.layer.cornerRadius = 20;
    self.iconImage.layer.masksToBounds= YES;
    // Initialization code
}

@end
