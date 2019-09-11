//
//  CLMeLanguage.h
//  FOMOPay
//
//  Created by Lever on 2019/8/17.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKBaseModel.h"


typedef enum : NSUInteger {
    CLMeLanguageType_textFiled,
    CLMeLanguageType_button,
    CLMeLanguageType_other,
} CLMeLanguageType;

typedef void(^CLMeLanguageBlock)(NSIndexPath *mIndexPath,NSString *mText);
typedef void(^CLCollectionBlock)(NSIndexPath *mIndexPath);  //block 第一步
@interface CLMeLanguage : UITableViewCell

@property (copy,nonatomic) CLMeLanguageBlock mBlock;
@property (copy,nonatomic) CLCollectionBlock mDataBlock; //block第二步
@property (strong,nonatomic) UILabel *mLb;

@property (weak, nonatomic) IBOutlet UILabel *mMeLanguageLeftLabel;

@property (weak, nonatomic) IBOutlet UIView *mRightView;

@property (strong,nonatomic) NSIndexPath *mIndexPath;



- (void)updateView:(CLMeLanguageType)type and:(WKAddAccInfoObj *)EnterString;

@end


