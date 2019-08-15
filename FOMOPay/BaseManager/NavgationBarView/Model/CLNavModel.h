//
//  CLNavModel.h
//  FOMOPay
//
//  Created by apple on 2019/8/15.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLNavModel : NSObject
@property (strong,nonatomic) NSString *mTitle;

@property (strong,nonatomic) UIView *mLeftView;
@property (strong,nonatomic) UIView *mRightView;
@end

NS_ASSUME_NONNULL_END
