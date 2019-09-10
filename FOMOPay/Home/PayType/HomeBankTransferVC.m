//
//  HomeBankTransferVC.m
//  FOMOPay
//
//  Created by mac_clkj on 2019/8/28.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "HomeBankTransferVC.h"
#import "HomeBankTransferCell.h"

@interface HomeBankTransferVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSArray *dataSourceArray;

@end

@implementation HomeBankTransferVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kCommonColor(246, 245, 250, 1);
    self.title = @"银行转账";
    CLNavModel *mNewModel = [CLNavModel new];
    [self CLAddNavType:CLNavType_default andModel:mNewModel completion:^(NSInteger tag) {
        
    }];
    
    [self loadTableView];
}

- (void)loadTableView{
    
    NSInteger bottomSafeHeight = 0;
    
    if (@available(iOS 11.0, *)) {
        
        UIEdgeInsets safeArea = [[UIApplication sharedApplication] keyWindow].safeAreaInsets;
        bottomSafeHeight = safeArea.bottom;
        
    }else{
        
        bottomSafeHeight = 0;
    }
    
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    _myTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_myTableView];
    
    [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-bottomSafeHeight);
        make.top.equalTo(self.view).offset(44 + rectStatus.size.height + 1);
    }];
    
    [_myTableView registerNib:[UINib nibWithNibName:@"HomeBankTransferCell" bundle:nil] forCellReuseIdentifier:@"HomeBankTransferCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return _myTableView.frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeBankTransferCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeBankTransferCell"];
    if (!cell) {
        
        cell = [[HomeBankTransferCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeBankTransferCell"];
//
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    NSString *string = [NSString stringWithFormat:@"%d %@",[self.mOrderInfo.order.remittable.chargable.amount intValue],self.mOrderInfo.order.remittable.chargable.currencyCode];
    
    NSString *sstring = [NSString stringWithFormat:@"2.转账%@到如下所示的账户",string];
    
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc] initWithString:sstring];
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:ssRGBHex(0x36A9E1) range:NSMakeRange(4, string.length)];
    
    cell.secondStepLabel.attributedText = AttributedStr;//设置显示的金额的富文本;
//
    cell.orderLabel.text = [NSString stringWithFormat:@"%@",self.mOrderInfo.order.serialNumber]; // 订单号
    
    cell.accountLabel.text = [NSString stringWithFormat:@"%@",self.mOrderInfo.order.recipient.accountNumber]; //账户号码
    
    cell.bankNameLabel.text = [NSString stringWithFormat:@"%@",self.mOrderInfo.order.recipient.bankName]; //银行名
    
    cell.accountNameLabel.text = [NSString stringWithFormat:@"%@",self.mOrderInfo.order.recipient.fullName]; //账户名
    
    __weak __typeof(self)weakSelf = self;
    __weak __typeof(cell)weakCell =cell;
    cell.HomeBankTransferCellBlock = ^(NSInteger tag) {
        
        if (tag == 0) { //复制
            UIPasteboard *pab = [UIPasteboard generalPasteboard];
            pab.string = weakCell.accountLabel.text;
            DebugLog(@"复制完成了");
        }else{  //完成
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    };
    
    return cell;
}

@end
