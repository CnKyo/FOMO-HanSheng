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
    
    [self loadImageView];
}

- (void)loadImageView{
    
    NSMutableArray *arr = [NSMutableArray new];
    
    NSString *string = [[NSUserDefaults standardUserDefaults] objectForKey:kLanguageKey];
    if ([string isEqualToString:@"English"]) {
        
        [arr addObjectsFromArray:_englishImageNameArray];

    }else{
        
        [arr addObjectsFromArray:_imageNameArray];
    }
    //添加图片
    for (int i = 0; i < arr.count; i++) {
        
        NSString *imageName = [arr objectAtIndex:i];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(_myScrollView.frame.size.width*i, 0, _myScrollView.frame.size.width, _myScrollView.frame.size.height)];
        imageView.image = [UIImage yh_imageNamed:imageName];
        imageView.userInteractionEnabled = YES;
        [_myScrollView addSubview:imageView];
    }
}

- (void)loadEnterButton{
    
    _enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _enterButton.frame = CGRectMake((self.frame.size.width - 250)/2, self.frame.size.height - 200, 250, 200);
    [_enterButton setBackgroundColor:[UIColor clearColor]];
    _enterButton.hidden = YES;
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
    
    //根据scrollviewW的滚动位置显示page的第几页
    CGFloat scrollW = scrollView.frame.size.width;
    int page = (scrollView.contentOffset.x + scrollW * 0.5) / scrollW;
    if (page == 0) {
        
        _titleLabel.hidden = NO;
        _showImageView.hidden = NO;
        _chageButton.hidden = NO;
        _enterButton.hidden = YES;

    }else if (page == 3){
        
        _titleLabel.hidden = YES;
        _showImageView.hidden = YES;
        _chageButton.hidden = YES;
        _enterButton.hidden = NO;
        
    }else{
        
        _titleLabel.hidden = YES;
        _showImageView.hidden = YES;
        _chageButton.hidden = YES;
        _enterButton.hidden = YES;
    }
}

- (void)initialView{
    
    self.backgroundColor = [UIColor whiteColor];
    
//    [[NSUserDefaults standardUserDefaults] setObject:@"简体中文" forKey:kLanguageKey];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //初始化数据
    _imageNameArray = [NSArray arrayWithObjects:@"pdf.guideView_icon_china_1", @"pdf.guideView_icon_china_2", @"pdf.guideView_icon_china_3",@"pdf.guideView_icon_china_4", nil];
    _englishImageNameArray = [NSArray arrayWithObjects:@"pdf.guideView_icon_english_1", @"pdf.guideView_icon_english_2", @"pdf.guideView_icon_english_3",@"pdf.guideView_icon_english_4", nil];
    
    [self loadMyScrollView];
    
    [self loadEnterButton];
    
    [self loadChangeLanguageView];
}

@end
