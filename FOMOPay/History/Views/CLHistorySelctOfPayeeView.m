//
//  CLHistorySelctOfPayeeView.m
//  FOMOPay
//
//  Created by clkj on 2019/9/3.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLHistorySelctOfPayeeView.h"

@implementation CLHistorySelctOfPayeeView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
   

    // Configure the view for the selected state
}

-(void)mCellStyle:(NSInteger)Type{
    if(Type ==0){
        self.layer.borderWidth = 1;
        self.layer.borderColor =(ssRGBHex(0x2EB42E).CGColor);
        self.layer.cornerRadius = 8;
        self.layer.masksToBounds = YES;
        self.mSelectImg.hidden = NO;
        self.mSelectImg.image = [UIImage yh_imageNamed:@"pdf_home_selectPayee_icon.pdf"];
        self.mLogoImg.layer.cornerRadius = 20;

        
    }else if(Type == 1){
        self.layer.borderWidth = 1;
        self.layer.borderColor =(ssRGBHex(0xffffff).CGColor);
        self.layer.cornerRadius= 8;
        self.layer.masksToBounds = YES;
        self.mSelectImg.hidden = YES;
        self.mLogoImg.layer.cornerRadius = 20;
        
    }
}


- (void)setFrame:(CGRect)frame{
    static CGFloat margin= 10;
    frame.origin.x = margin;
    frame.size.width -= 2* frame.origin.x;
    frame.origin.y +=margin;
    frame.size.height -= margin;
    
    //    frame.origin.y +=50;
    //    frame.size.height -=10;
    
    [super setFrame:frame];
}
@end
