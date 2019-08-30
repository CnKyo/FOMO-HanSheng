//
//  CLHistoryRenittabcePlanCell.m
//  FOMOPay
//
//  Created by clkj on 2019/8/23.
//  Copyright © 2019 王钶. All rights reserved.
//

#import "CLHistoryRenittabcePlanView.h"

#define TINTCOLOR [UIColor colorWithRed:35/255.f green:135/255.f blue:255/255.f alpha:1]
static dispatch_once_t disOncePortrait;
@interface  CLHistoryRenittabcePlanView()
//记录数量
@property(nonatomic,assign)NSInteger Count ;
//背景线
@property(nonatomic,strong)UIView * bgLinkView ;
//进度线
@property(nonatomic,strong)UIView * progressLinkView ;
//文字点数组
@property(nonatomic,strong)NSMutableArray * titleArr ;
@property (nonatomic, retain)NSMutableArray *titleLabels;

@property (nonatomic, strong)UILabel *lblIndicator;

@property(nonatomic,strong)NSArray * labelArr ;
@end
@implementation CLHistoryRenittabcePlanView

//-(instancetype)initWithFrame:(CGRect)frame setDirection:(BOOL)Direction setCount:(NSInteger)Count{
-(instancetype)initsetCount:(NSInteger)Count Titles:(nonnull NSArray *)titles{
    if (([super init])) {
        self.Count = Count;
        _bgLinkView = [[UIView alloc]init];
        _bgLinkView.backgroundColor  = ssRGBHex(0xE6E6E6); //默认背景条的颜色
        [self addSubview:self.bgLinkView];
        _progressLinkView = [[UIView alloc]init];
        _progressLinkView.backgroundColor = ssRGBHex(0x005CB6); //滚动时候的颜色
        [self addSubview:self.progressLinkView];
        _labelArr = titles;
        
        for (NSString *title in _labelArr)
        {
            UILabel *lbl = [[UILabel alloc]init];
            lbl.text = title;
            lbl.textColor = [UIColor lightGrayColor];
            lbl.font = [UIFont systemFontOfSize:14];
            lbl.textAlignment = NSTextAlignmentCenter;
            [self addSubview:lbl];
            [self.titleLabels addObject:lbl];
        }
        
        for (int i=0; i<Count; i++) {
            {
                UILabel * titleLabel = [[UILabel alloc]init];
                titleLabel.backgroundColor = ssRGBHex(0xE6E6E6);
                titleLabel.frame =CGRectMake(0, 0, spotWH, spotWH);
                titleLabel.layer.cornerRadius = spotWH/2 ;
                titleLabel.clipsToBounds = YES ;
                titleLabel.tag = i ;
                [self addSubview:titleLabel];
                [self.titleArr addObject:titleLabel];
            }
            
        }
    
    }
    
        return self ;
}



- (void)layoutSubviews{
    self.bgLinkView.frame = CGRectMake((self.bounds.size.width-linkWH)/2, space, linkWH, self.bounds.size.height-space*2);
    for (int i=0; i<self.Count; i++) {
        if(i ==0){
        UILabel * titleLab = self.titleArr[i];
        titleLab.center = CGPointMake(self.bgLinkView.center.x, space+(self.bounds.size.height-space*2)/(self.Count-1)*i);
        titleLab.backgroundColor = ssRGBHex(0x005CB6);
        }else{
            UILabel * titleLab = self.titleArr[i];
            titleLab.center = CGPointMake(self.bgLinkView.center.x, space+(self.bounds.size.height-space*2)/(self.Count-1)*i);
        }

    }
    dispatch_once(&disOncePortrait,^ {
        [self setTitleContent:self.PortraitRecordIndex];
    });

    self.progressLinkView.frame  = CGRectMake((self.bounds.size.width-linkWH)/2,space,linkWH,(self.bounds.size.height-space*2)/(self.Count-1)*self.PortraitRecordIndex) ;
}

-(void)changPortraitLinkViewAnimations{
    [UIView animateWithDuration:0.4 animations:^{
        self.progressLinkView.frame  = CGRectMake((self.bounds.size.width-linkWH)/2,space,linkWH,(self.bounds.size.height-space*2)/(self.Count-1)*self.PortraitRecordIndex) ;
    }completion:^(BOOL finished) {
        [self setTitleContent:self.PortraitRecordIndex];
    }];
}

-(void)setTitleContent:(NSInteger)index{
    for (int i=0; i<self.Count; i++) {
        if (index>=i) { //当前状态
            UILabel * changTitle = self.titleArr[index] ;
            changTitle.backgroundColor  = ssRGBHex(0x005CB6);
            
//          changTitle.layer.borderWidth = 1 ;
            changTitle.layer.borderColor = ssRGBAlpha(102, 102, 102, 1.0).CGColor ;
//          changTitle.backgroundColor = ssRGBHex(0x005CB6);
            [UIView animateWithDuration:0.2 animations:^{
               changTitle.transform = CGAffineTransformMakeScale(1.0, 1.0);
            }];
         }else{              //恢复状态
            UILabel * titleLab = self.titleArr[i];
            titleLab.backgroundColor = ssRGBHex(0xE6E6E6);
            titleLab.transform = CGAffineTransformMakeScale(1.0, 1.0);
        
    }
    }
    
}

//数组
-(NSMutableArray * )titleArr{
    if (!_titleArr) {
        _titleArr = [NSMutableArray arrayWithCapacity:self.Count] ;
    }
    return _titleArr ;
}

#pragma mark--上一步
-(void)lastStep{
    //纵
    if (self.PortraitRecordIndex==0) return ;
    self.PortraitRecordIndex-- ;
    [self changPortraitLinkViewAnimations];
}


#pragma mark--下一步
-(void)nextStep{
    
    if (self.PortraitRecordIndex==self.Count-1) return ;
    self.PortraitRecordIndex++ ;
    [self changPortraitLinkViewAnimations];
}

@end
