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
    _deleteButton.layer.borderWidth = 1;
    
    _commitButton.layer.cornerRadius =2;
    _deleteButton.backgroundColor = ssRGBHex(0xF6F5FA);
    _deleteButton.layer.cornerRadius =2;
    
    _cityShowImage.image = [UIImage yh_imageNamed:@"pdf_collection_select"];
    _sexShowImage.image = [UIImage yh_imageNamed:@"pdf_collection_select"];
    _bankShowImage.image = [UIImage yh_imageNamed:@"pdf_collection_select"];
    _friendShowImage.image = [UIImage yh_imageNamed:@"pdf_collection_select"];

    _accountTextField.delegate = self;
    _nameTextField.delegate = self;
    _numberTextField.delegate = self;
    _mobileTextField.delegate = self;
    _numberTextField.textColor =ssRGBHex(0x2b2b2b);
    
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if(textField.tag == 102){
        // 每间隔4个字符插入一个空格并在删除时去掉
        NSMutableString *strmText = [NSMutableString stringWithString:textField.text];
        if ([textField.text length] == range.location) {
            
            // 插入
            if ([textField.text length]%5 == 4) {
                
                [strmText appendString:@" "];
            }
            
        } else {
            
            // 删除
            if ([textField.text length] && [textField.text length]%5 == 0) {
                
                strmText = [NSMutableString stringWithString:[strmText substringToIndex:strmText.length - 1]];
            }
        }
        
        textField.text = strmText;
    }
    
    //    if(_mIndexPath.row == 7 ){
    //        if ([textField.text length] >11) {
    //            DebugLog(@"请输入正确的联系号码");
    //        }
    //    }
    return YES;
}


- (IBAction)changeButtonClicked:(UIButton *)sender {
 
    if (_HomeChangePayeeCellButton) {
        
        _HomeChangePayeeCellButton(sender.tag);
    }
}
- (void)setMItem:(WKResipientInfoObj *)mItem{
    self.nameTextField.text = mItem.fullName;
    self.cityLabel.text = mItem.nationality;
    self.sexLabel.text = mItem.gender;
    self.bankLabel.text = mItem.bankName;
    self.accountTextField.text = mItem.bankCity;
    self.friendLabel.text = mItem.relationship;
    self.mobileTextField.text = mItem.contactNumber;
    self.numberTextField.text =[self formmatterBankCardNum:mItem.accountNumber];
//    mItem.accountNumber;
    
}

#pragma mark----****----转化卡号为每4位加一个空格
-(NSString *)formmatterBankCardNum:(NSString *)string{
    NSString *tempStr = string;
    
    NSInteger size = (tempStr.length/4);
    
    NSMutableArray *tempStrArr = [[NSMutableArray alloc]init];
    
    for(int i=0;i<size;i++){
        [tempStrArr addObject:[tempStr substringWithRange:NSMakeRange(i*4, 4)]];
    }
    
    [tempStrArr addObject:[tempStr substringWithRange:NSMakeRange(size*4,(tempStr.length%4))]];
    
    tempStr = [tempStrArr componentsJoinedByString:@" "];

    return tempStr;
}
@end
