//
//  CLCollectionAddTabView.m
//  FOMOPay
//
//  Created by clkj on 2019/9/16.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLCollectionAddTabView.h"
#import "CLCollectionAddView.h"
@interface CLCollectionAddTabView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSArray *mData;
@property (nonatomic,strong)NSMutableArray   *mEnterData;
@end

@implementation CLCollectionAddTabView

- (void)viewDidLoad {
    [super viewDidLoad];
    [self CLAddNavType:CLNavType_default andModel:nil completion:^(NSInteger tag) {
        
    }];
    [self LoadCellType:13];
    [self loadData];
    
}

-(void)loadData{
    self.mData=@[@"全名",@"国籍",@"性别",@"银行",@"开户地址/城市",@"账号号码",@"关系",@"联系号码"];
    self.mEnterData =[NSMutableArray arrayWithObjects:@"全名",@"国籍",@"性别",@"银行",@"开户地址/城市",@"账号号码",@"关系",@"联系号码",nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 49;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    CLCollectionAddView *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if(!cell){
        cell = [[CLCollectionAddView alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    WS(weakSelf);
    __weak typeof (cell) weakCell = cell;
    self.mTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.mLeftName.text = self.mData[indexPath.row];
    cell.mIndexPath = indexPath;
    [cell setView:indexPath and:self.mEnterData[indexPath.row]];
    cell.mBlock = ^(NSIndexPath *mIndexPath, NSString *mText) {
    DebugLog(@"self %@",mText);
    [self.mEnterData replaceObjectAtIndex:mIndexPath.row withObject:mText];
        
    };
    DebugLog(@"%@",self.mEnterData);
    return cell;
}

@end
