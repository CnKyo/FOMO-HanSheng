//
//  CLTitleView.m
//  FOMOPay
//
//  Created by clkj on 2019/8/12.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLTitleView.h"

@implementation CLTitleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(CLTitleView *)LoadXib{
  CLTitleView *TabBarView = [[[NSBundle mainBundle]loadNibNamed:@"CLTitleView" owner:self options:nil]firstObject];
//
        CGRect screen = [[UIScreen mainScreen]bounds];
        TabBarView.backgroundColor = [UIColor whiteColor];
        TabBarView.frame = CGRectMake(0, 0,screen.size.width, 44+ kAppStatusBarHeight);
        return  TabBarView;
    
}
- (void)awakeFromNib{
    [super awakeFromNib];
  }

- (void)mTitleViewStyle:(NSInteger)Type{
    if (Type == 0) {
        self.CLTitleImage.image = [UIImage yh_imageNamed:@"pdf_home_title.pdf"];
       
        
        [_CLTitleImage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.offset(35);
        }];
    }
}




@end
