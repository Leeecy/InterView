//
//  TransDetailViewController.m
//  Interview
//
//  Created by kiss on 2020/4/22.
//  Copyright © 2020 cl. All rights reserved.
//

#import "TransDetailViewController.h"
#import "TranslationController.h"
#import "TransViewCell.h"
#define COLOR_WHITE [UIColor whiteColor]
#define FONT_PF(x)      [UIFont fontWithName:@"PingFangSC-Light" size:x]
#define FONT_B(x)   [UIFont boldSystemFontOfSize:x]
#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height
@interface TransDetailViewController ()<UIViewControllerAnimatedTransitioning,UINavigationControllerDelegate>
@property (strong, nonatomic) UIImageView *headerImageView; // 大图
@property (strong, nonatomic) UIImageView *bgImageView;     // 上个页面截图
@end

@implementation TransDetailViewController{
     CGFloat scale;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIView animateWithDuration:0.2 animations:^{
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    
    _bgImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    _headerImageView = [[UIImageView alloc]init];
    _headerImageView.userInteractionEnabled = YES;
    
    // 背景图
//    [self.view addSubview:self.bgImageView];
//    self.bgImageView.image = self.bgImage;
    
 
    self.headerImageView.frame = CGRectMake(20, 100, SCREEN_WIDTH -20*2, SCREEN_WIDTH*1.3);
    self.headerImageView.image = [UIImage imageNamed:self.imageName];
    [self.view addSubview:self.headerImageView];
}
- (void)initData {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.delegate = self;
    scale = 1;
}

//- (UIImageView *)headerImageView {
//    if (_headerImageView == nil) {
//        _headerImageView = [[UIImageView alloc]init];
//        _headerImageView.userInteractionEnabled = YES;
//    }
//    return _headerImageView;
//}

//- (UIImageView *)bgImageView {
//    if (_bgImageView == nil) {
//        _bgImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
//    }
//    return _bgImageView;
//}

@end
