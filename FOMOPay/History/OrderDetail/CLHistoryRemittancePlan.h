//
//  CLHistoryRemittancePlan.h
//  FOMOPay
//
//  Created by clkj on 2019/8/23.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CLHistoryRemittancePlan : BaseViewController
//@property(nonatomic,strong) CLHistoryRemittancePlan * StepProgressPortrait ;

-(void)AlterButton:(UIButton *)sender;//修改

-(void)AgainPayButton:(UIButton *)sender; //在次汇款

-(void)GetPdfButton:(UIButton *)sender; //获得pdf收据

-(void)QueryButton:(UIButton *)sender;//查询付款详情

-(void)CancelButton:(UIButton *)sender;//取消汇款



@property (strong, nonatomic) WKOrderInfo *mItem;

@property (strong,nonatomic)  WKOrderOperation *mItemData;
@end

NS_ASSUME_NONNULL_END
