//
//  CLCollectionAlter.h
//  FOMOPay
//
//  Created by clkj on 2019/9/11.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKBaseModel.h"

typedef enum :NSUInteger{
    CLCollectionAlter_textFiled,
    CLCollectionAlter_button,
    CLCollectionAlter_other,
}CLCollectionAlterType;

typedef void(^CLCollectionAlterBlock)(NSIndexPath *mIndexPath,NSString *mText);
typedef void(^CLCollectionAlterButtonBlock)(NSIndexPath *mIndexPath);  //block 第一步

typedef void(^CLCollectionAlterrefreshBlock)(WKResipientInfoObj *mItem,NSIndexPath *mIndexPath);  //block 第一步

@interface CLCollectionAlterView : UITableViewCell

@property (copy,nonatomic) CLCollectionAlterBlock mAlterBlock;
@property (copy,nonatomic) CLCollectionAlterButtonBlock mDataBlock;


@property (strong,nonatomic) UITextField *mTextF;
@property (strong,nonatomic) UILabel *mLb;
@property (strong,nonatomic) NSIndexPath *mIndexPath;
#pragma mark----****----第一种类型参数
@property (weak, nonatomic) IBOutlet UILabel *mLeftName;
@property (weak, nonatomic) IBOutlet UIView *mRightView;
@property (weak, nonatomic) IBOutlet UITextField *mText;



#pragma mark----****----第二种类型参数
@property (weak, nonatomic) IBOutlet UIView *mLineView;
@property (weak, nonatomic) IBOutlet UILabel *mButtonLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mButtonImg;
@property (weak, nonatomic) IBOutlet UIButton *mButton;

@property (nonatomic,strong)WKResipientInfoObj *mItem;
-(void)updateView:(CLCollectionAlterType)type and:(WKResipientInfoObj *)EnterString;

- (void)setMItem:(WKResipientInfoObj *)mItem andIndex:(NSIndexPath *)index;

-(void)setString:(NSString *)mString andIndex:(NSIndexPath *)index;

@property (copy,nonatomic) CLCollectionAlterrefreshBlock mRefreshCellBlock;


@end


