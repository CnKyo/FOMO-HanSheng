//
//  CLHistoryRemittancePlan.m
//  FOMOPay
//
//  Created by clkj on 2019/8/23.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLHistoryRemittancePlan.h"

@interface CLHistoryRemittancePlan ()
@property (nonatomic,strong)CLHistoryRenittabcePlanView *StepProgressPortrait;
@property (nonatomic,strong)UIView *mTopView;
@property (nonatomic,strong)UIView *mBotView;
@property (nonatomic,strong)UIView *mSetpView;
@property (nonatomic,strong)CLHistoryRenittabcePlanView *StepProgress;
@end

@implementation CLHistoryRemittancePlan

- (void)viewDidLoad {
    [super viewDidLoad];
    CLNavModel *model = [CLNavModel new];
    CLNavgationView_button *mMo = [CLNavgationView_button shareDefaultNavRightButtonOther];
    model.mRightView = mMo  ;
    mMo.mRightBtnBlock = ^(NSInteger tag) {
        if (tag == 1) {
            DebugLog(@"我终于点击了按钮");
            
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
    [self loadTopView];
    [self loadBotView];
    [self loadinterval];

    
    
}

-(void)loadTopView{//上半部分视图
    self.mTopView = [[UIView alloc]init];
    _mTopView.backgroundColor = ssRGBHex(0xFFFFFF);
    [self.view addSubview:self.mTopView];
//    [self loadStepProg];
    [self loadTopViewLable];
    [self.mTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(44 + kAppStatusBarHeight);
        make.height.offset(154);
    }];
}

-(void)loadTopViewLable{
    UILabel *namelabel = [UILabel new];
    UILabel *putMoney = [UILabel new];
    UILabel *getMoney = [UILabel new];
    namelabel.text = @"收款人";
    namelabel.font = kCommonFont(16);
    namelabel.textColor = ssRGBHex(0x8C9091);
    putMoney.text = @"汇款金额";
    putMoney.font = kCommonFont(16);
   putMoney.textColor = ssRGBHex(0x8C9091);
    getMoney.text = @"获得金额";
    getMoney.font = kCommonFont(16);
    getMoney.textColor = ssRGBHex(0x8C9091);
    [self.mTopView addSubview:namelabel];
    [self.mTopView addSubview:putMoney];
    [self.mTopView addSubview:getMoney];
    [namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mTopView).offset(23);
        make.left.equalTo(self.mTopView).offset(15);
        make.height.offset(16);
    }];
    [putMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(namelabel.mas_bottom).offset(30);
        make.centerX.equalTo(namelabel);
        make.left.equalTo(self.mTopView).offset(15);
          make.height.offset(16);
    }];
    [getMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(putMoney.mas_bottom).offset(30);
        make.centerX.equalTo(namelabel);
        make.left.equalTo(self.mTopView).offset(15);
        make.bottom.equalTo(self.mTopView).offset(-23);
          make.height.offset(16);
    }];
}



-(void)loadinterval{//屏幕分割线
    UIView *minteView = [UIView new];
    minteView.backgroundColor = ssRGBHex(0xE6E6E6);
    [self.view addSubview:minteView];
    [minteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(1);
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.mTopView.mas_bottom);
        make.bottom.equalTo(self.mBotView.mas_top).offset(1);
        
    }];
}

-(void)loadBotView{//下半部分视图
    self.mBotView =  [[UIView alloc]init];
  _mBotView.backgroundColor = ssRGBHex(0xFFFFFF);
    [self.view addSubview:self.mBotView];
    [self loadStepProg];
    [self.mBotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.mTopView.mas_bottom);
        make.bottom.equalTo(self.view).offset(- (135+BottomHeight));
    }];
    
}



-(void)loadStepProg{
//    self.mSetpView = [CLHistoryRenittabcePlanView new];
//    self.mSetpView.backgroundColor = [UIColor redColor];
//    self.StepProgressPortrait = [[CLHistoryRenittabcePlanView alloc]initWithFrame:self.mBotView.frame setDirection:NO setCount:4];
//    self.StepProgressPortrait = [[CLHistoryRenittabcePlanView alloc]init:CGRectMake((self.view.frame.size.width-50)/2, 200, 10, 190) setDirection:NO setCount:4];
//  self
    self.StepProgress = [[CLHistoryRenittabcePlanView alloc]initsetCount:4];
//    self.StepProgressPortrait = [[CLHistoryRenittabcePlanView alloc]initsetCount:4];
//    [self.StepProgressPortrait setDirection:NO setCount:4];
    self.StepProgress.PortraitRecordIndex = 0 ;
    [self.mBotView addSubview:self.StepProgress];
    [self.StepProgress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mBotView).offset(68);
        make.top.equalTo(self.mBotView).offset(85);
//        make.bottom.equalTo(self.mBotView).offset(-35);
        make.height.offset(200);
        make.width.offset(10);
    }];
}
@end
