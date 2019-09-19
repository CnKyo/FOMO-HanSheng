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
//        self.layer.masksToBounds = YES;
        self.mSelectImg.hidden = NO;
        self.mSelectImg.image = [UIImage yh_imageNamed:@"pdf_home_selectPayee_icon.pdf"];
        self.mLogoImg.layer.cornerRadius = 20;

        
    }else if(Type == 1){
//        self.layer.borderWidth = 1;
        self.layer.borderColor =(ssRGBHex(0xffffff).CGColor);
        self.layer.cornerRadius= 8;
        self.layer.masksToBounds = YES;
        self.mSelectImg.hidden = YES;
        self.mLogoImg.layer.cornerRadius = 20;
        self.layer.shadowColor = ssRGBHex(0x000000).CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 1);
        self.layer.shadowOpacity = 0.2;
        self.clipsToBounds = false;
        
    }
}


- (void)setFrame:(CGRect)frame{
    static CGFloat margin= 10;
    frame.origin.x = margin;
    frame.size.width -= 2* frame.origin.x;
    frame.origin.y +=margin;
    frame.size.height -= margin +2;
    
    //    frame.origin.y +=50;
    //    frame.size.height -=10;
    
    [super setFrame:frame];
}


- (void)setMItem:(WKResipientInfoObj *)mItem{
    self.mName.text = mItem.fullName;
    self.mAccountNumber.text =mItem.accountNumber;
    self.mBank.text = [NSString stringWithFormat:@"%@(%@)",mItem.bankName,mItem.bankCity];
    self.mLogoImg.image = [UIImage yh_imageNamed:[CLTool GetCountryLogo:mItem.currencyCode]];
}
@end
