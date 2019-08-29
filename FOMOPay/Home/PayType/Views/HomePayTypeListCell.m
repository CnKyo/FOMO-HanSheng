//
//  HomePayTypeListCell.m
//  FOMOPay
//
//  Created by mac_clkj on 2019/8/28.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "HomePayTypeListCell.h"

@interface HomePayTypeListCell()

@property (weak, nonatomic) IBOutlet UILabel *alertLabel;

@property (weak, nonatomic) IBOutlet UIView *payNowView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *payNowViewHeight;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *allowImage;

@property (weak, nonatomic) IBOutlet UIView *bankView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bankViewHeight;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage1;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel1;
@property (weak, nonatomic) IBOutlet UIImageView *allowImage1;

@end

@implementation HomePayTypeListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _payNowView.layer.cornerRadius = 4.0;
    _bankView.layer.cornerRadius = 4.0;
    
    _logoImage.image = [UIImage yh_imageNamed:@"pdf_home_payType_payNow"];
    _logoImage1.image = [UIImage yh_imageNamed:@"pdf_home_payType_bank"];
    _allowImage.image = [UIImage yh_imageNamed:@"pdf_home_payType_allow"];
    _allowImage1.image = [UIImage yh_imageNamed:@"pdf_home_payType_allow"];
    
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:@"请选择支付方式，仅接受汇款人本人账户付款"];
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:kCommonColor(213, 0, 55, 1) range:NSMakeRange(11, 7)];
    _alertLabel.attributedText = AttributedStr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)payTypeButtonClicked:(UIButton *)sender {
    
    if (_HomePayTypeListCellBlock) {
        
        _HomePayTypeListCellBlock(sender.tag);
    }
}

@end
