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
    
    self.layer.shadowColor = [[UIColor grayColor]CGColor];
    self.layer.shadowOffset = CGSizeMake(0, 1);
    self.layer.shadowOpacity = 0.1;
    self.clipsToBounds = false ;
    
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
