//
//  BatteryView.m
//  Interview
//
//  Created by kiss on 2020/4/10.
//  Copyright © 2020 cl. All rights reserved.
//

#import "BatteryView.h"

@implementation BatteryView

-(void)drawRect:(CGRect)rect{
    UIColor *color = [UIColor whiteColor];
    [color set];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 1.5;
    path.lineCapStyle = kCGLineJoinRound;
    path.lineJoinStyle = kCGLineJoinRound;
    
    CGPoint point = CGPointMake(100, 90);
    [path moveToPoint:point];
    CGPoint point1 = CGPointMake(100, 85);
    [path addLineToPoint:point1];
    [path addLineToPoint:CGPointMake(50, 85)];
    [path addLineToPoint:CGPointMake(50, 110)];
    [path addLineToPoint:CGPointMake(100, 110)];
    [path addLineToPoint:CGPointMake(100, 105)];
    [path addLineToPoint:CGPointMake(110, 105)];
    [path addLineToPoint:CGPointMake(110, 90)];
    [path closePath];
    [path stroke];
}

@end
