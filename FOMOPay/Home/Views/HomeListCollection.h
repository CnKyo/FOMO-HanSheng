//
//  HomeListCollection.h
//  FOMOPay
//
//  Created by Lever on 2019/9/23.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "BaseViewController.h"
#import "HomeListCollectionModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^HomeListCollectionBlock)(ForCollection *mItem);
@interface HomeListCollection : BaseViewController
@property (copy,nonatomic)HomeListCollectionBlock mBlock;
//@property (nonatomic,strong)ForCollection *mItem;
@end

NS_ASSUME_NONNULL_END
