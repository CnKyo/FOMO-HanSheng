//
//  CommonGuideView.m
//  workSpace
//
//  Created by mac_clkj on 2019/6/19.
//  Copyright © 2019 chenling. All rights reserved.
//

#import "CommonGuideView.h"

@interface  CommonGuideView()<UIScrollViewDelegate>

//ScrollView
@property (nonatomic, strong) UIScrollView          *myScrollView;
@property (nonatomic, strong) BaseViewController    *superVC;
@property (nonatomic, strong) UIButton              *enterButton;

//data
@property (nonatomic, strong) NSArray               *imageNameArray;
@property (nonatomic, strong) NSArray               *englishImageNameArray;

@property (nonatomic, strong) UIView *languageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *showImageView;
@property (nonatomic, strong) UIButton *chageButton;
@property (nonatomic, strong) UIButton *languageButton;
@property (nonatomic, strong) UIButton *languageButton1;
@property (nonatomic, strong) NSArray *LabelArr;
@property (nonatomic, strong) NSArray *mCenterArr;
@property (nonatomic,strong)    UIPageControl *pageControl;
@property (nonatomic, strong) UIButton *mButton;
@end

@implementation CommonGuideView

#pragma mark - Property

- (void)setFinishAction:(SEL)finishAction{

    _finishAction = finishAction;
    [_enterButton addTarget:self.superVC action:finishAction forControlEvents:UIControlEventTouchUpInside];
    
}

- (instancetype)initWithFrame:(CGRect)frame superVC:(BaseViewController *)superVC{
    
    if (self = [super initWithFrame:frame]) {
        
        _superVC = superVC;
        [self initialView];
    }
    
    return self;
}
- (void)initialView{
    
    self.backgroundColor = [UIColor whiteColor];
    
    //    [[NSUserDefaults standardUserDefaults] setObject:@"简体中文" forKey:kLanguageKey];
    //    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //初始化数据
    //    _imageNameArray = [NSArray arrayWithObjects:@"pdf.guideView_icon_china_1", @"pdf.guideView_icon_china_2", @"pdf.guideView_icon_china_3",@"pdf.guideView_icon_china_4", nil];
    _englishImageNameArray = [NSArray arrayWithObjects:@"pdf.guideView_icon_english_1", @"pdf.guideView_icon_english_2", @"pdf.guideView_icon_english_3",@"pdf.guideView_icon_english_4", nil];
    _imageNameArray = [NSArray arrayWithObjects:@"pdf_guideView_one_icon",
                       @"pdf_guideView_two_icon",
                       @"pdf_guideView_three_icon",
                       @"pdf_guideView_four_icon",
                       nil];
    [self loadMyScrollView];
    
    [self loadEnterButton];
    
    [self loadChangeLanguageView];
    
    [self LoadPageContron];
}




#pragma mark - InitialView

- (void)loadMyScrollView{
    
    _myScrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    [_myScrollView setBackgroundColor:[UIColor whiteColor]];
    [_myScrollView setDelegate:self];
    [_myScrollView setContentSize:CGSizeMake(self.frame.size.width*_imageNameArray.count, self.frame.size.height)];
    [_myScrollView setPagingEnabled:YES];
    [_myScrollView setShowsVerticalScrollIndicator:NO];
    [_myScrollView setShowsHorizontalScrollIndicator:NO];
    [self addSubview:_myScrollView];
    //背景一
    UIImageView *bgoneView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bgoneView.backgroundColor = [UIColor redColor];
    bgoneView.image = [UIImage yh_imageNamed:@"pdf_guide_first"];
    
    
   //背景二
    UIImageView *bgtwoView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight)];
    bgtwoView.backgroundColor = [UIColor yellowColor];
    bgtwoView.image = [UIImage yh_imageNamed:@"pdf_guide_one"];

    
    
   //背景三
    UIImageView *bgthreeView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth*2, 0, kScreenWidth, kScreenHeight)];
    bgthreeView.backgroundColor = [UIColor blueColor];
    bgthreeView.image = [UIImage yh_imageNamed:@"pdf_guide_two"];

    
    
   //背景四
    UIImageView *bgfourView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth*3, 0, kScreenWidth, kScreenHeight)];
    bgfourView.backgroundColor = [UIColor grayColor];
    bgfourView.image = [UIImage yh_imageNamed:@"pdf_guide_three"];

    [_myScrollView addSubview:bgoneView];
    [_myScrollView addSubview:bgtwoView];
    [_myScrollView addSubview:bgthreeView];
    [_myScrollView addSubview:bgfourView];
    
    for(int i=0;i<4;i++){
       
        UIImageView *oneImg = [UIImageView new];
        
        
        UILabel *oneLabel = [UILabel new];
        oneLabel.numberOfLines = 0;
//        oneLabel.text = languageStr(@"Guideone");
        oneLabel.font =  [UIFont fontWithName:@"PingFangSC-Semibold"size:22];
        oneLabel.textColor = ssRGBHex(0xFFFFFF);
        oneLabel.textAlignment = NSTextAlignmentCenter;
//        [bgoneView addSubview:oneLabel];
        
        UILabel *twoLabl = [UILabel new];
        twoLabl.numberOfLines = 0;
        twoLabl.font = kCommonFont(18);
        twoLabl.textColor = ssRGBHex(0xffffff);
        twoLabl.textAlignment = NSTextAlignmentCenter;
        
        
        self.mButton  = [UIButton new];
        self.mButton.titleLabel.font = kCommonFont(17);
        self.mButton.layer.cornerRadius = 20;
        self.mButton.layer.borderWidth = 1;
        self.mButton.layer.borderColor = ssRGBHex(0xffffff).CGColor;
        self.mButton.backgroundColor = [UIColor clearColor];
        [self.mButton setTitle:languageStr(@"Begin") forState:UIControlStateNormal];
        [self.mButton setTitleColor:ssRGBHex(0xffffff) forState:UIControlStateNormal];
            if(i==0){
            
            twoLabl.hidden = YES;
            oneImg.image=[UIImage yh_imageNamed:@"pdf_guideView_one_icon"];
            oneLabel.text = languageStr(@"Guideone");
            [bgoneView addSubview:oneImg];
            [bgoneView addSubview:oneLabel];
            [bgoneView addSubview:self.mButton];
               
                [oneImg mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(bgoneView).mas_offset(240);
                    //        make.centerY.equalTo(bgoneView);
                    make.centerX.equalTo(bgoneView);
                    make.height.offset(91.35);
                    make.width.offset(95);
                }];
            [oneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(oneImg.mas_bottom).mas_offset(37.6);
                make.centerX.equalTo(oneImg);
                }];
            [self.mButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(bgoneView).mas_offset(-BottomHeight - 15);
                    make.height.offset(40);
                    make.width.offset(125);
                    make.centerX.equalTo(bgoneView);
                
            }];
               
                
                
        }else if(i==1){
            
            oneImg.image=[UIImage yh_imageNamed:@"pdf_guideView_two_icon"];
            twoLabl.text=languageStr(@"Simpleststeps");
            oneLabel.text = languageStr(@"Convenient");
            [bgtwoView addSubview:oneImg];
            [bgtwoView addSubview:oneLabel];
            [bgtwoView addSubview:self.mButton];
            [bgtwoView addSubview:twoLabl];
            [oneImg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(bgtwoView).mas_offset(240);
                //        make.centerY.equalTo(bgoneView);
                make.centerX.equalTo(bgtwoView);
                make.height.offset(91.35);
                make.width.offset(95);
            }];
            [oneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(oneImg.mas_bottom).mas_offset(37.6);
                make.centerX.equalTo(oneImg);
            }];
            [self.mButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(bgtwoView).mas_offset(-BottomHeight - 15);
                make.height.offset(40);
                make.width.offset(125);
                make.centerX.equalTo(bgtwoView);
                
            }];
            [twoLabl mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(oneLabel);
                make.top.equalTo(oneLabel.mas_bottom).mas_offset(21);
            }];
            
            
        }else if(i==2){
            oneImg.image=[UIImage yh_imageNamed:@"pdf_guideView_three_icon"];
            twoLabl.text=languageStr(@"Thustedbrand");
            oneLabel.text = languageStr(@"Credible");
            [bgthreeView addSubview:oneImg];
            [bgthreeView addSubview:oneLabel];
            [bgthreeView addSubview:self.mButton];
            [bgthreeView addSubview:twoLabl];
            [oneImg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(bgthreeView).mas_offset(240);
                //        make.centerY.equalTo(bgoneView);
                make.centerX.equalTo(bgthreeView);
                make.height.offset(91.35);
                make.width.offset(95);
            }];
            [oneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(oneImg.mas_bottom).mas_offset(37.6);
                make.centerX.equalTo(oneImg);
            }];
            [self.mButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(bgthreeView).mas_offset(-BottomHeight - 15);
                make.height.offset(40);
                make.width.offset(125);
                make.centerX.equalTo(bgthreeView);
                
            }];
            [twoLabl mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(oneLabel);
                make.top.equalTo(oneLabel.mas_bottom).mas_offset(21);
            }];
        }else{
            
            twoLabl.text=languageStr(@"Moneytransfers");
            oneImg.image=[UIImage yh_imageNamed:@"pdf_guideView_four_icon"];
            oneLabel.text = languageStr(@"Comprehensive");
            [bgfourView addSubview:oneImg];
            [bgfourView addSubview:oneLabel];
            [bgfourView addSubview:self.mButton];
            [bgfourView addSubview:twoLabl];
            [oneImg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(bgfourView).mas_offset(240);
                //        make.centerY.equalTo(bgoneView);
                make.centerX.equalTo(bgfourView);
                make.height.offset(91.35);
                make.width.offset(95);
            }];
            [oneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(oneImg.mas_bottom).mas_offset(37.6);
                make.centerX.equalTo(oneImg);
            }];
            [self.mButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(bgfourView).mas_offset(-BottomHeight - 15);
                make.height.offset(40);
                make.width.offset(125);
                make.centerX.equalTo(bgfourView);
                
            }];
            [twoLabl mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(oneLabel);
                make.top.equalTo(oneLabel.mas_bottom).mas_offset(21);
            }];
    }
        
    }
    
    
}



    
    









-(void)LoadPageContron{
    self.pageControl = [[UIPageControl alloc]init];
    self.pageControl.numberOfPages = 4;
    self.pageControl.currentPage = 0;
    self.pageControl.currentPageIndicatorTintColor = ssRGBHex(0x006ED9);
    self.pageControl.pageIndicatorTintColor = ssRGBHex(0xFFFFFF);
    [self addSubview:self.pageControl];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.mButton.mas_top).offset(-15);
        make.height.offset(8);
        make.width.offset(44);
        
    }];
    
}


- (void)loadEnterButton{
    WS(weakSelf);
    _enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _enterButton.frame = CGRectMake((self.frame.size.width - 250)/2, self.frame.size.height - 100, 250, 200);
    [_enterButton setBackgroundColor:[UIColor clearColor]];
    _enterButton.hidden = NO;
    [weakSelf addSubview:_enterButton];  //底部按钮事件
    _chageButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    _chageButton.frame = CGRectMake(self.frame.size.width - 135, 55, 120, 30);
    [_chageButton setBackgroundColor:[UIColor clearColor]];
    [_chageButton addTarget:self action:@selector(changeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_chageButton];
    [_chageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).mas_offset(0);
        make.top.equalTo(weakSelf).mas_offset(55);
        make.height.offset(30);
        make.width.offset(120);
    }];

          //选择语言图标
    _showImageView = [[UIImageView alloc] init];
//                      WithFrame:CGRectMake(CGRectGetMaxX(_titleLabel.frame) + 7, 67, 12, 7)];
    _showImageView.backgroundColor = [UIColor clearColor];
    _showImageView.image = [UIImage yh_imageNamed:@"pdf_guideView_iconopen"];
    //    _showImageView.image = [_boolArr[section] boolValue] ?
    //    [UIImage yh_imageNamed:@"pdf_collection_shrink.pdf"] :
    //    [UIImage yh_imageNamed:@"pdf_collection_unfold.pdf"];
    [_chageButton addSubview:_showImageView];
    [_showImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(67);
        make.right.equalTo(weakSelf).mas_offset(-17);
        make.height.offset(7);
        make.width.offset(12);
    }];
    
    _titleLabel = [[UILabel alloc] init];
//WithFrame:CGRectMake(self.frame.size.width - 135, 60, 99, 20)];
    _titleLabel.text = languageStr(@"Language");
    _titleLabel.textColor = ssRGBHex(0xFFFFFF);
    _titleLabel.textAlignment = NSTextAlignmentRight;
    _titleLabel.font = kCommonFont(14);
    [_chageButton addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(63);
//        make.right.equalTo(weakSelf.showImageView.mas_left).offset(-7);
        make.right.equalTo(weakSelf.showImageView.mas_left).mas_offset(-8);
//        make.right.equalTo(weakSelf);
        make.height.offset(15);

    }];
    
    
    
    
}


- (void)loadChangeLanguageView{
    WS(weakSelf);
    _languageView = [[UIView alloc] init];
//                     WithFrame:CGRectMake(self.frame.size.width - 120, 86, 105, 87)];
    _languageView.backgroundColor = [UIColor whiteColor];
    _languageView.alpha = 0.8;
    _languageView.hidden = YES;
    _languageView.layer.cornerRadius = 5.0;
    [self addSubview:_languageView];
    [_languageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).mas_offset(8);
        make.right.equalTo(weakSelf).offset(-15);
        make.height.offset(87);
        make.width.offset(105);
    }];
    _languageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _languageButton.frame = CGRectMake(10, 0, 85, 44);
    [_languageButton setTitle:@"简体中文" forState:UIControlStateNormal];
    [_languageButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_languageButton setBackgroundColor:[UIColor clearColor]];
    _languageButton.tag = 102;
    [_languageButton addTarget:self action:@selector(languageButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_languageView addSubview:_languageButton];
    
    _languageButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _languageButton1.frame = CGRectMake(10, 44, 85, 44);
    [_languageButton1 setTitle:@"English" forState:UIControlStateNormal];
    [_languageButton1 setBackgroundColor:[UIColor clearColor]];
    [_languageButton1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _languageButton1.tag = 103;
    [_languageButton1 addTarget:self action:@selector(languageButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_languageView addSubview:_languageButton1];
    
    if ([_titleLabel.text isEqualToString:@"简体中文"]) {
        
        [_languageButton setTitleColor:kLoginTitleColor forState:UIControlStateNormal];


    }else{
        
        [_languageButton1 setTitleColor:kLoginTitleColor forState:UIControlStateNormal];
        
    }
}

- (void)changeButtonClicked:(UIButton *)sender{
    if(sender.selected){
        _languageView.hidden = YES;
        _showImageView.image = [UIImage yh_imageNamed:@"pdf_guideView_iconclose"];
//        sender.selected = NO;
    }else{
        _languageView.hidden = NO;
        _showImageView.image = [UIImage yh_imageNamed:@"pdf_guideView_iconclose"];
//        sender.selected = YES;
    }
    sender.selected = !sender.selected;
    
    
}

- (void)languageButtonClicked:(UIButton *)sender{
    
    if (sender.tag == 102) {
        
        _titleLabel.text = @"简体中文";
         [LocalizationManager setGuidelanguage:@"zh-Hans" andType:0];
       
    }else{
        
        _titleLabel.text = @"English";
         [LocalizationManager setGuidelanguage:@"en" andType:0];
        
    }
    _chageButton.selected = NO;

//    _showImageView.image = [UIImage yh_imageNamed:@"pdf_guideView_iconclose"];
    
    [[NSUserDefaults standardUserDefaults] setObject:_titleLabel.text forKey:kLanguageKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if ([_titleLabel.text isEqualToString:@"简体中文"]) {
        
        [_languageButton setTitleColor:kLoginTitleColor forState:UIControlStateNormal];
        [_languageButton1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    }else{
        
        [_languageButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_languageButton1 setTitleColor:kLoginTitleColor forState:UIControlStateNormal];
    }
    
    _languageView.hidden = YES;
    _showImageView.image = [UIImage yh_imageNamed:@"pdf_guideView_iconopen"];
    for (UIView *view in self.subviews) {
        
        if ([view isKindOfClass:[UIImageView class]]) {
            
            [view removeFromSuperview];
        }
    }
    
//    [self loadImageView];
}

#pragma mark ---- UIScrollViewDelegate ----
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{     // 当scrollview正在滚动的时候调用
    _enterButton.hidden = NO;
    //根据scrollviewW的滚动位置显示page的第几页
    CGFloat scrollW = scrollView.frame.size.width;
    int page = (scrollView.contentOffset.x + scrollW * 0.5) / scrollW;
    scrollView.bounces= (scrollView.contentOffset.y<=0) ?NO:YES;
    
    if (page == 0) {
        
        _titleLabel.hidden = NO;
        _showImageView.hidden = NO;
        _chageButton.hidden = NO;
         self.pageControl.currentPage = 0;
        
        
        
//         [self.contentView setContentSize:CGSizeMake(0, 0)];
//        [self.myScrollView setContentSize:CGSizeMake(0, _myScrollView.frame.size.height)];
//        [scrollView setContentOffset:CGPointMake(0, scrollView.contentOffset.y) animated:NO];
//        _enterBut®ton.hidden = NO;
    }else if(page == 1){
        _titleLabel.hidden = YES;
        _showImageView.hidden = YES;
        _chageButton.hidden = YES;
        _languageView.hidden = YES;
        _chageButton.selected = NO;
        _showImageView.image = [UIImage yh_imageNamed:@"pdf_guideView_iconopen"];
        //        _enterButton.hidden = NO;
        self.pageControl.currentPage = 1;
    }else if (page == 2){
        
        _titleLabel.hidden = YES;
        _showImageView.hidden = YES;
        _chageButton.hidden = YES;
//        _enterButton.hidden = NO;
         self.pageControl.currentPage = 2;
        
    }else{
        
        _titleLabel.hidden = YES;
        _showImageView.hidden = YES;
        _chageButton.hidden = YES;
//        _enterButton.hidden = YES;
         self.pageControl.currentPage = 3;
    }
}


//- (void)getCurrentLanguage  // 获取当前语言
//{
//    NSArray *languages = [NSLocale preferredLanguages];
//    NSString *currentLanguage = [languages objectAtIndex:0];
//    NSLog( @"%@" , currentLanguage);
//}
@end
