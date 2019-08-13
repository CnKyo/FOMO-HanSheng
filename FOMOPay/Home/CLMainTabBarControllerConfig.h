//
//  CLMainTabBarControllerConfig.h
//  FOMOPay
//
//  Created by Lever on 2019/8/13.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLMainTabBarControllerConfig : NSObject

@property (nonatomic,strong)CYLTabBarController *mainTabBarContoller;
@property (nonatomic,strong)NSArray *mainTabBarItemAttributes;
@property (nonatomic,strong)NSArray *viewControlles;


@end

NS_ASSUME_NONNULL_END
