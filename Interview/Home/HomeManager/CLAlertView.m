//
//  CLAlertView.m
//  Interview
//
//  Created by cl on 2019/7/30.
//  Copyright © 2019 cl. All rights reserved.
//

#import "CLAlertView.h"
#import "UIView+frameAdjust.h"
#import "UIImageView+LBBlurredImage.h"
typedef enum {
    CurrentImageTypeEnumOne=0,//0
    CurrentImageTypeEnumTwo=1,//1
}CurrentImageType;

@interface CLAlertView()
/** 弹窗主内容view */
@property (nonatomic,strong) UIView   *contentView;
/** 弹窗标题 */
@property (nonatomic,copy)   NSString *title;

@property (nonatomic,strong) UIView   *midView;
@property (nonatomic,assign) CurrentImageType CurrentImgType;

@property(strong,nonatomic)NSTimer *timer;

@property(strong,nonatomic)UIImageView *img1;
@property(strong,nonatomic)UIImageView *img2;
@property(strong,nonatomic)UIImageView *img3;
@property(strong,nonatomic)UIImageView *img4;

@end

@implementation CLAlertView

- (instancetype)initWithTitle:(NSString *)title {
    if (self = [super init]) {
        self.title = title;
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(changePic) userInfo:nil repeats:YES];
        _CurrentImgType = CurrentImageTypeEnumOne;

        // UI搭建
        [self setupUI];
    }
    return self;
}
-(void)blurredImage:(UIImageView *)bgImgView {
    // 方法1,没有blurRadius参数,因为默认是20
    //[bgImgView setImageToBlur:[UIImage imageNamed:@"huoying4.jpg"] completionBlock:nil];
    // 方法2,对背景图片进行毛玻璃效果处理,参数blurRadius默认是20,可指定,最后一个参数block回调可为nil
    [bgImgView setImageToBlur:[UIImage imageNamed:@"bg_img"] blurRadius:35 completionBlock:nil];
    [self addSubview:bgImgView];
}

- (void)blurEffect:(UIImageView *)bgImgView {
    /**
     iOS8.0
     毛玻璃的样式(枚举)
     UIBlurEffectStyleExtraLight,
     UIBlurEffectStyleLight,
     UIBlurEffectStyleDark,
     
     // iOS 10新增的枚举值
     UIBlurEffectStyleRegular NS_ENUM_AVAILABLE_IOS(10_0), // Adapts to user interface style
     UIBlurEffectStyleProminent NS_ENUM_AVAILABLE_IOS(10_0), // Adapts to user interface style
     */
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = CGRectMake(0, 0, bgImgView.width , bgImgView.height);
    [bgImgView addSubview:effectView];
    
    // 加上以下代码可以使毛玻璃特效更明亮点
    UIVibrancyEffect *vibrancyView = [UIVibrancyEffect effectForBlurEffect:effect];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:vibrancyView];
    visualEffectView.translatesAutoresizingMaskIntoConstraints = NO;
    [effectView.contentView addSubview:visualEffectView];
}

-(void)setupUI{
    self.frame = [UIScreen mainScreen].bounds;
    UIImageView *bgImgView = [[UIImageView alloc] init];
    [bgImgView setFrame:self.frame];
    [bgImgView setUserInteractionEnabled:YES];
    [bgImgView setContentMode:UIViewContentModeScaleAspectFill];
//    [bgImgView setImage:[UIImage imageNamed:@"bg_img"]];
//    bgImgView.backgroundColor = [UIColor blueColor];
//    [self addSubview:bgImgView];
    
//    [self blurEffect:bgImgView];
    [self blurredImage:bgImgView];
    
    
    
//    self.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.6];
    //------- 弹窗主内容 -------//
    self.contentView = [[UIView alloc] init];
    self.contentView.frame = CGRectMake((ScreenWidth - 285) / 2, (ScreenHeight - 250) / 2, 285, 250);
    self.contentView.center = self.center;
    [self addSubview:self.contentView];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.cornerRadius = 6;
    self.contentView.layer.masksToBounds = YES;
    
    CGFloat midW = 140;
    
    self.midView = [[UIView alloc]initWithFrame:CGRectMake((self.contentView.width - midW)*0.5, (self.contentView.height -midW)*0.5, midW, midW)];
    [self.contentView addSubview:self.midView];
    self.midView.layer.cornerRadius = 6;
    self.midView.layer.masksToBounds = YES;
    self.midView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
  
    CGFloat width = self.midView.width*0.5 -20;
    CGFloat height = self.midView.height*0.5 -20;
    CGFloat x_off = 10;
    CGFloat y_off = 10;
    //中间四个image
    UIImageView *img1 = [[UIImageView alloc]init];
    img1.image = [UIImage imageNamed:@"ic_airplanemode-off"];
    img1.frame = CGRectMake(x_off, y_off,width,height);
    self.img1 = img1;
    [self.midView addSubview:img1];
    
    UIImageView *img2 = [[UIImageView alloc]init];
    img2.image = [UIImage imageNamed:@"on拷贝"];
    img2.frame = CGRectMake(self.midView.width * 0.5 + x_off, y_off,width,height);
    self.img2 = img2;
    [self.midView addSubview:img2];
    
    UIImageView *img3 = [[UIImageView alloc]init];
    img3.image = [UIImage imageNamed:@"wifi"];
    img3.frame = CGRectMake(x_off, self.midView.height *0.5 + y_off,width,height);
    self.img3 = img3;
    [self.midView addSubview:img3];
    
    UIImageView *img4 = [[UIImageView alloc]init];
    img4.image = [UIImage imageNamed:@"ic_bluetooth-off"];
    img4.frame = CGRectMake(self.midView.width *0.5 + x_off, self.midView.height * 0.5 + y_off,width,height);
    self.img4 = img4;
    [self.midView addSubview:img4];
    
    // 标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, self.contentView.width- 10*2, 40)];
    [self.contentView addSubview:titleLabel];
    titleLabel.font = [UIFont boldSystemFontOfSize:13];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = self.title;
    
    // 取消按钮
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.contentView.height - 40, self.contentView.width, 40)];
    [self.contentView addSubview:cancelButton];
    [cancelButton setTitle:@"好的" forState:UIControlStateNormal];
    cancelButton.backgroundColor = [UIColor lightGrayColor];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
//    cancelButton.layer.cornerRadius = 6;
    [cancelButton addTarget:self action:@selector(cancelButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    //------- 调整弹窗高度和中心 -------//
//    self.contentView.height = cancelButton.maxY;
//    self.contentView.center = self.center;
//    self.midView.center = self.contentView.center;
    
   
    
}

/** 弹出此弹窗 */
- (void)show {
    // 出场动画
    self.alpha = 0;
    self.contentView.transform = CGAffineTransformScale(self.contentView.transform, 1.3, 1.3);
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1;
        self.contentView.transform = CGAffineTransformIdentity;
    }];
    
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [window addSubview:self];
}

-(void)changePic{
    if (_CurrentImgType == CurrentImageTypeEnumOne) {
        [self changeImageAnimatedWithView:self.img4 AndImage:[UIImage imageNamed:@"ic_bluetooth-off"]];
        _CurrentImgType = CurrentImageTypeEnumTwo;
    }
    else {
        [self changeImageAnimatedWithView:self.img4 AndImage:[UIImage imageNamed:@"ic_bluetooth-on"]];
        _CurrentImgType = CurrentImageTypeEnumOne;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self scale];
        });
        
    }
}

//动画切换图标
- (void)changeImageAnimatedWithView:(UIImageView *)imageV AndImage:(UIImage *)image {
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    [imageV.layer addAnimation:transition forKey:@"a"];
    [imageV setImage:image];
    
}

-(void)scale{
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anima.toValue = [NSNumber numberWithFloat:1.1f];
    anima.duration = 1.0f;
    [self.img4.layer addAnimation:anima forKey:@"scaleAnimation"];
    [self.img3.layer addAnimation:anima forKey:@"scaleAnimation"];
    [self.img2.layer addAnimation:anima forKey:@"scaleAnimation"];
    [self.img1.layer addAnimation:anima forKey:@"scaleAnimation"];
}


/** 取消按钮点击 */
- (void)cancelButtonClicked {
//    if ([self.delegate respondsToSelector:@selector(CQDeclareAlertView:clickedButtonAtIndex:)]) {
//        [self.delegate CQDeclareAlertView:self clickedButtonAtIndex:1];
//    }
    [self dismiss];
}
/** 移除此弹窗 */
- (void)dismiss {
    self.timer = nil;
    [self.timer invalidate];
    [self removeFromSuperview];
}
@end
