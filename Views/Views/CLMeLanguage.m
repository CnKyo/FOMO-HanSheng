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

@property (strong,nonatomic) NSMutableArray *mData;

@property (strong,nonatomic) NSString *m;

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

-(void)initWithModelString:(NSString *)model{
    self.m = model;
}

- (void)updateView:(CLMeLanguageType)type and:(nonnull NSString *)EnterString{
    for (UIView *vvv in self.mRightView.subviews) {
        [vvv removeFromSuperview];
    }
    if (!_mData) {
        _mData = [NSMutableArray arrayWithObjects:@"请选择",@"请选择",@"请选择" ,@"请选择",@"请选择",@"请选择",@"请选择",@"请选择", nil];
    }
    if (type == CLMeLanguageType_textFiled) {
        self.mTextF = [UITextField new];
        self.mTextF.frame = self.mRightView.bounds;
        self.mTextF.textAlignment = NSTextAlignmentRight;
        if (_mIndexPath.row == 0) {
            self.mTextF.placeholder = @"请输入全名";
        }else if(_mIndexPath.row == 4){
            self.mTextF.placeholder = @"请输入开户城市";
        }else if(_mIndexPath.row == 5){
            if (_mTextF.text.length >0) {
                _mTextF.text = self.m;
                DebugLog("我的self的m的值%@",self.m);
            }else{
                 self.mTextF.placeholder = @"请输入账号号码";
            }
           
        }else if(_mIndexPath.row == 7){
            self.mTextF.placeholder = @"请输入联系号码";
        }
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
//        self.mBtn.backgroundColor = [UIColor yellowColor];
//        self.mBtn.titleLabel.font = kCommonFont(14);
        [self.mRightView addSubview:self.mBtn];
        self.mImageV = [UIImageView new];
        self.mImageV.image = [UIImage yh_imageNamed:@"pdf_collection_select.pdf"];
        [self.mBtn addSubview:self.mImageV];
        self.mLb = [UILabel new];
        self.mLb.font = kCommonFont(14);
        self.mLb.textColor = ssRGBHex(0xCCCCCC);
        self.mLb.text = EnterString;
//      DebugLog(@"数据为%@,下标为%ld",_mData,_mIndexPath.row);
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

-(void)OpenSelect:(id)sender{
    if(self.mDataBlock){
        self.mDataBlock(self.mIndexPath);
    }
    
}
@end
