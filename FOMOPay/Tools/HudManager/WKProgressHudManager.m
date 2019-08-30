//
//  WKProgressHudManager.m
//  CLHospitalSysTem
//
//  Created by apple on 2019/7/18.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "WKProgressHudManager.h"

@interface WKProgressHudManager ()

@property (strong,nonatomic) MBProgressHUD *hud;

@end

static WKProgressHudManager *manager = nil;

@implementation WKProgressHudManager

+ (instancetype)shareInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[self alloc] init];
    });
    return manager;
}

- (instancetype)init{
    
    self = [super init];
    if(self){
    
    }
    return self;
}

- (void)showLoadingWithText:(NSString *)text withView:(UIView *)view{
    
    if (!view) {
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        self.hud = [MBProgressHUD showHUDAddedTo:window animated:YES];

    }else{
        
        self.hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    
    // Set the label text.
    self.hud.label.text = NSLocalizedString(text, @"HUD loading title");
}

- (void)showSuceessWithText:(NSString *)text withView:(UIView *)view{
    
    if (!view) {
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        self.hud = [MBProgressHUD HUDForView:window];

    }else{
        
        self.hud = [MBProgressHUD HUDForView:view];
    }
    // Set the label text.
    self.hud.label.text = NSLocalizedString(text, @"HUD loading title");
    UIImage *image = [[UIImage yh_imageNamed:@"icon_hud_success"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    self.hud.customView = imageView;
    self.hud.mode = MBProgressHUDModeCustomView;
}

- (void)showErrorWithText:(NSString *)text withView:(UIView *)view{
    
    if (!view) {
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        self.hud = [MBProgressHUD HUDForView:window];
        
    }else{
        
        self.hud = [MBProgressHUD HUDForView:view];
    }
    // Set the label text.
    self.hud.label.text = NSLocalizedString(text, @"HUD loading title");
    UIImage *image = [[UIImage yh_imageNamed:@"icon_hud_error"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    self.hud.customView = imageView;
    self.hud.mode = MBProgressHUDModeCustomView;
}

- (void)showPromptWithText:(NSString *)text withView:(UIView *)view{
    
    if (!view) {
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        self.hud = [MBProgressHUD HUDForView:window];
        
    }else{
        
        self.hud = [MBProgressHUD HUDForView:view];
    }
    // Set the label text.
    self.hud.label.text = NSLocalizedString(text, @"HUD loading title");
    UIImage *image = [[UIImage yh_imageNamed:@"icon_hud_prompt"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    self.hud.customView = imageView;
    self.hud.mode = MBProgressHUDModeCustomView;
}

- (void)hiddenHud{
    
    [self.hud hideAnimated:YES];
}

@end
