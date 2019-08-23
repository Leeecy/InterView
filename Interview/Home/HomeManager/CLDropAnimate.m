//
//  CLDropAnimate.m
//  Interview
//
//  Created by cl on 2019/7/31.
//  Copyright © 2019 cl. All rights reserved.
//

#import "CLDropAnimate.h"

#define CLLineLoadingDuration  0.75
#define GKLineLoadingLineColor [UIColor grayColor]

@implementation CLDropAnimate

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor  = [UIColor redColor];
        self.frame = frame;
        [self setupUI];
    }
    return self;
}
-(void)setupUI{
    // 创建动画组
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = CLLineLoadingDuration;
    animationGroup.beginTime = CACurrentMediaTime();
    animationGroup.repeatCount = MAXFLOAT;
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    // x轴缩放动画（transform.scale是以view的中心点为中心开始缩放的）
    CABasicAnimation *scaleAnimation = [CABasicAnimation animation];
    scaleAnimation.keyPath = @"transform.scale.x";
    scaleAnimation.fromValue = @(1.0f);
    scaleAnimation.toValue = @(50);
    
    // 透明度渐变动画
    CABasicAnimation *alphaAnimation = [CABasicAnimation animation];
    alphaAnimation.keyPath = @"opacity";
    alphaAnimation.fromValue = @(0.5f);
    alphaAnimation.toValue = @(1.f);
    
    animationGroup.animations = @[scaleAnimation, alphaAnimation];
    // 添加动画
    [self.layer addAnimation:animationGroup forKey:nil];
}
@end
