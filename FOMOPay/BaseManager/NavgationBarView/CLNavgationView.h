//
//  CLNavgationView.h
//  FOMOPay
//
//  Created by apple on 2019/8/15.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLNavModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^CLNavgationViewBtnBlock)(NSInteger tag);

@interface CLNavgationView : UIView

@property (copy,nonatomic) CLNavgationViewBtnBlock mBtnBlock;

#pragma mark----****----第一种类型参数
@property (weak, nonatomic) IBOutlet UIView *mLeftView;

@property (weak, nonatomic) IBOutlet UIImageView *mTitleImage;

+ (CLNavgationView *)shareHomeNavView;

///与第二种共用一个参数
@property (weak, nonatomic) IBOutlet UIView *mrightView;
#pragma mark----****----第二种类型参数

@property (weak, nonatomic) IBOutlet UIImageView *mLeftImg;

@property (weak, nonatomic) IBOutlet UIButton *mLeftBtn;

@property (weak, nonatomic) IBOutlet UILabel *mTitle;

+ (CLNavgationView *)shareNormalNavView;

- (void)updateView:(CLNavModel *)data;

@end

NS_ASSUME_NONNULL_END
