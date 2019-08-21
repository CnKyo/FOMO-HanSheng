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

@property (strong,nonatomic) UILabel *mLb;

@end

@implementation CLMeLanguage

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateView:(CLMeLanguageType)type and:(nonnull NSString *)EnterString{
    for (UIView *vvv in self.mRightView.subviews) {
        [vvv removeFromSuperview];
    }
    if (type == CLMeLanguageType_textFiled) {
        self.mTextF = [UITextField new];
        self.mTextF.frame = self.mRightView.bounds;
        self.mTextF.textAlignment = NSTextAlignmentRight;
        self.mTextF.placeholder = @"请输入内容";
        self.mTextF.font = kCommonFont(14);
        self.mTextF.clearButtonMode = UITextFieldViewModeAlways;
        self.mTextF.delegate = self;
        self.mTextF.returnKeyType = UIReturnKeyDone;
        [self.mRightView addSubview:self.mTextF];
        [self.mTextF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mMeLanguageLeftLabel);
            make.right.equalTo(self.mRightView).offset(-7);
            make.width.equalTo(self.mRightView);
            make.height.offset(14);
        }];
    }else if (type == CLMeLanguageType_button){
        self.mBtn = [UIButton new];
        [self.mBtn addTarget:self action:@selector(OpenSelect:) forControlEvents:UIControlEventTouchUpInside];
        self.mBtn.backgroundColor = [UIColor yellowColor];
//        self.mBtn.titleLabel.font = kCommonFont(14);
        [self.mRightView addSubview:self.mBtn];
        self.mImageV = [UIImageView new];
        self.mImageV.image = [UIImage yh_imageNamed:@"pdf_collection_select.pdf"];
        [self.mBtn addSubview:self.mImageV];
        self.mLb = [UILabel new];
        self.mLb.font = kCommonFont(14);
        self.mLb.textColor = ssRGBHex(0xCCCCCC);
        if(![EnterString isEqual:@"请选择"]){
        self.mLb.text = EnterString;
        self.mLb.textColor = ssRGBHex(0x2B2B2B);
        }else{
        self.mLb.text = @"请选择";
        self.mLb.textColor = ssRGBHex(0xCCCCCC);
        }
//
        self.mLb.textAlignment = NSTextAlignmentRight;
        [self.mBtn addSubview:self.mLb];
        [self.mBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mRightView).offset(-10);
            make.height.equalTo(self.mRightView);
            make.width.equalTo(self.mRightView);
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
            make.width.equalTo(self.mRightView);

        }];
    }else{
        
    }
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.mBlock) {
        self.mBlock(self.mIndexPath,textField.text);
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (self.mBlock) {
        self.mBlock(self.mIndexPath,textField.text);
    }
    return YES;
}

-(void)OpenSelect:(id)sender{
    if(_mDataBlock){
        _mDataBlock(_mIndexPath);
    }
    
}
@end
