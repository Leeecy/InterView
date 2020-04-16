//
//  InterScaleViewController.m
//  HHTransitionDemo
//
//  Created by 豫风 on 2018/4/20.
//  Copyright © 2018年 豫风. All rights reserved.
//

#import "InterScaleViewController.h"
#import "UIViewController+HHTransition.h"
#import "UIView+HHLayout.h"

@interface InterScaleViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIImageView *imageView_;
@property (nonatomic, strong) UILabel *alertLabel;
@property(nonatomic,strong)UIView *midView;
@property(nonatomic,strong)UIImageView *bottomImg;
@end

@implementation InterScaleViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:YES];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    CGFloat TOPMagin = iPhoneX ? 180 :100 ;//
    
    self.view.backgroundColor = [UIColor blackColor];
    self.midView = [[UIView alloc]init];
    CGRect beginFrame = CGRectMake(20, TOPMagin, ScreenWidth -20*2, ScreenHeight - TOPMagin -30);
//    CGRect endFrame = CGRectMake(20, SCREEN_HEIGHT, ScreenWidth -20*2, ScreenHeight - TOPMagin -30);
    self.midView.frame = beginFrame;
     [self.view addSubview:self.midView];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    self.imageView_ = imageView;
    imageView.image = _imageName;
    [self.midView addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.midView);
    }];
    
    
//    UILabel *label = [UILabel new];
//    self.alertLabel = label;
//    label.text = @"点击任意点关闭或侧滑查看效果";
//    label.font = [UIFont systemFontOfSize:20];
//    [self.view addSubview:label];
//    label.bott_.centX.equalTo(self.view).offset(20).on_();
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController.interactivePopGestureRecognizer setEnabled:YES];
    
//    self.bottomImg.hh_bottomCS.constant = -100;
    
    [UIView animateWithDuration:0.4 animations:^{
        
        [self.view layoutIfNeeded];
    }];
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, ScreenHeight-226, ScreenWidth, 226)];;
    
    self.bottomImg = img;
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    [img.layer addAnimation:transition forKey:@"a"];
    img.image = [UIImage imageNamed:@"bottom_bg"];
    [self.view addSubview:self.bottomImg];
}

//需要实现
- (UIView *)hh_transitionAnimationView
{
    return self.imageView_;
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}

- (void)dealloc
{
    NSLog(@"销毁了：%@",NSStringFromClass([self class]));
}


@end
