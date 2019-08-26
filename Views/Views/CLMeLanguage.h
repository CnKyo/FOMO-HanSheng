//
//  CLMeLanguage.h
//  FOMOPay
//
//  Created by Lever on 2019/8/17.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef enum : NSUInteger {
    CLMeLanguageType_textFiled,
    CLMeLanguageType_button,
    CLMeLanguageType_other,
} CLMeLanguageType;

typedef void(^CLMeLanguageBlock)(NSIndexPath *mIndexPath,NSString *mText);
typedef void(^CLCollectionBlock)(NSIndexPath *mIndexPath);
@interface CLMeLanguage : UITableViewCell

@property (copy,nonatomic) CLMeLanguageBlock mBlock;
@property (copy,nonatomic) CLCollectionBlock mDataBlock;

@property (weak, nonatomic) IBOutlet UILabel *mMeLanguageLeftLabel;

@property (weak, nonatomic) IBOutlet UIView *mRightView;

@property (strong,nonatomic) NSIndexPath *mIndexPath;

- (void)updateView:(CLMeLanguageType)type and:(NSString *)EnterString;
- (void)initWithModelString:(NSString *)model;
@end


