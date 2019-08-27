//
//  CLMeClauseOfTreaty.m
//  FOMOPay
//
//  Created by clkj on 2019/8/19.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLMeClauseOfTreaty.h"

@interface CLMeClauseOfTreaty ()<UIScrollViewDelegate>

@end

@implementation CLMeClauseOfTreaty

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"条约条款";
    [self CLAddNavType:CLNavType_default andModel:nil completion:^(NSInteger tag) {
        switch (tag) {
            case 0:
            {
                DebugLog(@"左边按钮");
            }
                break;
            case 1:
            {
                DebugLog(@"右边按钮");
            }
                break;
            default:
                break;
        }
    }];
}
     
     
     

@end
