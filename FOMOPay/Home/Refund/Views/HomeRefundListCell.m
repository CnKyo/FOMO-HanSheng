//
//  HomeRefundListCell.m
//  FOMOPay
//
//  Created by mac_clkj on 2019/8/24.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "HomeRefundListCell.h"
#import "HomeRefundSelectBankView.h"

@interface HomeRefundListCell()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *headerTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bankLabel;
@property (weak, nonatomic) IBOutlet UIImageView *selectImage;
@property (weak, nonatomic) IBOutlet UITextField *cityTxtField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *numberTextField;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property (nonatomic, strong) HomeRefundSelectBankView *bankView;

@property (nonatomic, copy) NSString *tempName;
@property (nonatomic, copy) NSString *tempNumber;

@end

@implementation HomeRefundListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _nextButton.layer.cornerRadius = 5.0;
    _nextButton.enabled = NO;

    _cityTxtField.delegate = self;
    _nameTextField.delegate = self;
    _numberTextField.delegate = self;

    [_cityTxtField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_nameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_numberTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    _selectImage.image = [UIImage yh_imageNamed:@"pdf_collection_select"];
}

- (void)textFieldDidChange:(UITextField *)textField{
    
    if (textField.tag == 3001) {
        
        _tempName = textField.text;
        
    }else if (textField.tag == 3002){
        
        _tempNumber = textField.text;
    }
    
    if (_bankLabel.text.length > 0 && _tempName.length > 0 && _tempNumber.length > 0) {
        
        _nextButton.enabled = YES;
        _nextButton.backgroundColor = kLoginTitleColor;
        
    }else{
        
        _nextButton.enabled = NO;
        _nextButton.backgroundColor = kCommonColor(140, 144, 145, 1);
    }
    
    if (_HomeRefundListCellBlock) {
        
        _HomeRefundListCellBlock(textField.text,textField.tag);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)updateTitle:(NSString *)title{
    
    NSString *string = [NSString stringWithFormat:@"请提供%@银行资料",title];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:string];
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:kCommonColor(213, 0, 55, 1) range:NSMakeRange(3, title.length)];
    _headerTitleLabel.attributedText = AttributedStr;
}

- (IBAction)selectBankButtonClicked:(UIButton *)sender {
    
    __weak __typeof(self)weakSelf = self;
    
    CGRect mFrame = [UIApplication sharedApplication].keyWindow.bounds;
    NSArray *array = @[@"DBS Bank Ltd",@"POSB国家储蓄银行",@"UOB大华银行",@"OCBC华侨银行",];
    _bankView = [HomeRefundSelectBankView shareView];
    _bankView.frame = mFrame;
    _bankView.titleLabel.text = @"银行";
    [_bankView updataSource:array];
    _bankView.HomeRefundSelectBankViewBlock = ^(NSString *string, NSInteger tag) {
        
        [weakSelf.bankView removeFromSuperview];
        weakSelf.bankView = nil;
        
        if (tag == 1001) {
            
            weakSelf.bankLabel.text = string;
            weakSelf.bankLabel.textColor = [UIColor blackColor];
            
            if (weakSelf.HomeRefundListCellBlock) {
                
                weakSelf.HomeRefundListCellBlock(string,3003);
            }
        }
    };
    
    [[UIApplication sharedApplication].keyWindow addSubview:_bankView];
}

- (IBAction)nextButtonClicked:(UIButton *)sender {
    
    if (_HomeRefundListCellButtonBlock) {
        
        _HomeRefundListCellButtonBlock();
    }
}

@end
