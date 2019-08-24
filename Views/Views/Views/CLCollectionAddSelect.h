//
//  CLCollectionAddSelect.h
//  FOMOPay
//
//  Created by clkj on 2019/8/20.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol CLCollectionAddSelectDelegate <NSObject>

- (void)changeValue:(NSString *)value;

@end///////////
@interface CLCollectionAddSelect : BaseViewController
@property (nonatomic,weak)id<CLCollectionAddSelectDelegate>delegate;////////


/// 初始化数据

@property(nonatomic,strong) NSArray *modelArray;
@property(nonatomic,strong) NSArray *mAddLeftDateSource;
- (void)initWithModelArray:(NSArray *)modelLeftArray  and:(NSInteger)i;
@end

NS_ASSUME_NONNULL_END
