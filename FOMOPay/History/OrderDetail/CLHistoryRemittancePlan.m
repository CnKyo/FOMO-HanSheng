//
//  CLHistoryRemittancePlan.m
//  FOMOPay
//
//  Created by clkj on 2019/8/23.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLHistoryRemittancePlan.h"
#import "WKOrderDetailView.h"
@interface CLHistoryRemittancePlan ()<UITableViewDataSource,UITableViewDelegate>
//@property (nonatomic,strong)CLHistoryRenittabcePlanView *StepProgressPortrait;


@property (nonatomic,strong)NSArray *mData;
@property (nonatomic,strong)NSArray *mRData;
@property NSInteger i;
@property (nonatomic,strong)NSArray *mLeftDate;//左边的日期
@property (nonatomic,strong)NSArray *mRightData;
@property (nonatomic,strong)NSArray *mRightDataHint;

@property (strong,nonatomic) WKOrderDetailView *mView;

@end

@implementation CLHistoryRemittancePlan

- (void)viewDidLoad {
    [super viewDidLoad];
    WS(weakSelf);
    CLNavModel *model = [CLNavModel new];
    CLNavgationView_button *mMo = [CLNavgationView_button shareDefaultNavRightButton];
    model.mRightView = mMo  ;
    mMo.mRightBtnBlock = ^(NSInteger tag) {
        if (tag == 1) {
            
            CLHistoryDetailsOfRemittances *vc = [CLHistoryDetailsOfRemittances new];
            vc.mItem = weakSelf.mItem;
            [weakSelf pushToViewController: vc];
            
        }
    };
    self.title = @"汇款进度";
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
    [self initView];

    [self getOrderDetail];
}
- (void)getOrderDetail{
    [self showLoading:nil];
    [WKNetWorkManager WKGetOrderDetail:self.mItem.serialNumber block:^(id result, BOOL success) {
        [self hiddenLoading];
        if (success) {
            NSDictionary *mResponse = [CLTool stringToDic:result];
            if ([[mResponse objectForKey:@"order"] isKindOfClass:[NSDictionary class]]) {
                self.mItem = [WKOrderInfo yy_modelWithDictionary:[mResponse objectForKey:@"order"]];
            }
            [self assemblyData];

        }else{
            TOASTMESSAGE(result);
            [self popToViewController];
        }
    }];
}

- (void)assemblyData{
    
    NSMutableArray *mTempArr = [NSMutableArray new];
    [mTempArr addObjectsFromArray:self.mItem.operations];
    [mTempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        WKOrderOperation *mItem = (WKOrderOperation *)obj;
        mItem.mStatus = YES;
        mItem.mShowTop = YES;

        [mTempArr replaceObjectAtIndex:idx withObject:mItem];

    }];
    for (NSInteger i = 0; i<4-self.mItem.operations.count; i++) {
        WKOrderOperation *mInfo = [WKOrderOperation new];
        mInfo.mStatus = NO;
        if (i == 0) {
            mInfo.operation = @"已收到您的付款";
            mInfo.comment = @"款项核对中...";
        }
        else if (i == 1) {
            mInfo.operation = @"汇款处理中";
            mInfo.comment = @"您的汇款将在今日内处理完毕，稍后将会有短信提示！";

        }else if (i == 2){
            if ([CLTool WKGetOrderStatus:self.mItem.status] == WKOrderStatus_Fail) {
                mInfo.operation = @"汇款失败";
            }else if ([CLTool WKGetOrderStatus:self.mItem.status] == WKOrderStatus_Cancel){
                mInfo.operation = @"汇款已取消";
            }else if ([CLTool WKGetOrderStatus:self.mItem.status] == WKOrderStatus_Error1){
                mInfo.operation = @"汇款失败";
            }else if ([CLTool WKGetOrderStatus:self.mItem.status] == WKOrderStatus_Error2){
                mInfo.operation = @"汇款失败";
            }else if ([CLTool WKGetOrderStatus:self.mItem.status] == WKOrderStatus_Refunding){
                mInfo.operation = @"正在处理退款";
            }else{
                mInfo.operation = @"汇款成功";
            }

        }else{
            mInfo.operation = @"汇款成功";
        }
        [mTempArr addObject:mInfo];

    }
    
  
    for (NSInteger i = 0; i<mTempArr.count; i++) {
        WKOrderOperation *mInfo = mTempArr[i];
        if (mInfo.mStatus == NO) {
            mInfo.mShowTop = YES;
            [mTempArr replaceObjectAtIndex:i withObject:mInfo];
            break;
        }
    }
    self.mItem.operations = mTempArr;
    [self.mView updateOrderInfo:self.mItem];

}
- (void)initView{
    WS(weakSelf);
    self.mView = [WKOrderDetailView shareView];
    self.mView.mBtnBlock = ^(WKOrderDetailViewBtnType mTag) {
        if (mTag == WKOrderDetailViewBtnType_left) {
            [weakSelf leftBtnAction];
        }else if (mTag == WKOrderDetailViewBtnType_right){
            [weakSelf rightBtnAction];
        }else{
            [weakSelf centerBtnAction];
        }
    };
    [self.view addSubview:self.mView];
    [self.mView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(44+kAppStatusBarHeight);
        make.bottom.equalTo(self.view).offset(-kBottomToolBarHeight);
    }];
}
#pragma mark----****----左边按钮的事件
- (void)leftBtnAction{
    if ([self.mItem.status isEqualToString:@"pending"]) {
        [self cancelOrder];
    }else if ([self.mItem.status isEqualToString:@"processing"]){
      
    }else if ([self.mItem.status isEqualToString:@"remitting"]){
       
    }else if ([self.mItem.status isEqualToString:@"successful"]){
       
    }else if ([self.mItem.status isEqualToString:@"failed"]){
       
    }else if ([self.mItem.status isEqualToString:@"refunding"]){
       
    }else if ([self.mItem.status isEqualToString:@"refunded"]){
      
    }else if ([self.mItem.status isEqualToString:@"cancelled"]){
      
    }else if ([self.mItem.status isEqualToString:@"error1"]){
       
    }else{
       
    }
}
#pragma mark----****----右边按钮的事件
- (void)rightBtnAction{
    if ([self.mItem.status isEqualToString:@"pending"]) {
        CLHistoryPaymentdetails *vc = [CLHistoryPaymentdetails new];
        vc.mItem = self.mItem;
        [self pushToViewController:vc];
    }else if ([self.mItem.status isEqualToString:@"processing"]){
        
    }else if ([self.mItem.status isEqualToString:@"remitting"]){
        
    }else if ([self.mItem.status isEqualToString:@"successful"]){
        
    }else if ([self.mItem.status isEqualToString:@"failed"]){
        
    }else if ([self.mItem.status isEqualToString:@"refunding"]){
        
    }else if ([self.mItem.status isEqualToString:@"refunded"]){
        
    }else if ([self.mItem.status isEqualToString:@"cancelled"]){
        
    }else if ([self.mItem.status isEqualToString:@"error1"]){
        
    }else{
        
    }
}
#pragma mark----****----中间按钮的事件
- (void)centerBtnAction{
    if ([self.mItem.status isEqualToString:@"pending"]) {
        
    }else if ([self.mItem.status isEqualToString:@"processing"]){
        
    }else if ([self.mItem.status isEqualToString:@"remitting"]){
        
    }else if ([self.mItem.status isEqualToString:@"successful"]){
        
    }else if ([self.mItem.status isEqualToString:@"failed"]){
        
    }else if ([self.mItem.status isEqualToString:@"refunding"]){
        
    }else if ([self.mItem.status isEqualToString:@"refunded"]){
        
    }else if ([self.mItem.status isEqualToString:@"cancelled"]){
        
    }else if ([self.mItem.status isEqualToString:@"error1"]){
        
    }else{
        
    }
}
- (void)cancelOrder{
    WS(weakSelf);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"取消汇款" message:@"是否要取消本次汇款" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *mCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [mCancel setValue:[UIColor colorWithRed:140/255.0f green:144/255.0f blue:145/255.0f alpha:1] forKey:@"titleTextColor"];
    
    UIAlertAction *mOk = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [weakSelf showLoading:nil];
        [WKNetWorkManager WKDeleteOrder:weakSelf.mItem.serialNumber block:^(id result, BOOL success) {
            [weakSelf hiddenLoading];
            if (success) {
                TOASTMESSAGE(@"Cancel successful!");
                [weakSelf popToViewController:2];
            }else{
                TOASTMESSAGE(result);
            }
        }];
    }];
    
    [alertController addAction:mCancel];
    
    [alertController addAction:mOk];
    
    [weakSelf presentViewController:alertController animated:YES completion:nil];
}
@end
