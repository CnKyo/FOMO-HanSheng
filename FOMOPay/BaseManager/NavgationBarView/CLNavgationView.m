//
//  CLNavgationView.m
//  FOMOPay
//
//  Created by apple on 2019/8/15.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLNavgationView.h"

@implementation CLNavgationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (CLNavgationView *)shareHomeNavView{
    CLNavgationView *view = [[[NSBundle mainBundle] loadNibNamed:@"CLNavgationHomeView" owner:self options:nil] objectAtIndex:0];
    view.mTitleImage.image = [UIImage yh_imageNamed:@"pdf_home_title"];
    return view;
}

+ (CLNavgationView *)shareNormalNavView{
    CLNavgationView *view = [[[NSBundle mainBundle] loadNibNamed:@"CLNavgationNormalView" owner:self options:nil] objectAtIndex:0];
    view.mLeftImg.image = [UIImage yh_imageNamed:@"pdf_nav_back"];
    return view;
}
- (IBAction)mBtnAction:(UIButton *)sender {
    if (self.mBtnBlock) {
        self.mBtnBlock(sender.tag);
    }
}
- (void)updateView:(CLNavModel *)data{
    if (data.mTitle.length>0) {
        self.mTitle.text = data.mTitle;
    }
}
@end
