//
//  XWHud.m
//  01---CoreAnimation
//
//  Created by 谢威 on 16/9/9.
//  Copyright © 2016年 成都卓牛科技. All rights reserved.
//

#import "XWHud.h"

@interface XWHud ()

@property (nonatomic,assign)CGSize          currentSize;
@property (nonatomic,strong)UIView          *toView;
@property (nonatomic,strong)CAShapeLayer    *shapLayer;

@end

@implementation XWHud

- (instancetype)initWithSize:(CGSize)size toView:(UIView *)view{
    if (self = [super init]) {
        self.currentSize = size;
        self.toView = view;
        self.backgroundColor = [UIColor clearColor];
        [self config];
    }
    return self;
}
- (void)config{
    // 设置自己的frame
    CGFloat x = (self.toView.width/2)-self.currentSize.width/2 -20;
    CGFloat y = (self.toView.height/2)-self.currentSize.height/2;
    self.frame = CGRectMake(x,y,self.currentSize.width,self.currentSize.height);
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    
    self.shapLayer = [CAShapeLayer layer];
    self.shapLayer.fillColor   =   [UIColor clearColor].CGColor;
    self.shapLayer.strokeColor = [UIColor orangeColor].CGColor;
    self.shapLayer.lineWidth = 2;
    self.shapLayer.strokeStart = 0.f;
    self.shapLayer.strokeEnd = 1.f;
    self.shapLayer.lineCap = kCALineCapRound;
    self.shapLayer.lineJoin = kCALineCapRound;

    self.shapLayer.actions = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNull null],@"strokeStart",[NSNull null],@"strokeEnd", nil];
     self.shapLayer.path = [self getAnimationOnePath];
    [self.layer addSublayer:self.shapLayer];

        
}

#pragma mark -- 默认的动画
- (CAAnimationGroup *)AnimationOne{
    
    // 第一个满圆旋转
    CABasicAnimation *aniamtion1 = [CABasicAnimation animation];
    aniamtion1.keyPath = @"strokeEnd";
    aniamtion1.fromValue = @0;
    aniamtion1.toValue = @1;
    aniamtion1.removedOnCompletion = YES;
    aniamtion1.duration = 1.5;
    aniamtion1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    // 第二个檫除路径
    CABasicAnimation *aniamtion2 = [CABasicAnimation animation];
    aniamtion2.keyPath = @"strokeStart";
    aniamtion2.fromValue = @0;
    aniamtion2.toValue = @1;
    aniamtion2.duration = 1.5;
    aniamtion2.beginTime = 1.5;
    aniamtion1.removedOnCompletion = YES;
    aniamtion2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations =@[aniamtion1,aniamtion2];
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    group.fillMode = kCAFillModeForwards;
    group.duration = 3;
    group.repeatCount = MAXFLOAT;
    return group;
    
    
}

- (void)startHud{
   
     [self.toView addSubview:self];
    
     // 圆圈动画
     [self.shapLayer addAnimation:[self AnimationOne] forKey:nil];
    
     self.transform = CGAffineTransformMakeScale(0.1, 0.1);
      // 自身动画
     [UIView animateKeyframesWithDuration:0.6 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.5 animations:^{
            self.transform = CGAffineTransformMakeScale(1.1, 1.1);
        }];
         [UIView addKeyframeWithRelativeStartTime:0.2 relativeDuration:0.2 animations:^{
             self.transform = CGAffineTransformIdentity;
         }];
         
     } completion:^(BOOL finished) {
         
         
     }];
    
}


#pragma mark --移除layer 添加新的layer
- (void)removeLayerAndAddNewLayer{
    // 先移除layer
    [self.shapLayer removeFromSuperlayer];
    // 移除动画
    [self.shapLayer removeAllAnimations];
    self.shapLayer = [CAShapeLayer layer];
    self.shapLayer.fillColor   =   [UIColor clearColor].CGColor;
    self.shapLayer.strokeColor = [UIColor orangeColor].CGColor;
    self.shapLayer.lineWidth = 3;
    self.shapLayer.strokeStart = 0.f;
    self.shapLayer.strokeEnd = 1.f;
    self.shapLayer.lineCap = kCALineCapRound;
    self.shapLayer.lineJoin = kCALineCapRound;
    
    self.shapLayer.actions = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNull null],@"strokeStart",[NSNull null],@"strokeEnd", nil];

}


- (void)endHud{
    // 自身消失
//    [UIView animateKeyframesWithDuration:0.6 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
//        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.2 animations:^{
//            self.transform = CGAffineTransformMakeScale(1.3, 1.3);
//        }];
//        [UIView addKeyframeWithRelativeStartTime:0.2 relativeDuration:0.5 animations:^{
//            self.transform = CGAffineTransformMakeScale(0.1, 0.1);
//            
//        }];
//        
//    } completion:^(BOOL finished) {
//        [self removeFromSuperview];
//        [self.shapLayer removeAllAnimations];
//        [self.shapLayer removeFromSuperlayer];
//        
//    }];
    
    [self removeFromSuperview];
    [self.shapLayer removeAllAnimations];
    [self.shapLayer removeFromSuperlayer];
    
}

#pragma mark -- 获取路径
- (CGPathRef )getAnimationOnePath{
    
    UIBezierPath *ciclePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2,self.frame.size.height/2) radius:0.8*self.currentSize.width/2 startAngle:M_PI * 3 / 2 endAngle:M_PI * 7 / 2 clockwise:YES];
    
    return ciclePath.CGPath;
}





@end
