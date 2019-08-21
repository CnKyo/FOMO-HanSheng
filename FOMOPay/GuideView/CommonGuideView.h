//
//  CommonGuideView.h
//  workSpace
//
//  Created by mac_clkj on 2019/6/19.
//  Copyright © 2019 chenling. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommonGuideView : UIView

/**
 *  必须给引导页finishAction回调赋值
 */
@property(nonatomic, assign)SEL finishAction;
- (instancetype)initWithFrame:(CGRect)frame superVC:(BaseViewController *)superVC;

@end

NS_ASSUME_NONNULL_END
