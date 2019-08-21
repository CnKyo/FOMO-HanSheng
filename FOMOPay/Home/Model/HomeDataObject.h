//
//  HomeDataObject.h
//  FOMOPay
//
//  Created by mac_clkj on 2019/8/20.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeDataObject : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *logoImage;
@property (nonatomic, copy) NSString *unitString;
@property (nonatomic, copy) NSString *contentName;
@property (nonatomic, copy) NSString *placholder;
@property (nonatomic, copy) NSString *exchangeRate; //汇率
@property (nonatomic, strong) UIColor *rightColor;

@end

NS_ASSUME_NONNULL_END
