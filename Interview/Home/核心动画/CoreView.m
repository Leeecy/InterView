//
//  CoreView.m
//  Interview
//
//  Created by kiss on 2020/5/9.
//  Copyright © 2020 cl. All rights reserved.
//

#import "CoreView.h"

@implementation CoreView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}
-(void)setUI{
    UIBezierPath *path3 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(375/2-100, 500, 20, 20)];
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation1.duration = 6.0;
    animation1.fromValue = @(-M_PI_2);// @(0);
    animation1.toValue = @(1.5*M_PI);//@(1);
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
- (CAShapeLayer *)createShapeLayer:(UIColor *)color{
    CAShapeLayer *layer = [CAShapeLayer layer];
    //    layer.frame = CGRectMake(0, 0, 50, 50);
    //设置背景色
//    layer.backgroundColor = [UIColor cyanColor].CGColor;
    //设置描边色
    layer.strokeColor = [UIColor orangeColor].CGColor;
    //设置填充色
    layer.fillColor = color.CGColor;
    [self.layer addSublayer:layer];
    return layer;
}

@end
