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

@property (nonatomic,strong)MBProgressHUD *mHud;

@end

@implementation BaseViewController

void TOASTMESSAGE(NSString *message){
    DebugLog(@"%@",message);
   
    [SVStatusHUD showWithImage:[UIImage yh_imageNamed:@"pdf_info_hud"] status:message];
//        [SVStatusHUD showWithImage:[UIImage yh_imageNamed:@"pdf_info_hud"] status:@"修改成功"];
}

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



- (void)onClickAdd:(id)sender{
    NSLog(@"1231321323131231231231231");
}




- (void)LoadCellType:(NSUInteger )Type{
    if (Type == 2){
        [self addHomeTabView];
    }else if(Type == 3){
        [self addHiStoryTabView];
    }else if(Type == 4){
        [self addCollectionTabView];
    }else if(Type == 5){
        [self addMeTabView];
    }else if(Type == 6){
        [self addMeLanguageTabView];
    }else if(Type == 7){
        [self addCollectionSelectTabView];
    }else if(Type == 8){
        [self addMeSwitchTabView];
    }else if(Type == 9){
        [self addCLHistoryDetailsOfRemittancesTabView];
    }else if(Type == 10){
        [self addCLHistorySelctOfPayeeView];
    }
}





- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ssRGBHex(0xF6F5FA);
    self.mPage = 1;

    // Do any additional setup after loading the view.
}




//tabviewcell
- (void)addHomeTabView{
    UINib *nib = [UINib nibWithNibName:@"CLTableViewCell" bundle:nil];
    [self.mTabView registerNib:nib forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.mTabView];
//    [_mTabView setSeparatorStyle:UITableViewCellSeparatorStyleNone];  //去除cell分割线
    self.mTabView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.mTabView.separatorInset = UIEdgeInsetsZero;
    _mTabView.layoutMargins = UIEdgeInsetsZero;
    [_mTabView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    self.mTabView.backgroundColor = ssRGBHex(0xF6F5FA);
   
    [self.mTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_offset( 44 + kAppStatusBarHeight );
        make.left.bottom.right.equalTo(self.view);
        
    }];
}

- (void)addHiStoryTabView{
    UINib *nib = [UINib nibWithNibName:@"CLHiStoryTableViewCell" bundle:nil];
    [self.mTabView registerNib:nib forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.mTabView];
    self.mTabView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.mTabView.separatorInset = UIEdgeInsetsZero;
    _mTabView.layoutMargins = UIEdgeInsetsZero;
    [_mTabView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
     self.mTabView.backgroundColor = ssRGBHex(0xF6F5FA);
    self.mTabView.delegate = self;
    self.mTabView.dataSource = self;
   
    [self.mTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_offset( 44 + kAppStatusBarHeight );
        make.left.bottom.right.equalTo(self.view);
       
        
    }];
}

- (void)addCLHistoryDetailsOfRemittancesTabView{
    UINib *nib = [UINib nibWithNibName:@"CLHistoryDetailsOfRemittancesCellTableViewCell" bundle:nil];
    [self.mTabView registerNib:nib forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.mTabView];
    self.mTabView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.mTabView.separatorInset = UIEdgeInsetsZero;
    _mTabView.layoutMargins = UIEdgeInsetsZero;
    [_mTabView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    self.mTabView.backgroundColor = ssRGBHex(0xF6F5FA);
    self.mTabView.delegate = self;
    self.mTabView.dataSource = self;
    
    [self.mTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_offset( 44 + kAppStatusBarHeight );
        make.left.bottom.right.equalTo(self.view);
        
    }];
}

-(void) addCLHistorySelctOfPayeeView{
    UINib *nib = [UINib nibWithNibName:@"CLHistorySelctOfPayeeView" bundle:nil];
    [self.mTabView registerNib:nib forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.mTabView];
    self.mTabView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.mTabView.separatorInset = UIEdgeInsetsZero;
    _mTabView.layoutMargins = UIEdgeInsetsZero;
    [_mTabView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    self.mTabView.backgroundColor = ssRGBHex(0xF6F5FA);
    self.mTabView.delegate = self;
    self.mTabView.dataSource = self;
    
    [self.mTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_offset( 44 + kAppStatusBarHeight );
        make.left.bottom.right.equalTo(self.view);
        
        
    }];

}


- (void)addCollectionTabView{
    UINib *nib = [UINib nibWithNibName:@"CLCollectionTableViewCell" bundle:nil];
    [self.mTabView registerNib:nib forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.mTabView];
    self.mTabView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.mTabView.separatorInset = UIEdgeInsetsZero;
    self.mTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mTabView.layoutMargins = UIEdgeInsetsZero;
//    [_mTabView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    self.mTabView.backgroundColor = ssRGBHex(0xF6F5FA);
    self.mTabView.delegate = self;
    self.mTabView.dataSource = self;
    
    [self.mTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.view).offset( 44 + kAppStatusBarHeight );
        
    }];
}

-(void)addMeTabView{
    UINib *nib = [UINib nibWithNibName:@"CLMeTableViewCell" bundle:nil];
    [self.mTabView registerNib:nib forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.mTabView];
    
    self.mTabView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.mTabView.separatorInset = UIEdgeInsetsZero;
    _mTabView.layoutMargins = UIEdgeInsetsZero;
    [_mTabView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
     self.mTabView.backgroundColor = ssRGBHex(0xF6F5FA);
    self.mTabView.delegate = self;
    self.mTabView.dataSource = self;
    
    [self.mTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_offset( 44 + kAppStatusBarHeight );
        make.left.bottom.right.equalTo(self.view);
        
    }];
}

-(void)addMeLanguageTabView{
    UINib *nib = [UINib nibWithNibName:@"CLMeLanguage" bundle:nil];
    [self.mTabView registerNib:nib forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.mTabView];
    self.mTabView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.mTabView.separatorInset = UIEdgeInsetsZero;
    _mTabView.layoutMargins = UIEdgeInsetsZero;
       self.mTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTabView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
     self.mTabView.backgroundColor = ssRGBHex(0xF6F5FA);
    self.mTabView.delegate = self;
    self.mTabView.dataSource = self;
    
    [self.mTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_offset( 44 + kAppStatusBarHeight );
        make.left.bottom.right.equalTo(self.view);
        
    }];
}

-(void)addCollectionSelectTabView{
    UINib *nib = [UINib nibWithNibName:@"CLCollectionAddSelectTableView" bundle:nil];
    [self.mTabView registerNib:nib forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.mTabView];
    self.mTabView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.mTabView.separatorInset = UIEdgeInsetsZero;
    _mTabView.layoutMargins = UIEdgeInsetsZero;
    self.mTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTabView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    self.mTabView.backgroundColor = ssRGBHex(0xF6F5FA);
    self.mTabView.delegate = self;
    self.mTabView.dataSource = self;
    
//    [self.mTabView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.bottom.right.equalTo(self.view);
//        make.top.equalTo(self.view).offset( 44 + kAppStatusBarHeight );
//       
//    }];
}


-(void)addMeSwitchTabView{
    UINib *nib = [UINib nibWithNibName:@"CLMeSwitchLanguage" bundle:nil];
    [self.mTabView registerNib:nib forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.mTabView];
    self.mTabView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.mTabView.separatorInset = UIEdgeInsetsZero;
    _mTabView.layoutMargins = UIEdgeInsetsZero;
    self.mTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTabView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    self.mTabView.backgroundColor = ssRGBHex(0xF6F5FA);
    self.mTabView.delegate = self;
    self.mTabView.dataSource = self;
    
    [self.mTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_offset( 44 + kAppStatusBarHeight );
        make.left.bottom.right.equalTo(self.view);
        
    }];
}




- (UITableView *)mTabView{
    if (!_mTabView) {
      _mTabView= [[UITableView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20) style:UITableViewStylePlain];
        self.mTabView.delegate = self;
        self.mTabView.dataSource = self;
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
    }else{
        model.mTitle = self.title;}
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

- (void)showLoading:(NSString *)text{
    if (text.length<=0) {
        text = @"loading...";
    }
    self.mHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.mHud.mode = MBProgressHUDModeIndeterminate;
    self.mHud.label.text = text;
    [self.mHud showAnimated:YES];
}


- (void)hiddenLoading{
    [self.mHud hideAnimated:YES];

}
- (void)ResetLayout{
    [self.mTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-90);
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset( 44 + kAppStatusBarHeight );
    }];
}
- (void)popToViewController{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)popToViewController:(NSInteger)count{
    NSMutableArray* vcs = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
    if( vcs.count > count )
    {
        for (NSInteger i = 0; i<count; i++) {
            [vcs removeLastObject];
        }
        [self.navigationController setViewControllers:vcs   animated:YES];
    }
    else
        [self.navigationController popViewControllerAnimated:YES];
}
@end
