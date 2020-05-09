//
//  CoreAnimateController.m
//  suanfa
//
//  Created by cl on 2019/7/18.
//  Copyright © 2019 cl. All rights reserved.
//

#import "CoreAnimateController.h"
#import "CLDropAnimate.h"
#import "SOValueTrackingSlider.h"
#define GKLineLoadingDuration  0.75
#define GKLineLoadingLineColor [UIColor grayColor]


@implementation GKLineLoadingView





+ (void)showLoadingInView:(UIView *)view withLineHeight:(CGFloat)lineHeight {
    GKLineLoadingView *loadingView = [[GKLineLoadingView alloc] initWithFrame:view.frame lineHeight:lineHeight];
    [view addSubview:loadingView];
    [loadingView startLoading];
}



+ (void)hideLoadingInView:(UIView *)view {
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subView in subviewsEnum) {
        if ([subView isKindOfClass:[GKLineLoadingView class]]) {
            GKLineLoadingView *loadingView = (GKLineLoadingView *)subView;
            [loadingView stopLoading];
            [loadingView removeFromSuperview];
        }
    }
}

- (instancetype)initWithFrame:(CGRect)frame lineHeight:(CGFloat)lineHeight {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = GKLineLoadingLineColor;
        
        self.center = CGPointMake(frame.size.width * 0.5f, frame.size.height * 0.5f);
        self.bounds = CGRectMake(0, 0, 1.0f, lineHeight);
    }
    return self;
}

- (void)startLoading {
    [self stopLoading];
    
    self.hidden = NO;
    // 创建动画组
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = GKLineLoadingDuration;
    animationGroup.beginTime = CACurrentMediaTime();
    animationGroup.repeatCount = MAXFLOAT;
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    // x轴缩放动画（transform.scale是以view的中心点为中心开始缩放的）
    CABasicAnimation *scaleAnimation = [CABasicAnimation animation];
    scaleAnimation.keyPath = @"transform.scale.x";
    scaleAnimation.fromValue = @(1.0f);
    scaleAnimation.toValue = @(1.0f * self.superview.frame.size.width);
    
    // 透明度渐变动画
    CABasicAnimation *alphaAnimation = [CABasicAnimation animation];
    alphaAnimation.keyPath = @"opacity";
    alphaAnimation.fromValue = @(1.0f);
    alphaAnimation.toValue = @(0.5f);
    
    animationGroup.animations = @[scaleAnimation, alphaAnimation];
    // 添加动画
    [self.layer addAnimation:animationGroup forKey:nil];
}

- (void)stopLoading {
    [self.layer removeAllAnimations];
    self.hidden = YES;
}
@end



//画圆
@interface CircleView()

@property(assign,nonatomic)CGFloat dialRadius;

@property(assign,nonatomic) CGFloat arcRadius; // must be less than the outerRadius since view clips to bounds
@property(assign,nonatomic) CGFloat outerRadius;//don't set this unless you want some squarish appearance
@property(strong,nonatomic)UIBezierPath *path;
@property(strong,nonatomic)CAShapeLayer *bgLayer;

//红点
@property(strong,nonatomic)UIView *circle;

@end

@implementation CircleView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        self.dialRadius = 10;
        self.arcRadius = width *0.5;
        self.outerRadius = MIN(width, height)/2;

        _path = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
        _bgLayer = [CAShapeLayer layer];
        _bgLayer.frame = self.bounds;
        _bgLayer.fillColor = [UIColor clearColor].CGColor;
        _bgLayer.lineWidth = 2.f;
        _bgLayer.strokeColor = [UIColor greenColor].CGColor;
        _bgLayer.strokeStart = 0.f;//路径开始位置 按百分比
        _bgLayer.strokeEnd = 1.f;
        _bgLayer.path = _path.CGPath;
        [self.layer addSublayer:_bgLayer];
        
        
        CGPoint newCenter = CGPointMake(width/2, height/2);
        self.arcRadius = self.arcRadius; //MIN(self.arcRadius, self.outerRadius - self.dialRadius);
        
        newCenter.y += self.arcRadius * sin(M_PI/180 * (0 - 90));
        newCenter.x += self.arcRadius * cos(M_PI/180 * (0 - 90));
        
        self.circle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.dialRadius*2, self.dialRadius*2)];
        self.circle.userInteractionEnabled = YES;
        self.circle.layer.cornerRadius = 10;
        self.circle.hidden = NO;
        self.circle.backgroundColor = [UIColor redColor];
        self.circle.center = newCenter;
        [self addSubview: self.circle];
        
    }
    return self;
}

-(void)setLineWidth:(CGFloat)lineWidth{
    _lineWidth = lineWidth;
    _bgLayer.lineWidth = lineWidth;
}
-(void)setLineColr:(UIColor *)lineColr{
    _lineColr = lineColr;
    
}

-(void)setProgress:(CGFloat)progress{
    _progress = progress;
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [CATransaction setAnimationDuration:1];
    
    CGPoint newCenter = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);

    newCenter.y += self.arcRadius * sin(M_PI/180 * (360*progress - 90));
    newCenter.x += self.arcRadius * cos(M_PI/180 * (360*progress - 90));
    self.circle.center = newCenter;
    NSLog(@"center---%@",NSStringFromCGPoint(newCenter));
    [CATransaction commit];
}
@end


@interface CoreAnimateController ()<SOValueTrackingSliderDelegate>
@property (strong, nonatomic) GKLineLoadingView *lineview;
@property(strong,nonatomic)CircleView *cView ;
@property(strong,nonatomic)NSTimer *timer;
@end

@implementation CoreAnimateController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =  [UIColor whiteColor];
    [GKLineLoadingView showLoadingInView:self.view withLineHeight:1];
    
    self.cView = [[CircleView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.view addSubview:self.cView];
    self.cView.center = self.view.center;
    [self.cView setLineWidth:6.f];
    [self.cView setLineColr:[UIColor redColor]];
    
    for (int i =0; i<10; i++) {
        SOValueTrackingSlider *slider = [[SOValueTrackingSlider alloc] initWithFrame:CGRectMake(-100+30*i,300, 300, 40)];
        slider.maxmumTrackTintColor = [UIColor redColor];
        slider.minimumTrackTintColor = [UIColor greenColor];
        slider.isVertical = YES;
        slider.delegate = self;
        
        [self.view addSubview:slider];
    }
    
   
    

    
//    CLDropAnimate *animate = [[CLDropAnimate alloc]initWithFrame:CGRectMake(100, 200, 10, 10)];
//    [self.view addSubview:animate];
    
    
     UIBezierPath *path = [self startPoint:CGPointMake(50, 300) endPoint:CGPointMake(200, 300) controlPoint:CGPointMake(125, 200)];
    UIBezierPath *path1 = [self startPoint:CGPointMake(200, 300) endPoint:CGPointMake(350, 300) controlPoint:CGPointMake(275, 400)];

    CAShapeLayer *layer = [self createShapeLayer:[UIColor orangeColor]];
    layer.path = path.CGPath;
    
    CAShapeLayer *layer1 = [self createShapeLayer:[UIColor greenColor]];
    layer1.path = path1.CGPath;
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(50, 667/2)];
    [path2 addLineToPoint:CGPointMake(375/2, 667/2)];
    [path2 addLineToPoint:CGPointMake(300, 667/2)];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    //每次动画的持续时间
    animation.duration = 5;
    //动画起始位置
    animation.fromValue = @(-M_PI_2);//@(0);
    //动画结束位置
    animation.toValue = @(1.5*M_PI);//@(1);
    //动画重复次数
    animation.repeatCount = 100;
    CAShapeLayer *layer2 = [self createShapeLayer:[UIColor orangeColor]];
    layer2.path = path2.CGPath;
    layer2.lineWidth = 2.0;
    //设置图形的弧度
    //    layer.strokeStart = 0;
    //    layer.strokeEnd = 0;
    [layer2 addAnimation:animation forKey:@"strokeEndAnimation"];
    
    
    
    UIBezierPath *path3 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(375/2-100, 500, 20, 20)];
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation1.duration = 6.0;
    animation1.fromValue = @(0);
    animation1.toValue = @(1);
    animation1.repeatCount = 2;
    
    CAShapeLayer *layer3 = [self createShapeLayer:[UIColor clearColor]];
    layer3.strokeColor = [UIColor orangeColor].CGColor;
    layer3.fillColor = [UIColor whiteColor].CGColor;
    layer3.path = path3.CGPath;
    layer3.lineWidth = 2.0;
    //圆的起始位置，默认为0
    layer3.strokeStart = 0;
    //圆的结束位置，默认为1，如果值为0.75，则显示3/4的圆
    layer3.strokeEnd = 1;
    [layer3 addAnimation:animation1 forKey:@"strokeEndAnimation"];

}

-(IBAction)sliderValue:(UISlider*)sender{
    NSLog(@"value ---%f",sender.value);
    self.cView.progress = sender.value;
}
- (UIBezierPath *)startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint controlPoint:(CGPoint)controlPoint{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startPoint];
    [path addQuadCurveToPoint:endPoint controlPoint:controlPoint];
    return path;
    
}
- (CAShapeLayer *)createShapeLayer:(UIColor *)color{
    CAShapeLayer *layer = [CAShapeLayer layer];
    //    layer.frame = CGRectMake(0, 0, 50, 50);
    //设置背景色
//    layer.backgroundColor = [UIColor cyanColor].CGColor;
    //设置描边色
    layer.strokeColor = [UIColor orangeColor].CGColor;
    //设置填充色
    layer.fillColor = color.CGColor;
    [self.view.layer addSublayer:layer];
    return layer;
}

@end
