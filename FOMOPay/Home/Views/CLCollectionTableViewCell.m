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
    }else if(Type == 3){
        [self awakeFromNib2];
        
    }else{
        [self awakeFromNib3];
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
    NSLog(@"他的height为%f",frame.size.height);
    //    frame.origin.y +=50;
    //    frame.size.height -=10;
    
    [super setFrame:frame];
}
@end
