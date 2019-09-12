//
//  DPLogInView.m
//  FOMOPay
//
//  Created by mac_clkj on 2019/8/19.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "DPLogInView.h"

@interface DPLogInView()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *languageLabel;
@property (weak, nonatomic) IBOutlet UIImageView *allowImage;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UITextField *myTextField;
@property (weak, nonatomic) IBOutlet UIView *languageView;
@property (weak, nonatomic) IBOutlet UIButton *chinaButton;
@property (weak, nonatomic) IBOutlet UIButton *englishButton;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UILabel *NameOrNumber;

@end

@implementation DPLogInView

+ (DPLogInView *)shareView{
    
    DPLogInView *view = [[[NSBundle mainBundle] loadNibNamed:@"DPLogInView" owner:self options:nil] objectAtIndex:0];
    view.nextButton.layer.cornerRadius = 4.0;
    [view.nextButton setTitle:languageStr(@"Next") forState:UIControlStateNormal];
    view.myTextField.delegate = view;
    view.myTextField.placeholder = languageStr(@"input");
    [view.myTextField addTarget:view action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    view.NameOrNumber.text = languageStr(@"NameOrNumber");
//    NSString *string = [[NSUserDefaults standardUserDefaults] objectForKey:kLanguageKey];
    view.languageLabel.text = languageStr(@"Language");
//    view.languageLabel.text = string.length > 0 ? string:@"简体中文";
    view.logoImage.image = [UIImage yh_imageNamed:@"pdf_login_icon"];
    view.allowImage.image = [UIImage yh_imageNamed:@"pdf_login_language"];
    
    view.languageView.layer.cornerRadius = 4.0;
//    view.languageView.layer.borderWidth = 0.5;
  
//    view.languageView.layer.borderColor = [UIColor blackColor].CGColor;
  
//    view.languageView.layer.cornerRadius=10;
    view.languageView.layer.masksToBounds= YES;
    view.languageView.layer.shadowColor = [[UIColor grayColor]CGColor];
    view.languageView.layer.shadowOffset = CGSizeMake(0, 1);
    view.languageView.layer.shadowOpacity = 0.5;
    view.languageView.clipsToBounds = false ;
    
    return view;
}

- (IBAction)nextButtonClicked:(UIButton *)sender {
    
    if (_LogInViewBlock) {
        
        _LogInViewBlock(_myTextField.text);
    }
}

- (IBAction)chooseLanguageButtonClicked:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    if (sender.selected == YES) {
        
        _languageView.hidden = NO;
        if ([_languageLabel.text isEqualToString:@"简体中文"]) {
            [_chinaButton setTitleColor:kLoginTitleColor forState:UIControlStateNormal];
            [_englishButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        }else{
             
            [_englishButton setTitleColor:kLoginTitleColor forState:UIControlStateNormal];
            [_chinaButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
    }else{
        
        _languageView.hidden = YES;
    }
}

- (IBAction)changeButtonClicked:(UIButton *)sender {
    
    [_chinaButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_englishButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [sender setTitleColor:kLoginTitleColor forState:UIControlStateNormal];
    
    _languageLabel.text = sender.titleLabel.text;
    if([sender.titleLabel.text isEqualToString:@"简体中文"]){
         [LocalizationManager setGuidelanguage:@"zh-Hans" andType:1];
    }else{
        [LocalizationManager setGuidelanguage:@"en" andType:1];
    }
    _languageView.hidden = YES;
    
//    [[NSUserDefaults standardUserDefaults] setObject:_languageLabel.text forKey:kLanguageKey];
//    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    if (textField.text.length > 0) {
        
        _nextButton.backgroundColor = kLoginTitleColor;
        _nextButton.enabled = YES;
        _lineView.backgroundColor = ssRGBHex(0x005CB6);

        
    }else{
        
        _nextButton.backgroundColor = [UIColor colorWithRed:140/255.0 green:144/255.0 blue:145/255.0 alpha:1];
        _nextButton.enabled = NO;
        _alertLabel.hidden = NO;
        _alertLabel.text = @"请输入正确的身份证号码/手机号码";
        _lineView.backgroundColor = ssRGBHex(0xD50037);
        
    }
    return YES;
}

- (void)textFieldDidChange:(UITextField *)textField{
    
    if (textField.text.length > 0) {
        
        _nextButton.backgroundColor = kLoginTitleColor;
        _nextButton.enabled = YES;
        _alertLabel.hidden = YES;
//         _alertLabel.text = @"请输入正确的身份证号码/手机号码";
    }else{
        
        _nextButton.backgroundColor = [UIColor colorWithRed:140/255.0 green:144/255.0 blue:145/255.0 alpha:1];
        _nextButton.enabled = NO;
//        _alertLabel.hidden = NO;
//        _alertLabel.text = @"请输入正确的身份证号码/手机号码";
    }
}

@end
