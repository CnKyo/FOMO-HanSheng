//
//  CLTitleView.h
//  FOMOPay
//
//  Created by clkj on 2019/8/12.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLTitleView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *CLTitleImage;
+(CLTitleView *)LoadXib;
- (void)mTitleViewStyle:(NSInteger)Type;
@end
NS_ASSUME_NONNULL_END
