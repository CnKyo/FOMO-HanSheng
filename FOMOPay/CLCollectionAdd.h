//
//  CLCollectionAdd.h
//  FOMOPay
//
//  Created by clkj on 2019/8/19.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol CLCollectionAddDelegate <NSObject>

- (void)changeArray:(NSArray *)Array;

@end///////////
@interface CLCollectionAdd : BaseViewController
@property (nonatomic,weak)id<CLCollectionAddDelegate>delegate;////////
@end

NS_ASSUME_NONNULL_END
