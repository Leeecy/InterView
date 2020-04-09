//
//  KSWavesAnimation.m
//  FastPair
//
//  Created by cl on 2019/7/24.
//  Copyright © 2019 KSB. All rights reserved.
//

#import "KSWavesAnimation.h"
#define kColorMakeWithRGB(x,y,z,a) [UIColor colorWithRed:x/255.0 green:y/255.0 blue:z/255.0 alpha:a]

@interface KSWavesAnimation(){
    CAShapeLayer *backGroundLayer;      //背景图层
    CAShapeLayer *frontFillLayer;       //用来填充的图层
    UIBezierPath *backGroundBezierPath; //背景贝赛尔曲线
    UIBezierPath *frontFillBezierPath;  //用来填充的贝赛尔曲线
}
@property(strong,nonatomic)NSTimer *timer;
@property(nonatomic,assign)int sumCount;
@end

@implementation KSWavesAnimation

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self setUp];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        [self setUp];
        _sumCount = 0;
    }
    return self;
    
}

-(void)setUp{
    //创建背景图层
    backGroundLayer = [CAShapeLayer layer];
    backGroundLayer.fillColor = kColorMakeWithRGB(34, 34, 40, 1).CGColor;
    
    //创建填充图层
    frontFillLayer = [CAShapeLayer layer];
    frontFillLayer.fillColor = nil;
//    frontFillLayer.fillColor = [UIColor lightGrayColor].CGColor;
    
    [self.layer addSublayer:backGroundLayer];
    [self.layer addSublayer:frontFillLayer];
    
    
    
    //设置颜色
    frontFillLayer.strokeColor = [UIColor redColor].CGColor;
    
//    backGroundLayer.strokeColor = [UIColor colorWithRed:190/255.0 green:255/255.0 blue:167/255.0 alpha:1.0].CGColor;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.07 target:self selector:@selector(changeProgressValue) userInfo:nil repeats:YES];
}
#pragma mark -子控件约束
-(void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = self.bounds.size.width;
    
    backGroundLayer.frame = self.bounds;
    
    
    backGroundBezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width/2.0f, width/2.0f) radius:(CGRectGetWidth(self.bounds)-2.0)/2.f startAngle:0 endAngle:M_PI*2
                                                       clockwise:YES];
    backGroundLayer.path = backGroundBezierPath.CGPath;
    
//    frontFillLayer.fillColor = [UIColor lightGrayColor].CGColor;
//    frontFillLayer.strokeColor  = [UIColor lightGrayColor].CGColor;

    frontFillLayer.frame = self.bounds;
    
    //设置线宽
    frontFillLayer.lineWidth = 2.0;
    backGroundLayer.lineWidth = 1.0;
    
}
- (void)changeProgressValue{
    self.progressValue = ((int)((self.progressValue * 100.0f) + 1.01) % 100) / 100.0f;
    NSLog(@"progressValue=%f",self.progressValue);
    
    if ([[NSString stringWithFormat:@"%.2f",self.progressValue] isEqualToString:@"0.99"]) {
        _sumCount = _sumCount+1;
        if (_sumCount == 2) {
            NSLog(@"转了两圈");
            [self stop];
        }
    }
}
-(void)setProgressValue:(CGFloat)progressValue{
    _progressValue = progressValue;
    CGFloat width = self.bounds.size.width;
    
    frontFillBezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width/2.0f, width/2.0f) radius:(CGRectGetWidth(self.bounds)-2.0)/2.f startAngle:-0.25*2*M_PI endAngle:(2*M_PI)*progressValue - 0.25*2*M_PI clockwise:YES];
    frontFillLayer.path = frontFillBezierPath.CGPath;
}

-(void)stop{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}


@end
