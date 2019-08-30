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


//+ (CLNavgationView_button *)shareDefaultNavRightButton{
//     CLNavgationView_button *view = [[[NSBundle mainBundle] loadNibNamed:@"CLNavgationViewButton" owner:self options:nil] objectAtIndex:0];
//        UIButton *btn= [UIButton new];
//        [btn setTitle:@"添加" forState:UIControlStateNormal];
//        btn.tag =1;
//        [btn setTitleColor:ssRGBHex(0x005CB6) forState:UIControlStateNormal];
//        btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:16];
//    
//        [view addSubview:btn];
//   
//    
//    
//        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(view).offset(-20);
//            make.top.equalTo(view).offset(0);
//            make.bottom.equalTo(view).offset(0);
//        }];
//
//    return view;
//   
//}
+ (CLNavgationView_button *)shareDefaultNavRightButton{
    CLNavgationView_button *view = [[[NSBundle mainBundle] loadNibNamed:@"CLNavgationViewButton" owner:self options:nil] objectAtIndex:0];
    view.mRightImg.image = [UIImage yh_imageNamed:@"pdf_history_remittanceplan.pdf"];
   

    
    return view;
}

+(CLNavgationView_button *)shareDefaultNavRightButtonOther{
     CLNavgationView_button *view = [[[NSBundle mainBundle] loadNibNamed:@"CLNavgationViewButton" owner:self options:nil] objectAtIndex:0];
    view.mRightImg.hidden = YES;
    [view.mRightBtn setTitle:@"添加" forState:UIControlStateNormal];
    view.mRightBtn.titleLabel.font = kCommonFont(16);
    view.mRightBtn.tag=100;
    return view;
}


- (IBAction)mRightBtnAction:(UIButton *)sender {
    self.mRightBtn.adjustsImageWhenHighlighted = false;
    if (self.mRightBtnBlock) {
        self.mRightBtnBlock(sender.tag);
    }
    
}

@end
