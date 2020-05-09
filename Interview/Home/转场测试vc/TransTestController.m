//
//  TransTestController.m
//  Interview
//
//  Created by kiss on 2020/5/6.
//  Copyright © 2020 cl. All rights reserved.
//

#import "TransTestController.h"
#import "TransSecondController.h"
@interface TransTestController ()<UINavigationControllerDelegate,UIViewControllerAnimatedTransitioning>
@property (strong , nonatomic)UIImageView *bgImage;
@property (strong , nonatomic)UIImageView *headerImg;
@end

@implementation TransTestController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 隐藏导航条
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    // 设置navigaitonControllerDelegate
    self.navigationController.delegate = self;
    // 隐藏状态栏
//    [UIView animateWithDuration:0.2 animations:^{
//        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
       
//    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    _bgImage = [[UIImageView alloc] init];
    _bgImage.contentMode = UIViewContentModeScaleAspectFill;
    _bgImage.layer.cornerRadius  = 10;
    _bgImage.layer.masksToBounds = YES;
//    NSString *name = @"mid_bg-1";//
    _bgImage.image = [UIImage imageNamed:@"WechatIMG14"];//mid_bg
    [self.view addSubview:_bgImage];
    [_bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(200);
    }];
    
    _headerImg = [[UIImageView alloc] init];
    _headerImg.contentMode = UIViewContentModeScaleAspectFit;
    _headerImg.image = [UIImage imageNamed:@"图层 2566"];
    [self.view addSubview:_headerImg];
    [_headerImg sizeToFit];
    
    [_headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bgImage.mas_top).offset(-44);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    TransSecondController *sec = [[TransSecondController alloc]init];
    [self.navigationController pushViewController:sec animated:YES];
}
// MARK: 设置代理
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    return self;
}
//// MARK: 设置动画时间
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1.0f;
}
/**
 A          push --->     B
 B           pop --->     A
 ||                      ||
 fromView              toView 
 */
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    //转场过渡的容器view
    UIView *containerView = [transitionContext containerView];
    //FromVC
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView = fromVC.view;
    fromView.frame = CGRectMake(20, 100, ScreenWidth, ScreenHeight);
    //ToVC
   UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toVC.view;
    toView.hidden =YES;
    //图片背景的空白view (设置和控制器的背景颜色一样，给人一种图片被调走的假象 [可以换种颜色看看效果])
   
    //此处判断是push，还是pop 操作
    BOOL isPush = ([toVC.navigationController.viewControllers indexOfObject:toVC] > [fromVC.navigationController.viewControllers indexOfObject:fromVC]);
   
   [containerView addSubview:fromView];
   [containerView addSubview:toView];//push,这里的toView 相当于secondVC的view
   toView.frame = CGRectMake(ScreenWidth, ScreenHeight, 300, 300);
       
       //因为secondVC的view在firstVC的view之上，所以要后添加到containerView中
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.6f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveLinear animations:^{
        
    } completion:^(BOOL finished) {
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        //设置transitionContext通知系统动画执行完毕
        [transitionContext completeTransition:!wasCancelled];
    }];
    
}
@end
