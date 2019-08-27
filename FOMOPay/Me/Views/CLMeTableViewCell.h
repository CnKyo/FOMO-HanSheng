//
//  CLMeTableViewCell.h
//  FOMOPay
//
//  Created by clkj on 2019/8/16.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLMeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *mMeLeftImage;
@property (weak, nonatomic) IBOutlet UILabel *mMeLeftLable;

@property (weak, nonatomic) IBOutlet UILabel *mMeLanguage;


@end

NS_ASSUME_NONNULL_END
