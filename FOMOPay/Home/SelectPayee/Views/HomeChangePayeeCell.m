//
//  HomeChangePayeeCell.m
//  FOMOPay
//
//  Created by mac_clkj on 2019/8/27.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "HomeChangePayeeCell.h"

@interface HomeChangePayeeCell()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cityShowImage;

@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UIImageView *sexShowImage;

@property (weak, nonatomic) IBOutlet UILabel *bankLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bankShowImage;

@property (weak, nonatomic) IBOutlet UITextField *accountTextField;

@property (weak, nonatomic) IBOutlet UITextField *numberTextField;

@property (weak, nonatomic) IBOutlet UILabel *friendLabel;
@property (weak, nonatomic) IBOutlet UIImageView *friendShowImage;

@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;

@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIButton *commitButton;

@end

@implementation HomeChangePayeeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _deleteButton.layer.borderColor = kLoginTitleColor.CGColor;
    _deleteButton.layer.borderWidth = 1.0;
    
    _cityShowImage.image = [UIImage yh_imageNamed:@"pdf_collection_select"];
    _sexShowImage.image = [UIImage yh_imageNamed:@"pdf_collection_select"];
    _bankShowImage.image = [UIImage yh_imageNamed:@"pdf_collection_select"];
    _friendShowImage.image = [UIImage yh_imageNamed:@"pdf_collection_select"];

    _accountTextField.delegate = self;
    _nameTextField.delegate = self;
    _numberTextField.delegate = self;
    _mobileTextField.delegate = self;
    
    [_accountTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_nameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_numberTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_mobileTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField.tag == 102) {
        
        return YES;
        
    }else{
        
        NSLog(@"这里返回为NO。则为禁止编辑");
        return NO;
    }
}

- (void)textFieldDidChange:(UITextField *)textField{
    
    if (textField.tag == 102) {
        
        if (_HomeChangePayeeCellText) {
            
            _HomeChangePayeeCellText(textField.text,textField.tag);
        }
    }
}

- (IBAction)changeButtonClicked:(UIButton *)sender {
 
    if (_HomeChangePayeeCellButton) {
        
        _HomeChangePayeeCellButton(sender.tag);
    }
}

@end
