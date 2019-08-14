//
//  CLTableViewCell.m
//  FOMOPay
//
//  Created by clkj on 2019/8/13.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLTableViewCell.h"

@implementation CLTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
}
-  (void)CellStyle:(NSInteger)Type{
    if (Type == 2) {
        [self awakeFromNib1];
    }else if(Type == 3){
        [self awakeFromNib2];

    }else{
        [self awakeFromNib3];
    }
}
- (void)awakeFromNib1{
   
    self.CLTableViewCellImage.image = [UIImage yh_imageNamed:@"pdf_home_transfer_2.pdf"];
    self.CLTableViewCellImage.layer.cornerRadius = 20;
    self.CLTableViewCellImage.layer.masksToBounds = YES;
    // Initialization code
    self.CLTableViewCellRightViewOne.backgroundColor = ssRGBHex(0xD7EAFF);
    self.CLTableViewCellRightViewTwo.layer.borderWidth = 2;
    self.CLTableViewCellRightViewTwo.layer.borderColor = ssRGBHex(0x005CB6).CGColor;
    [self.CLTabViewCellLeftOutButton setBackgroundImage:[UIImage yh_imageNamed:@"pdf_home_cell_out.pdf"] forState:UIControlStateNormal];
   
    
}


- (void)awakeFromNib2{
    
    self.CLTableViewCellImage.image = [UIImage yh_imageNamed:@"pdf_home_transfer_1.pdf"];
    self.CLTableViewCellImage.layer.cornerRadius = 20;
    self.CLTableViewCellImage.layer.masksToBounds = YES;
    // Initialization code
    self.CLTableViewCellRightViewOne.backgroundColor = ssRGBHex(0xFFE8ED);
    self.CLTableViewCellRightViewTwo.layer.borderWidth = 2;
    self.CLTableViewCellRightViewTwo.layer.borderColor = ssRGBHex(0xD50037).CGColor;
    [self.CLTabViewCellLeftOutButton setBackgroundImage:[UIImage yh_imageNamed:@"pdf_home_cell_out.pdf"] forState:UIControlStateNormal];
}

- (void)awakeFromNib3{
    self.CLTableViewCellImage.image = [UIImage yh_imageNamed:@"pdf_home_transfer_2.pdf"];
    self.CLTableViewCellImage.layer.cornerRadius = 20;
    self.CLTableViewCellImage.layer.masksToBounds = YES;
    // Initialization code
    self.CLTableViewCellRightViewOne.backgroundColor = ssRGBHex(0xEBEBEB);
    self.CLTableViewCellRightViewTwo.layer.borderWidth = 2;
    self.CLTableViewCellRightViewTwo.layer.borderColor = ssRGBHex(0x7F7F7F).CGColor;
    [self.CLTabViewCellLeftOutButton setBackgroundImage:[UIImage yh_imageNamed:@""] forState:UIControlStateNormal];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
