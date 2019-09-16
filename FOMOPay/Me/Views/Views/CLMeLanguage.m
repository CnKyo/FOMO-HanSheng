//
//  CLMeLanguage.m
//  FOMOPay
//
//  Created by Lever on 2019/8/17.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLMeLanguage.h"

@interface CLMeLanguage ()<UITextFieldDelegate>

@property (strong,nonatomic) UITextField *mTextF;

@property (strong,nonatomic) UIButton *mBtn;

@property (strong,nonatomic) UIImageView *mImageV;

//@property (strong,nonatomic) UILabel *mLb;

//@property (strong,nonatomic) NSMutableArray *mData;

//@property (strong,nonatomic) NSString *m;

@end

@implementation CLMeLanguage

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.mTextF = [UITextField new];
    

}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (void)updateView:(CLMeLanguageType)type and:(WKAddAccInfoObj *)EnterString{
    for (UIView *vvv in self.mRightView.subviews) {
        [vvv removeFromSuperview];
    }
  
    if (type == CLMeLanguageType_textFiled) {
        self.mImageV.hidden = YES;
        self.mTextF.frame = self.mRightView.bounds;
        self.mTextF.textAlignment = NSTextAlignmentRight;
        if (_mIndexPath.row == 0) {
            self.mTextF.placeholder = @"请输入全名";
            self.mTextF.clearButtonMode = UITextFieldViewModeAlways;
        }else if(_mIndexPath.row == 4){
            self.mTextF.placeholder = @"请输入开户城市";
            self.mTextF.clearButtonMode = UITextFieldViewModeNever;
        }else if(_mIndexPath.row == 5){
            self.mTextF.placeholder = @"请输入账号号码";
            self.mTextF.clearButtonMode = UITextFieldViewModeNever;
        }else if(_mIndexPath.row == 7){
            self.mTextF.placeholder = @"请输入联系号码";
            self.mTextF.clearButtonMode = UITextFieldViewModeNever;
        }
        self.mTextF.font = kCommonFont(14);
//        self.mTextF.clearButtonMode = UITextFieldViewModeNever;
//        UITextFieldViewModeAlways;
        self.mTextF.delegate = self;
        self.mTextF.returnKeyType = UIReturnKeyDone;
        [self.mRightView addSubview:self.mTextF];
        if(_mIndexPath.row ==0){
        [self.mTextF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mMeLanguageLeftLabel);
            make.right.equalTo(self.mRightView).offset(-7);
            make.width.equalTo(self.mRightView.mas_width);
//            make.height.offset(14);
        }];
        }else{
            [self.mTextF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.mMeLanguageLeftLabel);
                make.right.equalTo(self.mRightView).offset(-15);
                make.width.equalTo(self.mRightView.mas_width);
//                make.height.offset(14);
            }];
        }
    }else if (type == CLMeLanguageType_button){
        
        self.mBtn = [UIButton new];
        [self.mBtn addTarget:self action:@selector(OpenSelect:) forControlEvents:UIControlEventTouchUpInside];
        [self.mRightView addSubview:self.mBtn];
        self.mImageV = [UIImageView new];
        self.mImageV.image = [UIImage yh_imageNamed:@"pdf_collection_select.pdf"];
        [self.mBtn addSubview:self.mImageV];
        self.mLb = [UILabel new];
        self.mLb.font = kCommonFont(14);
        self.mLb.textColor = ssRGBHex(0xCCCCCC);
        self.mLb.text = EnterString;
//        self.mBtn.backgroundColor = [UIColor redColor];
//        self.mLb.backgroundColor  = [UIColor redColor];//
        if([self.mLb.text isEqual:@"请选择"]){
            self.mLb.textColor = ssRGBHex(0xCCCCCC);
        }else{
             self.mLb.textColor = ssRGBHex(0x2B2B2B);
        };
        self.mLb.textAlignment = NSTextAlignmentRight;
        [self.mBtn addSubview:self.mLb];
        [self.mBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mRightView).offset(-10);
            make.height.equalTo(self.mRightView);
            make.width.offset(100);
            make.top.bottom.equalTo(self.mRightView);
        }];
        [self.mImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mBtn.mas_right).offset(0);
            make.height.offset(24);
            make.width.offset(24);
            make.centerY.equalTo(self.mMeLanguageLeftLabel);
        }];
        [self.mLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mMeLanguageLeftLabel);
            make.right.equalTo(self.mImageV.mas_left).offset(-8);
//            make.width.equalTo(self.mRightView);
            make.width.offset(150);

        }];
    }else {
        self.mBtn.hidden =YES;
        self.mTextF.hidden = YES;
        self.mRightView.hidden = YES;
        self.mImageV.hidden = YES;
    }
    
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(_mIndexPath.row  == 0){
        self.mLineView.backgroundColor = ssRGBHex(0x005CB6);
    }
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
    if (self.mBlock) {
        self.mBlock(self.mIndexPath,textField.text);
    }
    if(_mIndexPath.row==0){
        self.mLineView.backgroundColor =ssRGBHex(0xe6e6e6);
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (self.mBlock) {
        self.mBlock(self.mIndexPath,textField.text);
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    if(_mIndexPath.row ==5){
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

//- (void)textFieldDidChange:(UITextField *)textField{//点击事件
//    
//    if (self.mBlock) {
//        self.mBlock(self.mIndexPath,textField.text);
//    }
//}


-(void)OpenSelect:(id)sender{
    if(self.mDataBlock){
        self.mDataBlock(self.mIndexPath);
    }
    
}



//-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//
//{
//
//    [super touchesBegan:touches withEvent:event];
//
//    [_mTextF resignFirstResponder];
//
////    self.label.text = textField.text; //do some other things.
//
//}


@end
