//
//  CLHiStoryTableViewCell.m
//  FOMOPay
//
//  Created by clkj on 2019/8/14.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLHiStoryTableViewCell.h"

@implementation CLHiStoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius=10;
    self.layer.masksToBounds= YES;
    self.mName.textColor = ssRGBHex(0x2b2b2b);
    self.mDate.textColor = ssRGBHex(0x8c9091);
    self.layer.shadowColor = [[UIColor grayColor]CGColor];
    self.layer.shadowOffset = CGSizeMake(0, 1);
    self.layer.shadowOpacity = 0.4;
    self.clipsToBounds = false ;
    
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)mCLHistoryHomeCellStyle:(NSInteger)Type{
    
    if(Type == 0 ){
        self.mLImg.image = [UIImage yh_imageNamed:@"pdf_history_beingprocessed_icon.pdf"];
        self.mMoney.textColor = ssRGBHex(0xD50037);
        self.mStatus.textColor = ssRGBHex(0x8C9091);
    }else if(Type ==1){
        self.mLImg.image = [UIImage yh_imageNamed:@"pdf_history_beingprocessed_icon.pdf"];
        self.mMoney.textColor = ssRGBHex(0xD50037);
        self.mStatus.textColor = ssRGBHex(0xD50037);
    }else if(Type ==2){
        self.mLImg.image = [UIImage yh_imageNamed:@"pdf_history_cancel_icon.pdf"];
        self.mMoney.textColor = ssRGBHex(0x999999);
        self.mStatus.textColor = ssRGBHex(0x999999);
    }else{
        self.mLImg.image = [UIImage yh_imageNamed:@"pdf_history_finish_icon.pdf"];
        self.mMoney.textColor = ssRGBHex(0x2B2B2B);
        self.mStatus.textColor = ssRGBHex(0x2EB42E);
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

- (void)setMItem:(WKOrderInfo *)mItem{
//    self.mDate.text = mItem.createdAt;
    self.mDate.text = [mItem.createdAt substringToIndex:10];
    self.mName.text = mItem.recipient.fullName;
    self.mMoney.text = [NSString stringWithFormat:@"%@%@",mItem.remittable.chargable.currencyCode,mItem.remittable.chargable.amount];
    self.mStatus.text = mItem.status;
}


@end
