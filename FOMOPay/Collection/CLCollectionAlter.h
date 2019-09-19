//
//  CLCollectionAlter.h
//  FOMOPay
//
//  Created by clkj on 2019/8/23.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "BaseViewController.h"
#import "xModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^CLCollectionAlterBackBlock)(BOOL success);
@interface CLCollectionAlter : BaseViewController
@property (nonatomic,strong)WKResipientInfoObj *mData;
@property (nonatomic,copy) CLCollectionAlterBackBlock mBackBlock;////////
@property (nonatomic,strong)xModel *mModel;



@end



NS_ASSUME_NONNULL_END
