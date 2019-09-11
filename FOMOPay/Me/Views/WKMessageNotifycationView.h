//
//  WKMessageNotifycationView.h
//  FOMOPay
//
//  Created by apple on 2019/9/11.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^WKMessageNotifycationViewSwitchBlock)(BOOL On);

@interface WKMessageNotifycationView : UIView

@property (copy,nonatomic) WKMessageNotifycationViewSwitchBlock mBlock;

@property (weak, nonatomic) IBOutlet UILabel *mTitle;

@property (weak, nonatomic) IBOutlet UISwitch *mSwitch;

@property (weak, nonatomic) IBOutlet UILabel *mContent;

+ (WKMessageNotifycationView *)shareView;

@end

NS_ASSUME_NONNULL_END
