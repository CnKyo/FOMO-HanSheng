//
//  CLHistoryRefundProgress.m
//  FOMOPay
//
//  Created by Lever on 2019/9/2.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLHistoryRefundProgress.h"

@interface CLHistoryRefundProgress ()

@end

@implementation CLHistoryRefundProgress

- (void)viewDidLoad {
    [super viewDidLoad];
    CLNavModel *model = [CLNavModel new];
    CLNavgationView_button *mBtView = [CLNavgationView_button shareDefaultNavRightButtonRefundProgress];
    model.mRightView = mBtView ;
    mBtView.mRightBtnBlock = ^(NSInteger tag) {
        if (tag == 102) {
            
           CLHistoryDetailsOfRefund *vc = [CLHistoryDetailsOfRefund new];
            [self pushToViewController: vc];
            
        }
    };
    self.title = @"退款进度";
    [self CLAddNavType:CLNavType_default andModel:model completion:^(NSInteger tag) {
        
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
