//
//  WKTopWindow.h
//  WKWindowManagerFramework
//
//  Created by apple on 2019/7/10.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKTopWindow : NSObject

+ (void)initWithWindowLevel:(UIWindowLevel)windowLevel;

+ (void)showWithViewController:(UIViewController *)viewController;

+ (void)dismiss;

@end

NS_ASSUME_NONNULL_END
