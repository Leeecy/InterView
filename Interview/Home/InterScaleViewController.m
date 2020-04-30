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
#import "AddViewController.h"
#import "CLAddHeaderCollectionCell.h"
#import "SliderViewController.h"
@interface InterScaleViewController ()<UIGestureRecognizerDelegate,UIViewControllerAnimatedTransitioning,UINavigationControllerDelegate>

@property (nonatomic, strong) UIImageView *imageView_;
@property (nonatomic, strong) UILabel *alertLabel;
@property(nonatomic,strong)UIView *midView;
@property(nonatomic,strong)UIImageView *bottomImg;

@property (strong, nonatomic) UIImageView *headerImageView; // 大图
@property (strong, nonatomic) UIImageView *bgImageView;     // 上个页面截图

@end

@implementation InterScaleViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:YES];

}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController.interactivePopGestureRecognizer setEnabled:YES];
  
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationController.delegate = self;
    
    self.view.backgroundColor = [UIColor blackColor];
    NSLog(@"cell==%@",self.addCell);
    CGFloat TOPMagin = iPhoneX ? 120 :40 ;//
    
    self.midView = [[UIView alloc]init];
    
    CGRect beginFrame = CGRectMake(20, TOPMagin, ScreenWidth -20*2, ScreenHeight - TOPMagin -30);
//    CGRect endFrame = CGRectMake(20, SCREEN_HEIGHT, ScreenWidth -20*2, ScreenHeight - TOPMagin -30);
    self.midView.frame = beginFrame;
    [self.view addSubview:self.midView];
    
    _headerImageView = [[UIImageView alloc]init];
    _headerImageView.userInteractionEnabled = YES;
    self.headerImageView.frame = CGRectMake(20, TOPMagin, ScreenWidth -20*2, ScreenWidth*1.3);
    self.headerImageView.image = [UIImage imageNamed:self.imageName];
    self.headerImageView.layer.cornerRadius  = 10;
    self.headerImageView.layer.masksToBounds = YES;
    [self.midView addSubview:self.headerImageView];

    [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.midView);
    }];
    
    //右上角删除按钮
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:@"失败"] forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(deleteClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-34);
        make.top.equalTo(self.view.mas_top).offset(50);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    
    
    UIView *bottomV = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 260)];
    [self.view addSubview:bottomV];
    UIImageView *img = [[UIImageView alloc]initWithFrame:bottomV.bounds];
       
    self.bottomImg = img;
    img.image = [UIImage imageNamed:@"bottom_bg"];
    [bottomV addSubview:self.bottomImg];
   
    [UIView animateWithDuration:0.3  animations:^{
       bottomV.frame = CGRectMake(0, ScreenHeight-260, ScreenWidth, 260);
   } completion:^(BOOL finished) {
       
   }];
    //testbtn
   UIButton *btn1 = [[UIButton alloc]init];
   [btn1 setImage:[UIImage imageNamed:@"失败"] forState:(UIControlStateNormal)];
   [btn1 addTarget:self action:@selector(testClick:) forControlEvents:(UIControlEventTouchUpInside)];
   [bottomV addSubview:btn1];
   [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
       make.right.equalTo(self.view.mas_right).offset(-34);
       make.bottom.equalTo(self.view.mas_bottom).offset(-50);
       make.size.mas_equalTo(CGSizeMake(20, 20));
   }];

}

-(IBAction)testClick:(UIButton*)sender{
    [self.navigationController pushViewController:[SliderViewController new] animated:YES];
}
-(IBAction)deleteClick:(UIButton*)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    NSLog(@"from==%@ tovc==%@",fromVC,toVC);
    if ([toVC isKindOfClass:[AddViewController class]]) {
        return self;
    }else{
       return nil;
    }
    
}

#pragma mark - UIViewControllerAnimatedTransitioning

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 1.0f;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
     AddViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    InterScaleViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    UIView *fromView = [fromVC valueForKeyPath:@"headerImageView"];
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
   
    UIView *originView = self.addCell.bgImage;
    
    UIView *snapShotView = [fromView snapshotViewAfterScreenUpdates:NO];
    snapShotView.layer.masksToBounds = YES;
    snapShotView.layer.cornerRadius = 15;
    snapShotView.frame = [containerView convertRect:fromView.frame fromView:fromView.superview];
    
    fromView.hidden = YES;
    originView.hidden = YES;
    
    [containerView insertSubview:toVC.view belowSubview:fromVC.view];
    [containerView addSubview:snapShotView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:1.f initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
           [containerView layoutIfNeeded];
           fromVC.view.alpha = 0.0f;
           snapShotView.layer.cornerRadius = 15;
           snapShotView.frame = [containerView convertRect:originView.frame fromView:originView.superview];
        
       } completion:^(BOOL finished) {
           fromView.hidden = YES;
           [snapShotView removeFromSuperview];
           originView.hidden = NO;
           [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
       }];
}

- (void)dealloc
{
    NSLog(@"销毁了：%@",NSStringFromClass([self class]));
}


@end
