//
//  WKUserDefault.h
//  CLHospitalSysTem
//
//  Created by apple on 2019/6/24.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKUserDefault : NSObject
+ (void)setObjectInUserDefaults:(id)object withKey:(NSString*)key;

+ (id)objectInUserDefaults:(NSString*)key;
@end

NS_ASSUME_NONNULL_END
