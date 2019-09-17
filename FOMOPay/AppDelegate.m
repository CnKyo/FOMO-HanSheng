//
//  AppDelegate.m
//  FOMOPay
//
//  Created by apple on 2019/8/12.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "AppDelegate.h"

#import "CommonGuideViewController.h"
#import "LogInViewController.h"
#import "WKLoginManager.h"

#import <Firebase/Firebase.h>

@interface AppDelegate ()<FIRMessagingDelegate>

@property (nonatomic, assign) BOOL isLoadGuide;
@property (nonatomic, assign) BOOL isLogIn;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [LocalizationManager initUserLanguage];
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    _isLoadGuide = [[NSUserDefaults standardUserDefaults] objectForKey:kLoadGuideKey];

    if (!_isLoadGuide) {
        
        UINavigationController *mNavHomeController = [[UINavigationController alloc] initWithRootViewController:[CommonGuideViewController new]];
        self.window.rootViewController = mNavHomeController;
        
    }else{
        
//        _isLogIn = [[NSUserDefaults standardUserDefaults] objectForKey:kLogInKey];
        
        if ([WKAccountManager shareInstance].loginStatus == WKLoginStatus_loginSuccess) {
            CLMainTabBarControllerConfig *tabbarConfig = [CLMainTabBarControllerConfig new];
            [self.window setRootViewController:tabbarConfig.tabBarController];
        }else{
            UINavigationController *mNavHomeController = [[UINavigationController alloc] initWithRootViewController:[LogInViewController new]];
            self.window.rootViewController = mNavHomeController;
        }
    }
    [self registerFireBaase:application];
    return YES;
}
- (void)registerFireBaase:(UIApplication *)application
{
    [FIRApp configure];
    [FIRMessaging messaging].delegate = self;
    [FIRMessaging messaging].autoInitEnabled = YES;

    [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    [[UNUserNotificationCenter currentNotificationCenter] setDelegate:self];
    if ([UNUserNotificationCenter class] != nil) {
        // iOS 10 or later
        // For iOS 10 display notification (sent via APNS)
        UNAuthorizationOptions authOptions = UNAuthorizationOptionAlert |
        UNAuthorizationOptionSound | UNAuthorizationOptionBadge;
        [[UNUserNotificationCenter currentNotificationCenter]
         requestAuthorizationWithOptions:authOptions
         completionHandler:^(BOOL granted, NSError * _Nullable error) {
             ///如需调试通知的接收,点击方法,可将下面这段代码放出来进行调试(要求:通知已经注册成功)
             if (granted) {
                 //                 [self registerCategory];
                 //                 [self scheduleNotification:@"call" andInterval:3];
                 //                 [self scheduleNotification:@"clear" andInterval:5];
             }
         }];
        
    } else {
        // iOS 10 notifications aren't available; fall back to iOS 8-9 notifications.
        UIUserNotificationType allNotificationTypes =
        (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings =
        [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tokenRefreshNotification:)name:kFIRInstanceIDTokenRefreshNotification object:nil];
    [application registerForRemoteNotifications];

}
- (void)tokenRefreshNotification:(NSNotification *)notification {
    
    //    NSString *refreshedToken = [[FIRInstanceID instanceID] token];
    //    NSLog(@"tokenRefreshNotification InstanceID token: %@", refreshedToken);
    [self connectToFcm];
    
}
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings

{
    
    [application registerForRemoteNotifications];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self addFireBase];
    });
    
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken

{
    [FIRMessaging messaging].APNSToken = deviceToken;
    [self addFireBase];
    
    NSString *Token = [NSString stringWithFormat:@"%@", deviceToken];
    Token = [Token stringByReplacingOccurrencesOfString:@" " withString:@""];
    Token = [Token stringByReplacingOccurrencesOfString:@"<" withString:@""];
    Token = [Token stringByReplacingOccurrencesOfString:@">" withString:@""];
    DebugLog(@"%@", [NSString stringWithFormat:@"DeviceToken: %@", Token]);
    
    NSString *topic = [NSString stringWithFormat:@"user_%@",[WKAccountManager shareInstance].idNumber];
    [[FIRMessaging messaging] subscribeToTopic:topic];

    [[FIRInstanceID instanceID] instanceIDWithHandler:^(FIRInstanceIDResult * _Nullable result, NSError * _Nullable error) {
        DebugLog(@"result : %@",result);
    }];
    
    
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    
    NSLog(@"%@", userInfo);
}
#pragma mark----****----这下面几个方法收到远程推送通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    completionHandler(UIBackgroundFetchResultNewData);
}
#pragma mark----****----这下面几个方法收到远程推送通知(手机在前台运行中)
#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    NSDictionary *userInfo = notification.request.content.userInfo;
    
    completionHandler(UNNotificationPresentationOptionAlert);
}
#pragma mark----****----这下面几个方法收到远程推送通知(程序在运行中)
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler{
    NSDictionary *userInfo = response.notification.request.content.userInfo;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

    });
    
    completionHandler();
}
#endif
- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {

    return false;
    
}
#pragma mark----****----得到firebase token
- (void)messaging:(FIRMessaging *)messaging didReceiveRegistrationToken:(NSString *)fcmToken {
    
    DebugLog(@"FCM registration token: %@", fcmToken);
    NSDictionary *dataDict = [NSDictionary dictionaryWithObject:fcmToken forKey:@"token"];
    [[NSNotificationCenter defaultCenter] postNotificationName:
     @"FCMToken" object:nil userInfo:dataDict];
    
    NSString *topic = [NSString stringWithFormat:@"user_%@",[WKAccountManager shareInstance].idNumber];
    [[FIRMessaging messaging] subscribeToTopic:topic];

    if (![[WKAccountManager shareInstance].mPushToken isEqualToString:fcmToken]) {

        [[WKAccountManager shareInstance] WKResetPushToken:fcmToken];
        NSMutableDictionary *mPara = [NSMutableDictionary new];
        [mPara setObject:[WKAccountManager shareInstance].mPushToken forKey:@"token"];
        [mPara setObject:@"firebase" forKey:@"platform"];

        [WKNetWorkManager WKSetPushToken:mPara block:^(id result, BOOL success) {
            if (success) {
                
            }else{
                DebugLog(@"error : %@", result);
            }
        }];
        
    }else{
        [[WKAccountManager shareInstance] WKResetPushToken:fcmToken];

        NSMutableDictionary *mPara = [NSMutableDictionary new];
        [mPara setObject:[WKAccountManager shareInstance].mPushToken forKey:@"token"];
        [mPara setObject:@"firebase" forKey:@"platform"];

        [WKNetWorkManager WKSetPushToken:mPara block:^(id result, BOOL success) {
            if (success) {
                
            }else{
                DebugLog(@"error : %@", result);
            }
        }];
    }
    
}

- (void)messaging:(FIRMessaging *)messaging didReceiveMessage:(FIRMessagingRemoteMessage *)remoteMessage {
    DebugLog(@"Received data message: %@", remoteMessage.appData);
}
- (void)connectToFcm {
    
    if (  [[FIRMessaging messaging] shouldEstablishDirectChannel]) {
        [self addFireBase];
    }else{
    }
    
}
- (void)addFireBase
{
    if ([WKAccountManager shareInstance].loginStatus == WKLoginStatus_loginSuccess && [FIRMessaging messaging].APNSToken) {
        NSString *topic = [NSString stringWithFormat:@"user_%@",[WKAccountManager shareInstance].idNumber];
        [[FIRMessaging messaging] subscribeToTopic:topic];
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

//- (void)checkLoginStatus{
//    if ([WKAccountManager shareInstance].loginStatus != WKLoginStatus_loginSuccess) {
//       
//          }else{
//        [[WKLoginManager shareInstance] presentLoginViewController:^{
//                //  [[WKTabbarManager shareInstance] showHomePage];
//     }];
//    
//    }
//}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self connectToFcm];

}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
