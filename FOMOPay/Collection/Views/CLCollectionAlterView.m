//
//  CLCollectionAlter.m
//  FOMOPay
//
//  Created by clkj on 2019/9/11.
//  Copyright © 2019 王钶. All rights reserved.
//
#import "CLCollectionAddSelect.h"
#import "CLCollectionAlterView.h"
#import "HomeRefundSelectBankView.h"
@interface CLCollectionAlterView()<UITextFieldDelegate>
//@property (strong,nonatomic) UITextField *mTextF;

@property (strong,nonatomic) UIButton *mBtn;

@property (strong,nonatomic) UIImageView *mImageV;

//@property (strong,nonatomic)   UILabel *mHint;

//@property (strong,nonatomic) UILabel *mLb;

//@property (strong,nonatomic) NSMutableArray *mData;
@property (strong,nonatomic)NSArray *mItem;

@property (nonatomic,strong) CLCollectionAddSelect *mSelectView;
@property (nonatomic,strong) HomeRefundSelectBankView *purposeView;

@property (nonatomic,strong) NSString *mModeString;

@property (nonatomic,strong) NSString *mTextName;

@end

@implementation CLCollectionAlterView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.mTextF = [UITextField new];
//    _mModeString = @"请选择";
    _mTextName=@"";
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

-(void)setMItem:(NSArray *)mItem andIndex:(NSIndexPath *)index{
    WS(weakSelf);
    CGRect mFrame = [UIApplication sharedApplication].keyWindow.bounds;
    self.mIndexPath = index;
    self.mLeftName.text = mItem[index.row];
    if([mItem[index.row] isEqualToString:@"全名"]){
        [weakSelf updateView:CLCollectionAlter_textFiled and:_mTextName];
         weakSelf.mAlterBlock = ^(NSIndexPath *mIndexPath, NSString *mText) {
            weakSelf.mTextF.text  = mText;
            weakSelf.mTextName = mText;
        };
        
    }else if([mItem[index.row] isEqualToString:@"国籍"]){
        [weakSelf updateView:CLCollectionAlter_button and:_mModeString];
        NSArray *modelArray = @[@"语言",@"联系我们",@"条约条款",@"消息通知",@"登出"];
        weakSelf.mDataBlock = ^(NSIndexPath * _Nonnull mIndexPath) {
        weakSelf.purposeView = [HomeRefundSelectBankView shareView];
        weakSelf.purposeView.frame = mFrame;
        weakSelf.purposeView.titleLabel.text = @"汇款目的";
        [weakSelf.purposeView updataSource:modelArray];
        weakSelf.purposeView.HomeRefundSelectBankViewBlock = ^(NSString *string, NSInteger tag) {
            [weakSelf.purposeView removeFromSuperview];
            weakSelf.purposeView = nil;
                
                if (tag == 1001) {
                    
                    weakSelf.mLb.text = string;
                    weakSelf.mModeString = string;
                    
                }
            };
            
            [[UIApplication sharedApplication].keyWindow addSubview:weakSelf.purposeView];
            
            
            };
        
    
        
        
//        self.mDataBlock = ^(NSIndexPath *mIndexPath) {
//            self.mSelectView = [CLCollectionAddSelect new];
//
//            self.mSelectView.modelArray = modelArray;
//            [self addSubview:self.mSelectView.view];
//            [self.mSelectView initWithModelArray:self.mItem and:index.row];
//            self.mSelectView.CLCollectionAddSelectBlock = ^(NSString * _Nonnull string, NSInteger tag) {
//
//            };
//        };
       
        
    }else if([mItem[index.row] isEqualToString:@"性别"]){
         [self updateView:CLCollectionAlter_button and:nil];
    }else if([mItem[index.row] isEqualToString:@"银行"]){
        [self updateView:CLCollectionAlter_button and:nil];
        NSArray *modelArray = @[@"语言",@"联系我们",@"条约条款",@"消息通知",@"登出"];
        self.mDataBlock = ^(NSIndexPath * _Nonnull mIndexPath) {
            self.purposeView = [HomeRefundSelectBankView shareView];
            self.purposeView.frame = mFrame;
            self.purposeView.titleLabel.text = @"汇款目的";
            [self.purposeView updataSource:modelArray];
            self.purposeView.HomeRefundSelectBankViewBlock = ^(NSString *string, NSInteger tag) {
                [self.purposeView removeFromSuperview];
                self.purposeView = nil;
                if (tag == 1001) {
                    
                    self.mLb.text = string;
                    
                }
            };
            
            [[UIApplication sharedApplication].keyWindow addSubview:self.purposeView];

        };
    }else if([mItem[index.row] isEqualToString:@"开户地址/城市"]){
         [self updateView:CLCollectionAlter_textFiled and:nil];
    }else if([mItem[index.row] isEqualToString:@"账号号码"]){
         [self updateView:CLCollectionAlter_textFiled and:nil];
        
    }else if([mItem[index.row] isEqualToString:@"关系"]){
         [self updateView:CLCollectionAlter_button and:nil];
    }else if([mItem[index.row] isEqualToString:@"联系号码"]){
         [self updateView:CLCollectionAlter_textFiled and:nil];
    }
    
}

-(void)updateView:(CLCollectionAlterType)type and:(WKAddAccInfoObj *)EnterString{
    for(UIView *vvv in self.mRightView.subviews){
        [vvv removeFromSuperview];
    }
    if(type == CLCollectionAlter_textFiled){
//        self.mTextF = [UITextField new];
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
//        self.mLb.text = @"333";
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
            make.width.offset(150);
            
        }];
    }else {
        self.mBtn.hidden =YES;
        self.mTextF.hidden = YES;
        self.mRightView.hidden = YES;
        self.mImageV.hidden  = YES;
    
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
    if (self.mAlterBlock) {
        self.mAlterBlock(self.mIndexPath,textField.text);
    }
    if(_mIndexPath.row==0){
        self.mLineView.backgroundColor =ssRGBHex(0xe6e6e6);
    }
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (self.mAlterBlock) {
        self.mAlterBlock(self.mIndexPath,textField.text);
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
