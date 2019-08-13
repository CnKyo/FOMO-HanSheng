//
//  CLMainTabBarControllerConfig.m
//  FOMOPay
//
//  Created by Lever on 2019/8/13.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLMainTabBarControllerConfig.h"
@implementation CLMainTabBarControllerConfig




-(CYLTabBarController *)mainTabBarContoller{
    if(_mainTabBarContoller == nil){
        CLHomeViewController *mNavHome = [CLHomeViewController new];
        UIViewController *mNavHomeController = [[UINavigationController alloc]initWithRootViewController:mNavHome];
       
        CLHistoryViewController *mNavHistory = [CLHistoryViewController new];
        UIViewController *mNavHistoryController = [[UINavigationController alloc]initWithRootViewController:mNavHistory];
       
        CLCollectionViewController *mNavCollection = [CLCollectionViewController new];
        UIViewController *mNavCollectionController = [[UINavigationController alloc]initWithRootViewController:mNavCollection];
       
        CLMeViewController *mNavMe = [CLMeViewController new];
        UIViewController *mNavMeController = [[UINavigationController alloc]initWithRootViewController:mNavMe];
        
        _mainTabBarItemAttributes = [self mainTabBarItemAttributes];
       
        _viewControlles = @[mNavHome,mNavHistory,mNavCollection,mNavMe];
       
        CYLTabBarController *tabBarController = [CYLTabBarController new];
       
        tabBarController.tabBarItemsAttributes = _mainTabBarItemAttributes;
        
        tabBarController.viewControllers = _viewControlles;
        
        tabBarController = tabBarController;
        
        //参考来自https://blog.csdn.net/man_liang/article/details/56671353
        
    }
    return _mainTabBarContoller;
}





@end
