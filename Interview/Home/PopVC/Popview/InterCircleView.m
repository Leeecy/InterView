//
//  InterCircleView.m
//  Interview
//
//  Created by kiss on 2019/11/29.
//  Copyright © 2019 cl. All rights reserved.
//

#import "InterCircleView.h"
#import <math.h>
#import <QuartzCore/QuartzCore.h>
#define SQR(x)            ( (x) * (x) )
#define ToDeg(rad)        ( (180.0 * (rad)) / M_PI )

#define   degreesToRadians(degrees)  ((M_PI * degrees)/ 180)

@interface InterCircleView(){
    CGFloat radius;
}
@property(assign,nonatomic)CGFloat imgWidth;
@property(assign,nonatomic)CGFloat lineWidth;
@property(assign,nonatomic)CGFloat startAngle;
@property(assign,nonatomic)CGFloat endAngle;
@property(strong,nonatomic)UIImageView *imagev;
@property(assign,nonatomic)CGFloat maxY;

@end

@implementation InterCircleView

-(id)initWithFrame:(CGRect)frame lineWidth:(CGFloat)lineWidth  circleAngle:(CGFloat)circleAngle imageName:(NSString *)imageName imageWidth:(CGFloat)imgWidth{
    if ([super initWithFrame:frame]) {
        // 线宽
        _lineWidth = lineWidth;
        self.imgWidth = imgWidth;
//        _angle = 100;
        // 半径
        radius = (self.frame.size.width -10)/2 - _lineWidth/2 - _lineWidth*imgWidth;
        // 圆起点（角度）
        self.startAngle = -((circleAngle - 180)/2 + 180);
        // 圆终点 (角度)
        self.endAngle = (circleAngle - 180)/2;
        self.angle = self.startAngle;
        self.imagev.image = [UIImage imageNamed:imageName];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //1.绘制灰色的背景
    CGContextAddArc(context, self.frame.size.width/2, self.frame.size.height/2, radius, degreesToRadians(self.startAngle),degreesToRadians(self.endAngle) , 0);
    [[UIColor colorWithHexString:@"#E8E8E8"] setStroke];
    CGContextSetLineWidth(context, _lineWidth);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextDrawPath(context, kCGPathStroke);
    
    // 设置线宽
    CGContextSetLineWidth(context, _lineWidth);
    // 设置画笔颜色
    //    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    //绘制圆弧（这里终点使用的是_angle所以效果图你看到的是一半圆弧，如果使用self.endAngle就是全部了）
    CGContextAddArc(context, self.frame.size.width/2, self.frame.size.height/2,radius,degreesToRadians(self.startAngle), degreesToRadians(self.angle), 0);
    // 设置线条端点为圆角
    CGContextSetLineCap(context, kCGLineCapRound);
    
    [[UIColor colorWithHexString:@"#F48E36"] setStroke];
    CGContextDrawPath(context, kCGPathStroke);
    
    
    //使用rgb颜色空间
//    CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
    
    /*指定渐变色
     space:颜色空间
     components:颜色数组,注意由于指定了RGB颜色空间，那么四个数组元素表示一个颜色（red、green、blue、alpha），
     如果有三个颜色则这个数组有4*3个元素
     locations:颜色所在位置（范围0~1），这个数组的个数不小于components中存放颜色的个数
     count:渐变个数，等于locations的个数
     */
//    CGFloat compoents[12]={
//        248.0/255.0,86.0/255.0,86.0/255.0,1,
//        249.0/255.0,127.0/255.0,127.0/255.0,1,
//        1.0,1.0,1.0,1.0
//    };
//    CGFloat locations[3]={0,0.3,1.0};
//    CGGradientRef gradient= CGGradientCreateWithColorComponents(colorSpace, compoents, locations, 3);
//
//    //释放颜色空间
//    CGColorSpaceRelease(colorSpace);
//    colorSpace = NULL;
//
//    // ----------以下为重点----------
//    // 3. "反选路径"
//    // CGContextReplacePathWithStrokedPath
//    // 将context中的路径替换成路径的描边版本，使用参数context去计算路径（即创建新的路径是原来路径的描边）。用恰当的颜色填充得到的路径将产生类似绘制原来路径的效果。你可以像使用一般的路径一样使用它。例如，你可以通过调用CGContextClip去剪裁这个路径的描边
//    CGContextReplacePathWithStrokedPath(context);
//    // 剪裁路径
//    CGContextClip(context);
//
//
//    // 用渐变色填充(吗的，竟然这句话解决了渐变色的问题,艹，艹，艹)
//
//    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, rect.size.height / 2), CGPointMake(rect.size.width, rect.size.height / 2), 0);
//    // 释放渐变色
//    CGGradientRelease(gradient);
    
    
    self.maxY = [self pointFromAngle:self.startAngle].y;

    
    //3.绘制拖动小块
    CGPoint handleCenter =  [self pointFromAngle: (self.angle)];
    CGContextSetShadowWithColor(context, CGSizeMake(0, 0), _imgWidth,[UIColor colorWithHexString:@"#A6461C"].CGColor);
    [[UIColor whiteColor] setStroke];
    CGContextSetLineWidth(context, _lineWidth*_imgWidth);
    CGContextAddEllipseInRect(context, CGRectMake(handleCenter.x, handleCenter.y, _lineWidth*_imgWidth, _lineWidth*_imgWidth));
    CGContextDrawPath(context, kCGPathStroke);
}

-(CGPoint)pointFromAngle:(int)angleInt{
    //中心点
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2 - _lineWidth*_imgWidth/2 , self.frame.size.height/2 - _lineWidth *_imgWidth/2);
    
    //根据角度得到圆环上的坐标
    CGPoint result;
    result.y = round(centerPoint.y + radius * sin(degreesToRadians(angleInt))) ;
    result.x = round(centerPoint.x + radius * cos(degreesToRadians(angleInt)));
    return result;
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event{
    return YES;
}



#pragma mark - 解决了点击圆环直接跳转到相应角度（对应相应）的问题
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    
    //集合转数组,其实只有一个对象
    NSArray *arr = [touches allObjects];
    UITouch *touch = arr[0];
    CGPoint lastPoint = [touch locationInView:self];
//    NSLog(@"%@",NSStringFromCGPoint(lastPoint));
//    NSLog(@"%d",touches.count);
    
    // 非 线性范围 则不可点击
    CGFloat deltaX = lastPoint.x - self.frame.size.width/2;
    CGFloat deltaY = lastPoint.y - self.frame.size.width/2;
    //sqrt 平方根 还记得勾股定理吗？手动微笑
    CGFloat distanceBetweenPoints = sqrt(deltaX*deltaX + deltaY*deltaY);
    //    NSLog(@"======%f",distanceBetweenPoints);
    //设置可触发点击或者滑动事件的范围
    if (distanceBetweenPoints>= radius - 50 && distanceBetweenPoints <= radius+ 20) {
        [self movehandle:lastPoint];
    }
    
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];

}

#pragma mark - 根据点击或者滑动获取角度（弧度）
-(void)movehandle:(CGPoint)lastPoint{
    
    //获得中心点
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2,
                                      self.frame.size.height/2);
    
    //计算中心点到任意点的角度
    float currentAngle = AngleFromNorth(centerPoint,
                                        lastPoint,
                                        NO);
    //浮点转整形
    int angleInt = floor(currentAngle);
//    NSLog(@"%d",angleInt);

    //保存新角度
    if (angleInt >= 0 && angleInt <= self.endAngle) {
        self.angle = angleInt;
    }else if (angleInt >= 360+self.startAngle && angleInt <= 360){
        self.angle = -(360 - angleInt);
    }else if (angleInt >= self.endAngle && angleInt <= 360+self.startAngle){
        //这部分(非圆弧范围)不做处理
    }
    if (self.angleChange) {
        self.angleChange(angleInt);
    }
    
    //重新绘制
//    [self setNeedsDisplay];
}
#pragma mark - 持续滑动触发事件
-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super continueTrackingWithTouch:touch withEvent:event];
    //获取触摸点
    CGPoint lastPoint = [touch locationInView:self];
//    NSLog(@"%@",NSStringFromCGPoint(lastPoint));
    // 超出圆弧部分直接返回NO(解决滑动超出圆弧范围的异常问题)
    if (lastPoint.y >= self.maxY) {
        return NO;
    }
    // 非 money图片 不可点击
    CGFloat deltaX = lastPoint.x - self.frame.size.width/2;
    CGFloat deltaY = lastPoint.y - self.frame.size.width/2;
    CGFloat distanceBetweenPoints = sqrt(deltaX*deltaX + deltaY*deltaY);
    //    NSLog(@"======%f",distanceBetweenPoints);
    
    if (distanceBetweenPoints>= radius - 50 && distanceBetweenPoints <= radius+ 20) {
        //使用触摸点来移动小块
        [self movehandle:lastPoint];
    }
    
    //发送值改变事件
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    return YES;
}

#pragma mark - 从苹果是示例代码clockControl中拿来的函数,计算中心点到任意点的角度(弧度)
static inline float AngleFromNorth(CGPoint p1, CGPoint p2, BOOL flipped) {
    CGPoint v = CGPointMake(p2.x-p1.x,p2.y-p1.y);
    float vmag = sqrt(SQR(v.x) + SQR(v.y)), result = 0;
    v.x /= vmag;
    v.y /= vmag;
    double radians = atan2(v.y,v.x);
    result = ToDeg(radians);
    return (result >=0  ? result : result + 360.0);
}


@end
