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
    
    HomeChangePayeeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeChangePayeeCell"];
    if (!cell) {
        
        cell = [[HomeChangePayeeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeChangePayeeCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.HomeChangePayeeCellText = ^(NSString *text, NSInteger tag) {
        
        
    };
    
    cell.HomeChangePayeeCellButton = ^(NSInteger tag) {
        
        if (tag == 4) {  //删除
            
            UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"删除收款人" message:@"是否要删除此收款人信息" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                
                NSLog(@"点击了取消按钮");
            }];
            
            UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                NSLog(@"点击了确定按钮");
                [self.navigationController popViewControllerAnimated:YES];
            }];
            
            [alertVc addAction:cancle];
            [alertVc addAction:confirm];
            
            [self presentViewController:alertVc animated:YES completion:^{}];
            
        }else if (tag == 5){ //提交
            
        }
    };
    
    return cell;
}

@end
