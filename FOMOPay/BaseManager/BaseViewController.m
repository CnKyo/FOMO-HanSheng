//
//  BaseViewController.m
//  FOMOPay
//
//  Created by clkj on 2019/8/12.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "BaseViewController.h"
@interface BaseViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ssRGBHex(0xF6F6F6);
   

    // Do any additional setup after loading the view.
}

//状态栏
- (void)LoadNavType:(NSUInteger)Type{
    if (Type == 0) {
        CLTitleView *Title = [CLTitleView LoadXib];
        [Title mTitleViewStyle:0];
        [self.view addSubview:Title];
    }
}

//下面是列表上场了
- (void)LoadCellType:(NSUInteger )Type{
    if (Type == 2){
        [self addTabView1];
    }else if(Type == 3){
        [self addTabView2];
    }
}


//tabviewcell
- (void)addTabView1{
    UINib *nib = [UINib nibWithNibName:@"CLTableViewCell" bundle:nil];
    [self.mTabView registerNib:nib forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.mTabView];
    self.mTabView.backgroundColor = ssRGBHex(0xF6F6F6);
    
    [self.mTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(44 + kAppStatusBarHeight + 1 );
        
    }];
}

- (void)addTabView2{
    UINib *nib2 = [UINib nibWithNibName:@"CLTableViewCell" bundle:nil];
    [self.mTabView2 registerNib:nib2 forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.mTabView2];
    self.mTabView2.backgroundColor = ssRGBHex(0xF6F6F6);
    self.mTabView2.delegate = self;
    self.mTabView2.dataSource = self;
    [self.mTabView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(81 + 44 + kAppStatusBarHeight + 1 );
        
    }];
}



- (UITableView *)mTabView{
    if (!_mTabView) {
      _mTabView= [[UITableView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20) style:UITableViewStylePlain];
        self.mTabView.delegate = self;
        self.mTabView.dataSource = self;
//        self.mTabView.delegate = self;
//        self.mTabView.dataSource = self;
    }
    return _mTabView;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return nil;
}


-(NSMutableArray *)DataSource{
    if (!_DataSource) {
        _DataSource = [NSMutableArray new];
    }
    return _DataSource;
}

//


@end
