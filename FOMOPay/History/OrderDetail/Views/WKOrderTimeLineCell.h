//
//  WKOrderTimeLineCell.h
//  FOMOPay
//
//  Created by apple on 2019/9/11.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKOrderTimeLineCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *mDate;

@property (weak, nonatomic) IBOutlet UIView *mTopLine;

@property (weak, nonatomic) IBOutlet UIImageView *mPoint;

@property (weak, nonatomic) IBOutlet UIView *mBottomLine;

@property (weak, nonatomic) IBOutlet UILabel *mTitle;

@property (weak, nonatomic) IBOutlet WPHotspotLabel *mContent;

@property (strong, nonatomic) WKOrderOperation *mItem;

@end

NS_ASSUME_NONNULL_END
