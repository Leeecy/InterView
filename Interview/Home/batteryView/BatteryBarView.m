//
//  BatteryBarView.m
//  BatteryBarDemo
//
//  Created by Nick on 2019/11/18.
//  Copyright © 2019 Dudian. All rights reserved.
//

#import "BatteryBarView.h"

@interface BatteryBarView ()

/// 电池框Layer
@property (strong, nonatomic) CAShapeLayer *batteryBoxLayer;
/// 电池正极Layer
@property (strong, nonatomic) CAShapeLayer *batteryPlusLayer;
///电量Layer
@property (strong, nonatomic) CAShapeLayer *batteryPowerLayer;
///电量路径
@property (strong, nonatomic) UIBezierPath *batteryPowerPath;

@end

@implementation BatteryBarView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
        
        [self drawBatteryView];
        self.batteryPower = 0;
    }
    return self;
    
}

/// 画电池
- (void)drawBatteryView{
    UIColor *color = [UIColor whiteColor];
    [color set]; //设置线条颜色
    CGFloat x = self.bounds.origin.x;
    CGFloat y = self.bounds.origin.y;
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    self.lineWidth = 1.5f;
    ///画电池框
    UIBezierPath   *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(x, y, width, height) cornerRadius:0.f];
     [path moveToPoint:CGPointMake(10, 10)];
    [path addLineToPoint:CGPointMake(200, 80)];
    path.lineWidth = 5.0;
    path.lineCapStyle = kCGLineCapRound; //线条拐角
    path.lineJoinStyle = kCGLineJoinRound; //终点处理
    
    [path stroke];
//    [path fill];
}



@end
