//
//  KSBatteryVertical.m
//  Interview
//
//  Created by kiss on 2020/5/15.
//  Copyright © 2020 cl. All rights reserved.
//

#import "KSBatteryVertical.h"

@implementation KSBatteryVertical

-(instancetype)initWithFrame:(CGRect)frame num:(NSInteger)num{
    if (self = [super initWithFrame:frame]) {
       
        [self creatBatteryView:num];
    }
    return self;
}
- (void)creatBatteryView:(NSInteger)num{
    // 电池的宽度
    CGFloat w = self.bounds.size.width;
    // 电池的高度
    CGFloat h = self.bounds.size.height;
    // 电池的x的坐标
    CGFloat x = self.bounds.origin.x;
    // 电池的y的坐标
    CGFloat y = self.bounds.origin.y;
    // 电池的线宽
    self.lineW = 1;
    // 画电池
    UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(x, y, w, h) cornerRadius:1];
    CAShapeLayer *batteryLayer = [CAShapeLayer layer];
    batteryLayer.lineWidth = self.lineW;
    batteryLayer.strokeColor = [UIColor greenColor].CGColor;
    batteryLayer.fillColor = [UIColor clearColor].CGColor;
    batteryLayer.path = [path1 CGPath];
    [self.layer addSublayer:batteryLayer];
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(x+w/4,y-0.5)]; //x+w+1, y+h/3
    [path2 addLineToPoint:CGPointMake(x+3*w/4, y-0.5)]; //x+w+1, y+h*2/3

    CAShapeLayer *layer2 = [CAShapeLayer layer];
    layer2.lineWidth = 1;
    layer2.strokeColor =  [UIColor redColor].CGColor;
    layer2.fillColor = [UIColor clearColor].CGColor;
    layer2.path = [path2 CGPath];
    [self.layer addSublayer:layer2];
    
    CGFloat batteryViewxX = num > 0 ? (x+1):x;
    UIView *batteryView = [[UIView alloc]initWithFrame:CGRectMake(batteryViewxX,y+h-num, w -batteryViewxX*2, num)];
    batteryView.layer.cornerRadius = 2;
    batteryView.backgroundColor = [UIColor colorWithHexString:@"#2c2c2c"];
    [self addSubview:batteryView];
}

@end
