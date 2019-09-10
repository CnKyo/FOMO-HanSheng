//
//  HomeBankTransferCell.m
//  FOMOPay
//
//  Created by mac_clkj on 2019/8/28.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "HomeBankTransferCell.h"

@interface HomeBankTransferCell()

@property (weak, nonatomic) IBOutlet UILabel *alertLabel;
//@property (weak, nonatomic) IBOutlet UILabel *secondStepLabel;
//@property (weak, nonatomic) IBOutlet UILabel *bankNameLabel;
//@property (weak, nonatomic) IBOutlet UILabel *accountNameLabel;
//@property (weak, nonatomic) IBOutlet UILabel *accountLabel;
//@property (weak, nonatomic) IBOutlet UILabel *orderLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *finishButton;

@end

@implementation HomeBankTransferCell

- (void)awakeFromNib {
    [super awakeFromNib];

    _finishButton.layer.cornerRadius = 5.0;
    
    NSString *string = @"仅接受汇款人本人账户付款";
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:string];
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:kCommonColor(213, 0, 55, 1) range:NSMakeRange(3, 7)];
    [AttributedStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, string.length)];
    _alertLabel.attributedText = AttributedStr;
    
    NSMutableAttributedString *AttributedString = [[NSMutableAttributedString alloc] initWithString:@"复制"];
    [AttributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, 2)];
    _contentLabel.attributedText = AttributedString;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)bankTransferButtonClicked:(UIButton *)sender {
    
    if (_HomeBankTransferCellBlock) {
        
        _HomeBankTransferCellBlock(sender.tag);
    }
}

@end
