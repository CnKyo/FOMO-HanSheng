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


@property (nonatomic,strong) CLCollectionAddSelect *mSelectView;
@property (nonatomic,strong) HomeRefundSelectBankView *purposeView;

@property (nonatomic,strong) NSArray * modelArray;
//

@end

@implementation CLCollectionAlterView

- (void)awakeFromNib {
    [super awakeFromNib];
//    self.mTextF = [UITextField new];
    
    self.mButtonImg.image = [UIImage yh_imageNamed:@"pdf_collection_select.pdf"];
    [self.mText setValue:ssRGBHex(0xcccccc) forKeyPath:@"_placeholderLabel.textColor"];
    [self.mText setValue:[UIFont fontWithName:@"PingFangSC-Regular" size:14] forKeyPath:@"_placeholderLabel.font"];

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(_mIndexPath.row  == 0){
        self.mLineView.backgroundColor = ssRGBHex(0x005CB6);
    }

    return YES;
}


-(void)textFieldDidEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
    self.mLineView.backgroundColor =ssRGBHex(0xe6e6e6); // 编辑完成改变下划线的颜色
    self.mItem.mContent = textField.text;
    if(textField.text.length<=0 &&(self.mIndexPath.row == 5 || self.mIndexPath.row== 7 )){
        self.mItem.needRefresh = YES;
        self.mLineView.backgroundColor = [UIColor redColor];
    }else{
        self.mItem.needRefresh = NO;
    }
    if(self.mResultBlock){
        self.mResultBlock(self.mIndexPath, self.mItem);
    }

    
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
//    if (self.mAlterBlock) {
//        self.mAlterBlock(self.mIndexPath,textField.text);
//    }
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
    if(_mIndexPath.row == 5 || _mIndexPath.row==7){
        return [self validateNumber:string];
    }
    
    
    return YES;
}



-(void)OpenSelect:(id)sender{
//    if(self.mDataBlock){
//        
//        self.mDataBlock(self.mIndexPath);
//    }
    
}

- (IBAction)mSelectView:(UIButton *)sender {
    WS(weakSelf);
    CGRect mFrame = [UIApplication sharedApplication].keyWindow.bounds;
    self.purposeView = [HomeRefundSelectBankView shareView];
    self.purposeView.frame = mFrame;
    self.purposeView.titleLabel.text = _mItem.mTitle;
    if([_mItem.mTitle isEqualToString:@"国籍"]){
        _modelArray = @[@"中国",@"马来西亚",@"菲律宾",@"越南",@"台湾",@"泰国",@"香港",@"新加坡",@"日本"];
    }else if([_mItem.mTitle isEqualToString:@"关系"]){
        _modelArray =@[@"本人",@"亲人",@"好友",@"同事"];
    }else if([_mItem.mTitle isEqualToString:@"性别"]){
        _modelArray =@[@"男",@"女"];
    }else if([_mItem.mTitle isEqualToString:@"银行"]){
        _modelArray =@[@"DBS Bank Ltd",@"POSB国家储蓄银行",@"UOB大华银行",@"OCBC华侨银行"];
    }
//    self.purposeView.titleLabel.text = @"汇款目的";
//    NSArray *modelArray = @[@"语言",@"联系我们",@"条约条款",@"消息通知",@"登出"];
    [self.purposeView updataSource:_modelArray];
    self.purposeView.HomeRefundSelectBankViewBlock = ^(NSString *string, NSInteger tag) {
        [weakSelf.purposeView removeFromSuperview];
        weakSelf.purposeView = nil;
        if (tag == 1001) {
            weakSelf.mButtonLabel.text = string;
            weakSelf.mItem.mContent = string;
            weakSelf.mButtonLabel.textColor = ssRGBHex(0x2b2b2b);
            if(weakSelf.mBackBlcok){
                weakSelf.mBackBlcok(weakSelf.mIndexPath,weakSelf.mItem);
            }
        }
    };
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.purposeView];
    
}

- (void)updateItemText:(FormObj *)mItem{
    self.mItem = mItem;
    self.mLeftName.text = mItem.mTitle;
    self.mText.text = mItem.mContent;
    self.mText.placeholder = [NSString stringWithFormat:@"请输入%@",mItem.mTitle];
    if(mItem.tag ==4){
        self.mText.placeholder =@"请输入开户城市";
    }
}
- (void)updateItemButton:(FormObj *)mItem{
    self.mItem = mItem;
    self.mLeftName.text = mItem.mTitle;
    if(mItem.mContent ==nil){
        self.mButtonLabel.text = @"请选择";
        self.mButtonLabel.textColor = ssRGBHex(0xccccccc);
    }else{
    self.mButtonLabel.text = mItem.mContent;
    }
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            NSString *title = [NSString stringWithFormat:@"%@只能输入数字哦",self.mItem.mTitle];
            TOASTMESSAGE(title);
            break;
        }
        i++;
    }
    return res;
}
@end
