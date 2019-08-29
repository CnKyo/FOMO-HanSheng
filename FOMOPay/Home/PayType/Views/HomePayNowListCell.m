//
//  HomePayNowListCell.m
//  FOMOPay
//
//  Created by mac_clkj on 2019/8/28.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "HomePayNowListCell.h"

@interface HomePayNowListCell()

@property (weak, nonatomic) IBOutlet UILabel *alertLabel;
@property (weak, nonatomic) IBOutlet UIImageView *codeImage;
@property (weak, nonatomic) IBOutlet UIImageView *downLoadImage;
@property (weak, nonatomic) IBOutlet UIButton *finishButton;

@end

@implementation HomePayNowListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _finishButton.layer.cornerRadius = 5.0;
    
    _downLoadImage.image = [UIImage yh_imageNamed:@"pdf_home_payNow_downLoad"];
    
    NSString *string = @"仅接受汇款人本人账户付款";
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:string];
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:kCommonColor(213, 0, 55, 1) range:NSMakeRange(3, 7)];
    [AttributedStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, string.length)];
    _alertLabel.attributedText = AttributedStr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)payNowButtonClicked:(UIButton *)sender {
    
    if (_HomePayNowListCellBlock) {
        
        _HomePayNowListCellBlock(sender.tag);
    }
}

@end
