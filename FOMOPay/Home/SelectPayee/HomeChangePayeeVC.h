//
//  HomeChangePayeeVC.h
//  FOMOPay
//
//  Created by mac_clkj on 2019/8/27.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

/**
 返回的回调方法

 @param mItem 当前的对象
 @param backCount 返回几级视图
 */
typedef void(^HomeChangePayeeVCBackBlock)(WKResipientInfoObj *mItem,NSInteger backCount);

@interface HomeChangePayeeVC : BaseViewController
@property (strong,nonatomic) WKResipientInfoObj *mItem;

@property (copy,nonatomic) HomeChangePayeeVCBackBlock mBackBlock;

@end

NS_ASSUME_NONNULL_END
