//
//  HomeSureInfoListCell.h
//  FOMOPay
//
//  Created by mac_clkj on 2019/8/26.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeSureInfoListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *showImage;

@end

NS_ASSUME_NONNULL_END
