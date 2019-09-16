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


@interface CLCollectionAlterView : UITableViewCell

@property (copy,nonatomic) CLCollectionAlterBlock mAlterBlock;
@property (copy,nonatomic) CLCollectionAlterButtonBlock mDataBlock;
@property (weak, nonatomic) IBOutlet UILabel *mLeftName;
@property (weak, nonatomic) IBOutlet UIView *mRightView;
@property (strong,nonatomic) UITextField *mTextF;
@property (strong,nonatomic) UILabel *mLb;
@property (strong,nonatomic) NSIndexPath *mIndexPath;
@property (weak, nonatomic) IBOutlet UIView *mLineView;

//@property (nonatomic,strong)WKResipientInfoObj *mItem;
-(void)updateView:(CLCollectionAlterType)type and:(WKResipientInfoObj *)EnterString;

@end


