//
//  KSBatteryView.m
//  FastPair
//
//  Created by cl on 2019/7/26.
//  Copyright © 2019 KSB. All rights reserved.
//

#import "KSBatteryView.h"

@interface KSBatteryView()
@property(nonatomic,assign)BOOL isH12;
@end

@implementation KSBatteryView

-(instancetype)initWithFrame:(CGRect)frame num:(NSInteger)num isFemale:(BOOL)isFemale{
    if (self = [super initWithFrame:frame]) {
        self.isH12 = isFemale;//是女性耳机
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
    UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(x, y, w, h) cornerRadius:2];
    CAShapeLayer *batteryLayer = [CAShapeLayer layer];
    batteryLayer.lineWidth = self.lineW;
    batteryLayer.strokeColor = self.isH12 ?[UIColor colorWithHexString:@"#94969B"].CGColor :[UIColor colorWithHexString:@"#2c2c2c"].CGColor;
    batteryLayer.fillColor = [UIColor clearColor].CGColor;
    batteryLayer.path = [path1 CGPath];
    [self.layer addSublayer:batteryLayer];
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(x+w+1, y+h/3)];
    [path2 addLineToPoint:CGPointMake(x+w+1, y+h*2/3)];
    
    CAShapeLayer *layer2 = [CAShapeLayer layer];
    layer2.lineWidth = 2;
    layer2.strokeColor = self.isH12 ?[UIColor colorWithHexString:@"#94969B"].CGColor : [UIColor colorWithHexString:@"#2c2c2c"].CGColor;
    layer2.fillColor = [UIColor clearColor].CGColor;
    layer2.path = [path2 CGPath];
    [self.layer addSublayer:layer2];
    CGFloat batteryViewxX = num > 0 ? (x+1):x;
    
    UIView *batteryView = [[UIView alloc]initWithFrame:CGRectMake(batteryViewxX,y+_lineW, num -batteryViewxX*2, h-_lineW*2)];
    batteryView.layer.cornerRadius = 2;
    batteryView.backgroundColor =self.isH12 ?[UIColor colorWithHexString:@"#94969B"] : [UIColor colorWithHexString:@"#2c2c2c"];
    [self addSubview:batteryView];
}

@end
