//
//  CLMeMessageSetViewController.h
//  FOMOPay
//
//  Created by clkj on 2019/8/19.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface CLMeMessageSetViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UISwitch *MessageSwitch;
@property (nonatomic,strong) UILabel *mFootViewLable;
@end

NS_ASSUME_NONNULL_END