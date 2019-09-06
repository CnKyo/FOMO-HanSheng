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
    
    
    
   //背景二
    UIImageView *bgtwoView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight)];
    bgtwoView.backgroundColor = [UIColor yellowColor];
    
    
    
   //背景三
    UIImageView *bgthreeView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth*2, 0, kScreenWidth, kScreenHeight)];
    bgthreeView.backgroundColor = [UIColor blueColor];
    
    
    
   //背景四
    UIImageView *bgfourView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth*3, 0, kScreenWidth, kScreenHeight)];
    bgfourView.backgroundColor = [UIColor grayColor];
    [_myScrollView addSubview:bgoneView];
    [_myScrollView addSubview:bgtwoView];
    [_myScrollView addSubview:bgthreeView];
    [_myScrollView addSubview:bgfourView];
//    [self loadImageView];
    for(int i=0;i<4;i++){
//        UIPageControl *mPageControl = [UIPageControl new];
//        mPageControl.numberOfPages = 4;
//        mPageControl.currentPageIndicatorTintColor = ssRGBHex(0x006ED9);
//        mPageControl.pageIndicatorTintColor = ssRGBHex(0xFFFFFF);
        
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
//        [oneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(oneImg.mas_bottom).offset(38.5);
//
//        }];
        
        
        UIButton *mButton  = [UIButton new];
        mButton.titleLabel.font = kCommonFont(17);
        mButton.layer.cornerRadius = 20;
        mButton.layer.borderWidth = 1;
        mButton.layer.borderColor = ssRGBHex(0xffffff).CGColor;
        mButton.backgroundColor = [UIColor clearColor];
        [mButton setTitle:languageStr(@"Begin") forState:UIControlStateNormal];
        [mButton setTitleColor:ssRGBHex(0xffffff) forState:UIControlStateNormal];
            if(i==0){
           
            twoLabl.hidden = YES;
            oneImg.image=[UIImage yh_imageNamed:@"pdf_guideView_one_icon"];
            oneLabel.text = languageStr(@"Guideone");
            [bgoneView addSubview:oneImg];
            [bgoneView addSubview:oneLabel];
            [bgoneView addSubview:mButton];
               
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
            [mButton mas_makeConstraints:^(MASConstraintMaker *make) {
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
            [bgtwoView addSubview:mButton];
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
            [mButton mas_makeConstraints:^(MASConstraintMaker *make) {
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
            [bgthreeView addSubview:mButton];
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
            [mButton mas_makeConstraints:^(MASConstraintMaker *make) {
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
            [bgfourView addSubview:mButton];
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
            [mButton mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
    
    //加载引导页里面的内容
//    UIImageView *oneImg = [UIImageView new];
//    oneImg.image=[UIImage yh_imageNamed:@"pdf_guideView_one_icon"];
//    [bgoneView addSubview:oneImg];
//
//    UILabel *oneLabel = [UILabel new];
//    oneLabel.numberOfLines = 0;
//    oneLabel.text = languageStr(@"Guideone");
//    oneLabel.font =  [UIFont fontWithName:@"PingFangSC-Semibold"size:22];
//    oneLabel.textAlignment = NSTextAlignmentCenter;
//    [bgoneView addSubview:oneLabel];
//    
//    
//    [oneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(oneImg.mas_bottom).offset(38.5);
//
//    }];
//    [oneImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(bgoneView).mas_offset(240);
////        make.centerY.equalTo(bgoneView);
//        make.centerX.equalTo(bgoneView);
//        make.height.offset(91.35);
//        make.width.offset(95);
//    }];
//    [self loadPageControl];
    
    
    UIPageControl * pageControl = [[UIPageControl alloc]init];
    pageControl.numberOfPages = 4;
    pageControl.currentPageIndicatorTintColor = ssRGBHex(0x006ED9);
    pageControl.pageIndicatorTintColor = ssRGBHex(0xFFFFFF);
//    pageControl = [[UIPageControl alloc]init];
    
    
//    CGSize pageControlSize = [pageControl sizeForNumberOfPages:4];
    
    
    
    pageControl.currentPage = 0;
    
//    pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
    
//    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    
    [self addSubview:pageControl];
    
//    [self bringSubviewToFront: pageControl];
    
}



    
    





- (void)loadImageView{
    WS(weakSelf);
    NSMutableArray *arr = [NSMutableArray new];
    
    NSString *string = [[NSUserDefaults standardUserDefaults] objectForKey:kLanguageKey];
    if ([string isEqualToString:@"English"]) {
        
        [arr addObjectsFromArray:_englishImageNameArray];

    }else{
        
        [arr addObjectsFromArray:_imageNameArray];
    }
    //添加图片
    for (int i = 0; i < arr.count; i++) {
//        NSString *centerimageName = [arr objectAtIndex:i];
//
//        UIImageView *centerImg = [[UIImageView alloc]init];
        NSString *imageName = [arr objectAtIndex:i];

        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(_myScrollView.frame.size.width*i, 0, _myScrollView.frame.size.width, _myScrollView.frame.size.height)];
        
        
        imageView.image = [UIImage yh_imageNamed:imageName];
        
        imageView.userInteractionEnabled = YES;
        
        
//        [_myScrollView addSubview:imageView];
//        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(weakSelf.myScrollView).mas_offset(240);
//            make.left.equalTo(weakSelf.myScrollView).mas_offset(140);
//            make.right.equalTo(weakSelf.myScrollView).mas_offset(-140)
//        }];
        
        
//        centerImg.image = [UIImage yh_imageNamed:centerimageName];
        
//        centerImg.image = [UIImage yh_imageNamed:centerimageName];
//        centerImg.userInteractionEnabled = YES;
//
//        [_myScrollView addSubview:centerImg];
//        [centerImg mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(weakSelf.myScrollView).mas_offset(240);
//            make.left.equalTo(weakSelf.myScrollView).mas_offset(140);
//            make.right.equalTo(weakSelf.myScrollView).mas_offset(-140);
//        }];
    }
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
}


- (void)loadEnterButton{
    
    _enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _enterButton.frame = CGRectMake((self.frame.size.width - 250)/2, self.frame.size.height - 100, 250, 200);
    [_enterButton setBackgroundColor:[UIColor clearColor]];
    _enterButton.hidden = NO;
    [self addSubview:_enterButton];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 135, 60, 99, 20)];
    _titleLabel.text = languageStr(@"Language");
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.textAlignment = NSTextAlignmentRight;
    _titleLabel.font = kCommonFont(14);
    [self addSubview:_titleLabel];
    
    _showImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_titleLabel.frame) + 7, 67, 12, 7)];
    _showImageView.image = [UIImage yh_imageNamed:@""];
    [self addSubview:_showImageView];
    
    _chageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _chageButton.frame = CGRectMake(self.frame.size.width - 135, 55, 120, 30);
    [_chageButton setBackgroundColor:[UIColor clearColor]];
    [_chageButton addTarget:self action:@selector(changeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_chageButton];
}

- (void)loadChangeLanguageView{
    
    _languageView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width - 120, 86, 105, 87)];
    _languageView.backgroundColor = [UIColor whiteColor];
    _languageView.alpha = 0.8;
    _languageView.hidden = YES;
    _languageView.layer.cornerRadius = 5.0;
    [self addSubview:_languageView];
    
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
    
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        
        _languageView.hidden = NO;
        
    }else{
        
        _languageView.hidden = YES;
    }
}

- (void)languageButtonClicked:(UIButton *)sender{
    
    if (sender.tag == 102) {
        
        _titleLabel.text = @"简体中文";
       
    }else{
        
        _titleLabel.text = @"English";
        
    }
    
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
    
    for (UIView *view in self.subviews) {
        
        if ([view isKindOfClass:[UIImageView class]]) {
            
            [view removeFromSuperview];
        }
    }
    
    [self loadImageView];
}

#pragma mark ---- UIScrollViewDelegate ----
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{     // 当scrollview正在滚动的时候调用
    _enterButton.hidden = NO;
    //根据scrollviewW的滚动位置显示page的第几页
    CGFloat scrollW = scrollView.frame.size.width;
    int page = (scrollView.contentOffset.x + scrollW * 0.5) / scrollW;
    
    if (page == 0) {
        
        _titleLabel.hidden = NO;
        _showImageView.hidden = NO;
        _chageButton.hidden = NO;
        
//        _enterButton.hidden = NO;
       

    }else if (page == 3){
        
        _titleLabel.hidden = YES;
        _showImageView.hidden = YES;
        _chageButton.hidden = YES;
//        _enterButton.hidden = NO;
        
    }else{
        
        _titleLabel.hidden = YES;
        _showImageView.hidden = YES;
        _chageButton.hidden = YES;
//        _enterButton.hidden = YES;
    }
}


@end
