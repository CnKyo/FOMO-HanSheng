//
//  CLCollectionAddView.m
//  FOMOPay
//
//  Created by clkj on 2019/9/12.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLCollectionAddView.h"

@interface CLCollectionAddView()<UITextFieldDelegate>
@property (strong,nonatomic) UITextField *mTextF;

@property (strong,nonatomic) UIButton *mBtn;

@property (strong,nonatomic) UIImageView *mImageV;

@end


@implementation CLCollectionAddView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.mTextF = [UITextField new];
   
//    self.mBtn = [UIButton new];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//
-(void)setView:(NSIndexPath *)indexPath and:(WKAddAccInfoObj *)String{
    
    if(indexPath.row == 0){
        [self updateView:CLAddType_textFiled and:String];
    }else if(indexPath.row ==5){
         [self updateView:CLAddType_textFiled and:String];
    }
    
}


-(void)updateView:(CLAddType)type and:(WKAddAccInfoObj *)EnterString{
    for(UIView *vvv in self.mRightView.subviews){
        [vvv removeFromSuperview];
    }
    if(type == CLAddType_textFiled){
        self.mTextF.frame = self.mRightView.bounds;
        self.mTextF.textAlignment = NSTextAlignmentRight;
        self.mTextF.font = kCommonFont(14);
        self.mTextF.delegate = self;
        self.mTextF.returnKeyType = UIReturnKeyDone;
        self.mTextF.placeholder = EnterString;
        [self.mRightView addSubview:self.mTextF];
        [self.mTextF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mLeftName);
            make.right.equalTo(self.mRightView).mas_offset(-7);
            make.width.equalTo(self.mRightView.mas_width);
        }];
    
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(self.mIndexPath.row == 0){
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
@end
