//
//  CLCollectionAlter.h
//  FOMOPay
//
//  Created by clkj on 2019/9/11.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKBaseModel.h"
#import "xModel.h"

//typedef enum :NSUInteger{
//    CLCollectionAlter_textFiled,
//    CLCollectionAlter_button,
//    CLCollectionAlter_other,
//}CLCollectionAlterType;

//typedef void(^CLCollectionAlterBlock)(NSIndexPath *mIndexPath,NSString *mText);
//typedef void(^CLCollectionAlterButtonBlock)(NSIndexPath *mIndexPath);  //block 第一步

//typedef void(^CLCollectionAlterrefreshBlock)(WKResipientInfoObj *mItem,NSIndexPath *mIndexPath);  //block 第一步
typedef void(^TextCellBlock)(NSIndexPath *mIndexPath,FormObj *mItem);

typedef void(^ButtonCellBlock)(NSIndexPath *mIndexPath,FormObj *mItem);

typedef void(^CellBlock)(NSIndexPath *mIndexPath,NSInteger i);
@interface CLCollectionAlterView : UITableViewCell


@property (assign,nonatomic) NSInteger i;


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

@property (copy, nonatomic) TextCellBlock mResultBlock;

@property (copy, nonatomic) ButtonCellBlock mBackBlcok;

@property (copy, nonatomic) CellBlock mLineBlock;

@property (strong, nonatomic) FormObj *mItem;

- (void)updateItemText:(FormObj *)mItem;
- (void)updateItemButton:(FormObj *)mItem;


@end


