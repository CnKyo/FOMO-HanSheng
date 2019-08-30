//
//  HomePayNowViewController.m
//  FOMOPay
//
//  Created by mac_clkj on 2019/8/28.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "HomePayNowViewController.h"
#import "HomePayNowListCell.h"

@interface HomePayNowViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSArray *dataSourceArray;

@end

@implementation HomePayNowViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kCommonColor(246, 245, 250, 1);
    
    CLNavModel *mNewModel = [CLNavModel new];
    mNewModel.mTitle = @"Paynow";
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
    
    [_myTableView registerNib:[UINib nibWithNibName:@"HomePayNowListCell" bundle:nil] forCellReuseIdentifier:@"HomePayNowListCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return _myTableView.frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomePayNowListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomePayNowListCell"];
    if (!cell) {
        
        cell = [[HomePayNowListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomePayNowListCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    __weak __typeof(self)weakSelf = self;
    
    cell.HomePayNowListCellBlock = ^(NSInteger tag) {
        
        if (tag == 0) {     //下载二维码
            
            UIImage *image = nil;
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
            
        }else{  //完成
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    };
    
    return cell;
}

//保存图片完成之后的回调
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if (error != NULL){
        
        [WKHudManager WKShowErrorHud:@"保存失败" view:self.view];
        
    }else{
        
        [WKHudManager WKShowSuccessHud:@"保存成功" view:self.view];
    }
}



@end
