//
//  CLCollectionAddView.h
//  FOMOPay
//
//  Created by clkj on 2019/9/12.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum: NSUInteger{
    CLAddType_textFiled,
    CLAddType_button,
    CLAddType_other,
}CLAddType;

typedef void(^CLCollectionAddViewBlock)(NSIndexPath *mIndexPath,NSString *mText);

@interface CLCollectionAddView : UITableViewCell

@property (copy,nonatomic)CLCollectionAddViewBlock mBlock;

@property (weak, nonatomic) IBOutlet UILabel *mLeftName;
@property (weak, nonatomic) IBOutlet UIView *mRightView;
@property (weak, nonatomic) IBOutlet UIView *mLineView;

@property (strong,nonatomic) NSIndexPath *mIndexPath;
-(void)setView:(NSIndexPath *)indexPath and:(WKAddAccInfoObj *)String;
@end


