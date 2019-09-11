//
//  CLCollectionAlter.m
//  FOMOPay
//
//  Created by clkj on 2019/9/11.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLCollectionAlterView.h"
@interface CLCollectionAlterView()<UITextFieldDelegate>
//@property (strong,nonatomic) UITextField *mTextF;

@property (strong,nonatomic) UIButton *mBtn;

@property (strong,nonatomic) UIImageView *mImageV;

//@property (strong,nonatomic) UILabel *mLb;

@property (strong,nonatomic) NSMutableArray *mData;

@end

@implementation CLCollectionAlterView

- (void)awakeFromNib {
    [super awakeFromNib];
//    self.mTextF = [UITextField new];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (NSMutableArray *)mData{
    if(!_mData){
       _mData = [NSMutableArray arrayWithObjects:@"请选择",@"请选择",@"请选择" ,@"请选择",@"请选择",@"请选择",@"请选择",@"请选择", nil];
    }
    return _mData;
}

-(void)updateView:(CLCollectionAlterType)type and:(WKAddAccInfoObj *)EnterString{
    for(UIView *vvv in self.mRightView.subviews){
        [vvv removeFromSuperview];
    }
    if(type == CLCollectionAlter_textFiled){
        self.mTextF = [UITextField new];
        self.mTextF.frame = self.mRightView.bounds;
        self.mTextF.textAlignment = NSTextAlignmentRight;
        self.mTextF.font = kCommonFont(14);
        self.mTextF.delegate = self;
        self.mTextF.returnKeyType = UIReturnKeyDone;
        [self.mRightView addSubview:self.mTextF];
        if (_mIndexPath.row == 0) {
            self.mTextF.placeholder = @"请输入全名";
            self.mTextF.clearButtonMode = UITextFieldViewModeNever;
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
        self.mTextF.text = EnterString;
      
        
        [self.mTextF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.mLeftName);
                make.right.equalTo(self.mRightView).offset(-15);
                make.width.equalTo(self.mRightView.mas_width);
                //                make.height.offset(14);
            }];
        
    }else if(type ==CLCollectionAlter_button){
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
            make.centerY.equalTo(self.mLeftName);
        }];
        [self.mLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mLeftName);
            make.right.equalTo(self.mImageV.mas_left).offset(-8);
            make.width.equalTo(self.mRightView);
            
        }];
    }else {
        self.mBtn.hidden =YES;
        self.mTextF.hidden = YES;
        
    
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
    if (self.mAlterBlock) {
        self.mAlterBlock(self.mIndexPath,textField.text);
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (self.mAlterBlock) {
        self.mAlterBlock(self.mIndexPath,textField.text);
    }
    return YES;
}
-(void)OpenSelect:(id)sender{
    if(self.mDataBlock){
        
        self.mDataBlock(self.mIndexPath);
    }
    
}



@end
