//
//  BaseViewController.m
//  FOMOPay
//
//  Created by clkj on 2019/8/12.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "BaseViewController.h"
@interface BaseViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)WRCustomNavigationBar *mCustomNavBar;

@end

@implementation BaseViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    self.automaticallyAdjustsScrollViewInsets = YES;
    
}
//状态栏
- (void)LoadNavType:(NSUInteger)Type{
    if (Type == 0) {
        [self addNavView1];
    }else if(Type == 1){
        [self addNavView2];
    }
}

-(void)addNavView1{
   
    CLTitleView *Title = [CLTitleView LoadXib];
    [Title mTitleViewStyle:0];
    [self.view addSubview:Title];
    
  
    
}

-(void)addNavView2{
    CLTitleView *Title = [CLTitleView LoadXib];
    [Title mTitleViewStyle:1];
    [self.view addSubview:Title];
    UIButton *btn= [UIButton new];
//    btn.backgroundColor  = [UIColor redColor];
    [btn setTitle:@"添加" forState:UIControlStateNormal];
    [btn setTitleColor:ssRGBHex(0x005CB6) forState:UIControlStateNormal];
   
    btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:16];
    [Title addSubview:btn];
   
    [btn addTarget:self action:@selector(onClickAdd:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Title).offset(35);
        make.right.equalTo(Title).offset(-10);
        make.bottom.equalTo(Title).offset(-12);
      
    }];
    
}

- (void)onClickAdd:(id)sender{
    NSLog(@"1231321323131231231231231");
}


#warning 没有设置button font的字体
//下面是列表上场了
- (void)LoadCellType:(NSUInteger )Type{
    if (Type == 2){
        [self addTabView1];
    }else if(Type == 3){
        [self addTabView2];
    }
}


    




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ssRGBHex(0xF6F6F6);
   

    // Do any additional setup after loading the view.
}




//tabviewcell
- (void)addTabView1{
    UINib *nib = [UINib nibWithNibName:@"CLTableViewCell" bundle:nil];
    [self.mTabView registerNib:nib forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.mTabView];
//    [_mTabView setSeparatorStyle:UITableViewCellSeparatorStyleNone];  //去除cell分割线
    self.mTabView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.mTabView.separatorInset = UIEdgeInsetsZero;
    _mTabView.layoutMargins = UIEdgeInsetsZero;
    [_mTabView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    self.mTabView.backgroundColor = ssRGBHex(0xF6F6F6);
   
    [self.mTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(44 + kAppStatusBarHeight  );
        
    }];
}

- (void)addTabView2{
    UINib *nib = [UINib nibWithNibName:@"CLHiStoryTableViewCell" bundle:nil];
    [self.mTabView registerNib:nib forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.mTabView];
    self.mTabView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.mTabView.separatorInset = UIEdgeInsetsZero;
    _mTabView.layoutMargins = UIEdgeInsetsZero;
    [_mTabView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    self.mTabView.backgroundColor = ssRGBHex(0xF6F6F6);
    self.mTabView.delegate = self;
    self.mTabView.dataSource = self;
   
    [self.mTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.view).offset( 44 + kAppStatusBarHeight );
        
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
- (void)addNavgationLine{
    UIView *mLine = [UIView new];
    mLine.backgroundColor = kLightgrayColor;
    [self.view addSubview:mLine];
    [mLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(45+kAppStatusBarHeight);
        make.height.offset(0.5);
    }];
}
- (void)setMNavTitle:(NSString *)mNavTitle{
    self.title = mNavTitle;
}
- (void)CLAddNavType:(CLNavType)type andModel:(CLNavModel *)model completion:(void(^)(NSInteger tag))handel{
    DebugLog(@"当前控制器堆栈:%lu",(unsigned long)self.navigationController.viewControllers.count);
    WS(weakSelf);
    BOOL mHidden = !(self.navigationController.viewControllers.count-1);

    [self.view addSubview:self.mCustomNavBar];

    if (!model) {
        CLNavModel *mNewModel = [CLNavModel new];
        mNewModel.mTitle = self.title;
        model = mNewModel;
    }
    if (type == CLNavType_default) {
        CLNavgationView *mNav = [CLNavgationView shareNormalNavView];
        mNav.mLeftImg.hidden = mHidden;
        mNav.mLeftBtn.hidden = mHidden;
        [mNav updateView:model];
        mNav.mBtnBlock = ^(NSInteger tag) {
            if (tag == 0) {
                [weakSelf CLNavBackAction];
            }
            
            handel(tag);
        };
        mNav.frame =self.mCustomNavBar.bounds;
        [self.mCustomNavBar addSubview:mNav];
    }else if (type == CLNavType_home){
        CLNavgationView *mNav = [CLNavgationView shareHomeNavView];
        [mNav updateView:model];
        mNav.mBtnBlock = ^(NSInteger tag) {
            if (tag == 0) {
                [weakSelf CLNavBackAction];
            }
            handel(tag);
        };
        mNav.frame =self.mCustomNavBar.bounds;
        [self.mCustomNavBar addSubview:mNav];
        
    }else{
        CLNavgationView *mNav = [CLNavgationView shareNormalNavView];
        [mNav updateView:model];
        mNav.mBtnBlock = ^(NSInteger tag) {
            if (tag == 0) {
                [weakSelf CLNavBackAction];
            }
            handel(tag);
        };
        mNav.frame =self.mCustomNavBar.bounds;
        [self.mCustomNavBar addSubview:mNav];
        
    }
}
- (void)pushToViewController:(UIViewController *)vc{
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)CLNavBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(WRCustomNavigationBar *)mCustomNavBar{
    if (!_mCustomNavBar) {
        _mCustomNavBar = [WRCustomNavigationBar CustomNavigationBar];
    }
    return _mCustomNavBar;
}

@end
