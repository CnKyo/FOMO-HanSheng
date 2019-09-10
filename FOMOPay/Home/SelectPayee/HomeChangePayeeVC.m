//
//  HomeChangePayeeVC.m
//  FOMOPay
//
//  Created by mac_clkj on 2019/8/27.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "HomeChangePayeeVC.h"
#import "HomeChangePayeeCell.h"

@interface HomeChangePayeeVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSArray *dataSourceArray;

@property (nonatomic, strong) NSString *mBankNumber;

@end

@implementation HomeChangePayeeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kCommonColor(246, 245, 250, 1);
    self.title =  @"修改收款人信息";
    
    [self CLAddNavType:CLNavType_default andModel:nil completion:^(NSInteger tag) {
        
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
        make.bottom.equalTo(self.view).offset(-10-bottomSafeHeight);
        make.top.equalTo(self.view).offset(44 + rectStatus.size.height);
    }];
    
    [_myTableView registerNib:[UINib nibWithNibName:@"HomeChangePayeeCell" bundle:nil] forCellReuseIdentifier:@"HomeChangePayeeCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return _myTableView.frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(weakSelf);
    HomeChangePayeeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeChangePayeeCell"];
    if (!cell) {
        
        cell = [[HomeChangePayeeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeChangePayeeCell"];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.HomeChangePayeeCellText = ^(NSString *text, NSInteger tag) {
        
        if (tag == 102) {
            weakSelf.mBankNumber = text;
        }
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setMItem:self.mItem];
    cell.HomeChangePayeeCellButton = ^(NSInteger tag) {
        
        if (tag == 4) {  //删除
            
            UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"删除收款人" message:@"是否要删除此收款人信息" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                
                DebugLog(@"点击了取消按钮");
            }];
            
            UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                DebugLog(@"点击了确定按钮");
                [weakSelf deleteAction];
            }];
            
            [alertVc addAction:cancle];
            [alertVc addAction:confirm];
            
            [self presentViewController:alertVc animated:YES completion:^{}];
            
        }else if (tag == 5){ //提交
            [weakSelf confirmAction];
        }
    };
    
    return cell;
}
- (void)confirmAction{
    if (self.mBankNumber.length<=0) {
        TOASTMESSAGE(@"Please enter your bank account number!");
        return;
    }
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:self.mItem.fullName forKey:@"fullName"];
    [para setObject:self.mItem.gender forKey:@"gender"];
    [para setObject:self.mItem.nationality forKey:@"nationality"];
    [para setObject:self.mItem.currencyCode forKey:@"currencyCode"];
    [para setObject:self.mItem.contactNumber forKey:@"contactNumber"];
    [para setObject:self.mItem.bankName forKey:@"bankName"];
    [para setObject:self.mItem.bankCity forKey:@"bankCity"];
    [para setObject:self.mBankNumber forKey:@"accountNumber"];
    [para setObject:self.mItem.relationship forKey:@"relationship"];
    
    [self showLoading:nil];
    [WKNetWorkManager WKModifyRecipientInfo:self.mItem.id andPara:para block:^(id result, BOOL success) {
        [self hiddenLoading];
        if (success) {
            NSDictionary *mResponse = [CLTool stringToDic:result];
            if ([[mResponse objectForKey:@"recipient"] isKindOfClass:[NSDictionary class]]) {
                self.mItem = [WKResipientInfoObj yy_modelWithDictionary:[mResponse objectForKey:@"recipient"]];
            }
            if (self.mBackBlock) {
                self.mBackBlock(self.mItem,1);
            }
            [self popToViewController];
        }else{
            TOASTMESSAGE(result);
        }
    }];
}
- (void)deleteAction{
    [self showLoading:nil];
    [WKNetWorkManager WKDeleteRecipientInfo:self.mItem.id block:^(id result, BOOL success) {
        [self hiddenLoading];
        if (success) {
            TOASTMESSAGE(@"Delete successful!");

            [self popToViewController:3];
        }else{
            TOASTMESSAGE(result);
        }
    }];
}
@end
