//
//  WKMessageNotifycationView.m
//  FOMOPay
//
//  Created by apple on 2019/9/11.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "WKMessageNotifycationView.h"

@implementation WKMessageNotifycationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (WKMessageNotifycationView *)shareView{
    WKMessageNotifycationView *view = [[[NSBundle mainBundle] loadNibNamed:@"WKMessageNotifycationView" owner:self options:nil] objectAtIndex:0];
    return view;
}

- (IBAction)mSwitchAction:(UISwitch *)sender {
  
    if (sender.on) {
        if (self.mBlock) {
            self.mBlock(YES);
        }
        self.mContent.text = @"消息通知已打开，您将可以更快了解您的汇款状态。";
    }else{
        if (self.mBlock) {
            self.mBlock(NO);
        }
        self.mContent.text = @"消息通知已关闭，打开汇款实时通知，可以更快了解您\n的汇款状态。";
    }
}


@end
