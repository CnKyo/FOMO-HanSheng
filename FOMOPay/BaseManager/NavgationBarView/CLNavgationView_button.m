//
//  CLNavgationView_button.m
//  FOMOPay
//
//  Created by clkj on 2019/8/15.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLNavgationView_button.h"

@implementation CLNavgationView_button

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


+ (CLNavgationView_button *)shareDefaultNavRightButton{
     CLNavgationView_button *view = [[[NSBundle mainBundle] loadNibNamed:@"CLNavgationViewButton" owner:self options:nil] objectAtIndex:0];
        UIButton *btn= [UIButton new];
        [btn setTitle:@"添加" forState:UIControlStateNormal];
        [btn setTitleColor:ssRGBHex(0x005CB6) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:16];
        UIView *mView = [UIView new];
        [view addSubview:btn];
    
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(mView).offset(-20);
            make.top.equalTo(mView).offset(0);
            make.bottom.equalTo(mView).offset(0);
        }];

    return nil;
   
}
-(void)mBtnAction:(UIButton *)sender{
    if(self.mBtnBlock){
        self.mBtnBlock(sender.tag);
}
}
@end
