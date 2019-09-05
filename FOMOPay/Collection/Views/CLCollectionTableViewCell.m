//
//  CLCollectionTableViewCell.m
//  FOMOPay
//
//  Created by clkj on 2019/8/15.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLCollectionTableViewCell.h"

@implementation CLCollectionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-  (void)CellStyle:(NSInteger)Type{
    if (Type == 2) {
        [self awakeFromNib1]; 
    }
}
- (IBAction)mDelAction:(UIButton *)sender {
    if (self.mDeleteBlock) {
        self.mDeleteBlock(self.mInd);
    }
}

- (void)awakeFromNib1{
    [super awakeFromNib];
    //    self.layer.borderWidth=1;
    self.layer.cornerRadius=10;
    self.layer.masksToBounds= YES;
    self.layer.shadowColor = [[UIColor grayColor]CGColor];
    self.layer.shadowOffset = CGSizeMake(0, 1);
    self.layer.shadowOpacity = 0.1;
    self.clipsToBounds = false ;
    self.CLCollectionLeftImage.layer.cornerRadius = 20;
    self.CLCollectionDeleteIcon.image = [UIImage yh_imageNamed:@"pdf_collection_delete_icon.pdf"];
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

-(void)setMItem:(WKResipientInfoObj *)mItem{
    self.mName.text = mItem.fullName;
    self.mAccountNumber.text = [NSString stringWithFormat:@"账户号码:%@",mItem.accountNumber];
    self.mBank.text = [NSString stringWithFormat:@"%@(%@)",mItem.bankName,mItem.bankCity];
    self.CLCollectionLeftImage.image = [UIImage yh_imageNamed:[CLTool GetCountryLogo:mItem.currencyCode]];
}

@end
