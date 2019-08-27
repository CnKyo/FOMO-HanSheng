//
//  MeModel.h
//  FOMOPay
//
//  Created by clkj on 2019/8/27.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MeModel : NSObject
@property (strong,nonatomic)NSString *Title;
@property (assign,nonatomic)BOOL selected;
@property (assign,nonatomic)NSInteger number;
@end

NS_ASSUME_NONNULL_END
