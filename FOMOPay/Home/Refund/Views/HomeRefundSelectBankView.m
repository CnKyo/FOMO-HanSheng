//
//  HomeRefundSelectBankView.m
//  FOMOPay
//
//  Created by mac_clkj on 2019/8/24.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "HomeRefundSelectBankView.h"

@interface HomeRefundSelectBankView()<UITableViewDelegate,UITableViewDataSource>
    
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIButton *bgButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;

@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@property (nonatomic, copy) NSString *tempString;

@end

@implementation HomeRefundSelectBankView

+ (HomeRefundSelectBankView *)shareView{
    
    HomeRefundSelectBankView *view = [[[NSBundle mainBundle] loadNibNamed:@"HomeRefundSelectBankView" owner:self options:nil] objectAtIndex:0];
    
    view.myTableView.delegate = view;
    view.myTableView.dataSource = view;
    view.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    view.backgroundColor = [UIColor clearColor];
//    view.bgButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    view.bgButton.backgroundColor = ssRGBHexAlpha(0x000000, 0.5);
//    view.bgButton.backgroundColor = [UIColor redColor];
    
    return view;
}

- (NSMutableArray *)dataSourceArray{
    
    if (!_dataSourceArray) {
        
        _dataSourceArray = [NSMutableArray new];
    }
    
    return _dataSourceArray;
}

- (void)updataSource:(NSArray *)array{
    
    [self.dataSourceArray removeAllObjects];
    [self.dataSourceArray addObjectsFromArray:array];
    
    NSInteger bottomSafeHeight = 0;
    if (@available(iOS 11.0, *)) {
        
        UIEdgeInsets safeArea = [[UIApplication sharedApplication] keyWindow].safeAreaInsets;
        bottomSafeHeight = safeArea.bottom;
        
    }else{
        
        bottomSafeHeight = 0;
    }
    _tableViewHeight.constant = 44*self.dataSourceArray.count;
    
    [_myTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSourceArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selectBankCell"];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"selectBankCell"];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, tableView.frame.size.width - 30, 44)];
        titleLabel.tag = 555;
        titleLabel.textColor = kCommonColor(43, 43, 43, 1);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = kCommonFont(14);
        [cell addSubview:titleLabel];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 43, tableView.frame.size.width, 1)];
        line.backgroundColor = kCommonColor(230, 230, 230, 1);
        [cell addSubview:line];
    }
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame: cell.frame];
    cell.selectedBackgroundView.backgroundColor  = ssRGBHex(0xf2f2f2);
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:555];
    titleLabel.text = self.dataSourceArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _tempString = self.dataSourceArray[indexPath.row];
}

- (IBAction)playButtonClicked:(UIButton *)sender {
    
    if (_HomeRefundSelectBankViewBlock) {
        
        _HomeRefundSelectBankViewBlock(_tempString,sender.tag);
    }
}

@end
