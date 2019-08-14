//
//  CLMainTabBarControllerConfig.m
//  FOMOPay
//
//  Created by Lever on 2019/8/13.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLMainTabBarControllerConfig.h"
@implementation CLMainTabBarControllerConfig




-(CYLTabBarController *)tabBarController{
    if(!_tabBarController){
        CLHomeViewController *mNavHome = [CLHomeViewController new];
        UIViewController *mNavHomeController = [[UINavigationController alloc]initWithRootViewController:mNavHome];
       
        CLHistoryViewController *mNavHistory = [CLHistoryViewController new];
        UIViewController *mNavHistoryController = [[UINavigationController alloc]initWithRootViewController:mNavHistory];
       
        CLCollectionViewController *mNavCollection = [CLCollectionViewController new];
        UIViewController *mNavCollectionController = [[UINavigationController alloc]initWithRootViewController:mNavCollection];
       
        CLMeViewController *mNavMe = [CLMeViewController new];
        UIViewController *mNavMeController = [[UINavigationController alloc]initWithRootViewController:mNavMe];
        
        NSArray *tabBarItemsAttributes = [self tabBarItemsAttributes];
        NSArray *viewControllers = @[mNavHome,mNavHistory,mNavCollection,mNavMe];
       
        CYLTabBarController *tabBarController = [CYLTabBarController new];
       
        tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
        
        tabBarController.viewControllers = viewControllers;
        
        _tabBarController = tabBarController;
        
//        [self customizeTabBarAppearance:_tabBarController];
        
        //参考来自https://blog.csdn.net/man_liang/article/details/56671353
        
    }
    
    return _tabBarController;
    
}

- (NSArray *)tabBarItemsAttributes{
    NSDictionary *tabBarItems1Attributes = @{
                                                CYLTabBarItemTitle:@"汇款",
                                                CYLTabBarItemImage : [UIImage yh_imageNamed:@"pdf_home_home_tabbar.pdf"],
                                                CYLTabBarItemSelectedImage:[UIImage yh_imageNamed:@"pdf_home_home_tabbarselected.pdf"]
    };
    
    NSDictionary *tabBarItems2Attributes = @{
                                             CYLTabBarItemTitle:@"历史",
                                             CYLTabBarItemImage: [UIImage yh_imageNamed:@"pdf_home_history_tabbar.pdf"],
                                             CYLTabBarItemSelectedImage:[UIImage yh_imageNamed:@"pdf_home_history_tabbarselected.pdf"]
                                             };
    
    NSDictionary *tabBarItems3Attributes = @{
                                             CYLTabBarItemTitle:@"收款人",
                                             CYLTabBarItemImage: [UIImage yh_imageNamed:@"pdf_home_collection_tabbar.pdf"],
                                             CYLTabBarItemSelectedImage:[UIImage yh_imageNamed:@"pdf_home_collection_tabbarselected.pdf"]
                                             };
    
    NSDictionary *tabBarItems4Attributes = @{
                                             CYLTabBarItemTitle:@"我",
                                             CYLTabBarItemImage: [UIImage yh_imageNamed:@"pdf_home_me_tabbar.pdf"],
                                             CYLTabBarItemSelectedImage:[UIImage yh_imageNamed:@"pdf_home_me_tabbarselected.pdf"]
                                             };
    
    
    
//    NSDictionary *tabBarItems2Attributes = @{
//                                             CYLTabBarItemTitle:@"汇款",
//                                             CYLTabBarItemImage: [UIImage yh_imageNamed:@"pdf_home_home_tabbarpdf"],
//                                             CYLTabBarItemSelectedImage:[UIImage yh_imageNamed:@"pdf_home_home_tabbarselected.pdf"]
//                                             };
//
//    NSDictionary *tabBarItems3Attributes = @{
//                                             CYLTabBarItemTitle:@"汇款",
//                                             CYLTabBarItemImage: [UIImage yh_imageNamed:@"pdf_home_home_tabbarpdf"],
//                                             CYLTabBarItemSelectedImage:[UIImage yh_imageNamed:@"pdf_home_home_tabbarselected.pdf"]
//                                             };
//
//    NSDictionary *tabBarItems4Attributes = @{
//                                             CYLTabBarItemTitle:@"汇款",
//                                             CYLTabBarItemImage: [UIImage yh_imageNamed:@"pdf_home_home_tabbarpdf"],
//                                             CYLTabBarItemSelectedImage:[UIImage yh_imageNamed:@"pdf_home_home_tabbarselected.pdf"]
//                                             };

    NSArray *tabBarItemsAttributes = @[tabBarItems1Attributes,tabBarItems2Attributes,tabBarItems3Attributes,tabBarItems4Attributes];
    return tabBarItemsAttributes;
    
}

- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
    
    //去除 TabBar 自带的顶部阴影
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    // set the text color for unselected state
    // 普通状态下的文字属性
//    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
//    normalAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
//
//    // set the text color for selected state
//    // 选中状态下的文字属性
//    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
//    selectedAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
//
//    // set the text Attributes
//    // 设置文字属性
//    UITabBarItem *tabBar = [UITabBarItem appearance];
//    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
//    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // Set the dark color to selected tab (the dimmed background)
    // TabBarItem选中后的背景颜色
//    [[UITabBar appearance] setSelectionIndicatorImage:[self imageFromColor:[UIColor colorWithRed:26 / 255.0 green:163 / 255.0 blue:133 / 255.0 alpha:1] forSize:CGSizeMake([UIScreen mainScreen].bounds.size.width / 5.0f, 49) withCornerRadius:0]];
    
    // set the bar background color
    // 设置背景图片
    // UITabBar *tabBarAppearance = [UITabBar appearance];
    // [tabBarAppearance setBackgroundImage:[UIImage imageNamed:@"tabbar_background_ios7"]];
}

+ (UIImage *)imageFromColor:(UIColor *)color forSize:(CGSize)size withCornerRadius:(CGFloat)radius {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Begin a new image that will be the new image with the rounded corners
    // (here with the size of an UIImageView)
    UIGraphicsBeginImageContext(size);
    
    // Add a clip before drawing anything, in the shape of an rounded rect
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius] addClip];
    // Draw your image
    [image drawInRect:rect];
    
    // Get the image, here setting the UIImageView image
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    // Lets forget about that we were drawing
    UIGraphicsEndImageContext();
    return image;
}  

@end
