//
//  WKWindowManager.h
//  RazerPay
//
//  Created by apple on 2019/6/17.
//  Copyright © 2019 王钶. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKWindowManager : NSObject

+(WKWindowManager*)sharedWindowManager;

#pragma mark - Convenience template window

/**
 Returns a template window object, ready for presentation.
 */
+ (UIWindow*)templateWindowForName:(NSString*)name;

#pragma mark - Quick dissmissal

/**
 Dismisses the keyboard.
 */
- (void)dismissKeyboard;

#pragma mark - Presented windows

/**
 Returns an array of all presented windows from the key window.
 */
-(NSArray*)presentedWindowsFromKeyWindow;
/**
 Returns an array of all presented windows from the specified window.
 */
-(NSArray*)presentedWindowsFromWindow:(UIWindow*)presentingWindow;

#pragma mark - Window presentation

/**
 Present a window from the key window. The optional completion block will be called at the end of the presentation.
 */
-(void)presentWindowFromKeyWindow:(UIWindow*)presentedWindow animated:(BOOL)animated completion:(void(^)(void))completion;
/**
 Present a window from the specified window. The optional completion block will be called at the end of the presentation.
 */
-(void)presentWindow:(UIWindow *)presentedWindow fromWindow:(UIWindow*)presentingWindow animated:(BOOL)animated completion:(void(^)(void))completion;

#pragma mark - Window dismissal

/**
 Dismisses a specified window from the key window. The optional completion block will be called at the end of the presentation.
 */
-(void)dismissWindowFromKeyWindow:(UIWindow*)presentedWindow animated:(BOOL)animated completion:(void(^)(void))completion;

/**
 Dismisses a specified window from the specified window. The optional completion block will be called at the end of the presentation.
 */
-(void)dismissWindow:(UIWindow*)presentedWindow fromWindow:(UIWindow*)presentingWindow animated:(BOOL)animated completion:(void(^)(void))completion;

#pragma mark - Top window

/**
 Returns the currently top window.
 */
-(UIWindow*)topWindow;

@end

#pragma mark - UIWindow convenience methods

@interface UIWindow (WindowPresentation)

/**
 Present a window. The optional completion block will be called at the end of the presentation.
 */
- (void)presentWindow:(UIWindow*)window animated:(BOOL)animated completion:(void(^)(void))completion;

/**
 Dismisses a window. The optional completion block will be called at the end of the presentation.
 */
- (void)dismissWindow:(UIWindow*)window animated:(BOOL)animated completion:(void(^)(void))completion;

/**
 Returns an array of all presented windows.
 */
- (NSArray*)presentedWindows;

/**
 Returns the presenting window.
 */
- (UIWindow*)presentingWindow;

@end


NS_ASSUME_NONNULL_END
