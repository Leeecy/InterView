//
//  KSChartView.m
//  TestCircle
//
//  Created by cl on 2019/7/29.
//  Copyright © 2019 KSB. All rights reserved.
//

#import "KSChartView.h"

#import "KSEqSlider.h"
#define xViewWidth 300 //没用到
#define xOffWidth 50 //没用到
#define contentWidth self.frame.size.width * 7/8
#define sliderWidth 320
@interface KSChartView()<KSEqSliderDelegate>
@property(strong,nonatomic)NSMutableArray *xArray;
@property(strong,nonatomic)NSMutableArray *yArray;


@property (nonatomic, strong) NSArray *values;
@property (nonatomic, strong) UIColor *curveColor;
@property (nonatomic, assign) CGFloat curveWidth;
@property (nonatomic, strong) UIColor *topGradientColor;
@property (nonatomic, strong) UIColor *bottomGradientColor;
@property (nonatomic, assign) CGFloat minY;
@property (nonatomic, assign) CGFloat maxY;
@property (nonatomic, assign) CGFloat topPadding;
@property(strong,nonatomic)UIImageView *slideImg;
@property(nonatomic,strong) KSEqSlider *slider;

@end

@implementation KSChartView
-(instancetype)initWithFrame:(CGRect)frame values:(NSArray *)values curveColor:(UIColor *)curveColor curveWidth:(CGFloat)curveWidth topGradientColor:(UIColor *)topGradientColor bottomGradientColor:(UIColor *)bottomGradientColor minY:(CGFloat)minY maxY:(CGFloat)maxY topPadding:(CGFloat)topPadding{
    self = [super initWithFrame:frame];
    // NOTIFICATIONS
//    [self createObservers];
    if (values.count < 1) {
        return self;
    }
//    self.x = frame.origin.x -8;
    // DEFAULTS
    UIColor *curveColorDefault = curveColor ? curveColor : [UIColor blackColor];
    CGFloat curveWidthDefault = curveWidth ? curveWidth : 2.0;
    UIColor *topGradientColorDefault = topGradientColor ? topGradientColor : [UIColor redColor];
    UIColor *bottomGradientColorDefault = bottomGradientColor ? bottomGradientColor : [UIColor orangeColor];
    CGFloat minYDefault = minY ? minY : 0;
    CGFloat maxYDefault = maxY ? maxY : 1.0;
    CGFloat topPaddingDefault = topPadding ? topPadding : 0;
    
    // STORE
    _values = values;
    [self makeDataX];
//    [self setupBtnWithArr:values andTop:topPaddingDefault];
    _curveColor = curveColorDefault;
    _curveWidth = curveWidthDefault;
    _topGradientColor = topGradientColorDefault;
    _bottomGradientColor = bottomGradientColorDefault;
    _minY = minYDefault;
    _maxY = maxYDefault;
    _topPadding = topPaddingDefault;
    
    self.subView = [[UIView alloc]initWithFrame:self.bounds];
//    [self addSubview:self.subView];
//    [self insertSubview:self.subView atIndex:0];
    [self drawGraphWithValues:values inView:self minY:minYDefault maxY:maxYDefault topPadding:topPaddingDefault curveColor:curveColorDefault curveWidth:curveWidthDefault topGradientColor:topGradientColorDefault bottomGradientColor:bottomGradientColorDefault];
    [self setupBtnWithArr:values andTop:topPaddingDefault];
    
    return self;
}

//MARK:-创建线上的点
-(void)setupBtnWithArr:(NSArray*)arr andTop:(CGFloat)topPad{
    if (self.slider) {
        [self.slider removeFromSuperview];
    }
    CGFloat width = contentWidth /(arr.count -1);
     CGFloat topH = iPhoneX ?(SafeAreaTopHeight + 130):189;
 
    for (int i =0; i < self.values.count; i++) {
            CGFloat sliderH = EQSliderHeight;
            CGFloat sliderW = 5;
            CGFloat sliderX = width *i;
            CGFloat sliderY = 0;
            self.slider = [[KSEqSlider alloc] init];
            self.slider.transform = CGAffineTransformMakeRotation(-M_PI_2);
            CGFloat value = [arr[i] intValue];
            self.slider.isShowTitle = YES;
        self.slider.titleStyle = KSEqTopTitleStyle;
            self.slider.value = value;
            self.slider.tag = i;
            self.slider.delegate = self;
    //        [self.slider addTarget:self action:@selector(_sliderValueDidChanged:) forControlEvents:UIControlEventValueChanged];
            [self addSubview:self.slider];
             self.slider.frame = CGRectMake(sliderX, sliderY, sliderW, sliderH);
        }
    
   
}

-(void)sliderMoveEnd:(CGFloat)slider andTag:(NSInteger)tag{
    NSLog(@"%.0f===%ld",slider,tag);
    //滑动结束时才设置EQ的值
    if ([self.delegate respondsToSelector:@selector(moveEnd:tag:)]) {
        [self.delegate moveEnd:slider tag:tag];
    }
}

- (void)drawGraphWithValues:(NSArray *)values minY:(CGFloat)minY maxY:(CGFloat)maxY topPadding:(CGFloat)topPadding curveColor:(UIColor *)curveColor curveWidth:(CGFloat)curveWidth topGradientColor:(UIColor *)topGradientColor bottomGradientColor:(UIColor *)bottomGradientColor{

    self.subView = [[UIView alloc]initWithFrame:self.bounds];
    [self addSubview:self.subView];
    [self insertSubview:self.subView atIndex:0];
    for (CALayer *layer in self.layer.sublayers) {
        if ([layer isKindOfClass:[CAGradientLayer class]] || [layer isKindOfClass:[CAShapeLayer class]]) {
            [layer setHidden:YES];
        }
    }
    
    // CREATE CGPOINTS
    NSArray *points = [self pointsFromValues:values withinView:self.subView minY:minY maxY:maxY topPadding:topPadding];
    // CREATE THE CURVE
    UIBezierPath *curve = [self quadCurvedPathWithPoints:points];
    
    // CREATE LAYER WITH CURVE
    CAShapeLayer *curveLayer = [self createLayerWithCurve:curve color:curveColor width:curveWidth];
    
    // CREATE GRADIENT LAYER
    CAGradientLayer *gradientLayer = [self createGradientWithTopColor:topGradientColor bottomColor:bottomGradientColor inView:self.subView];
    
    // CREATE MASK
    CAShapeLayer *maskLayer = [self createMaskWithCurve:curve withinView:self.subView];
    
    // APPLY IT
    gradientLayer.mask = maskLayer;
    [self.subView.layer addSublayer:gradientLayer];
    [self.subView.layer addSublayer:curveLayer];
}

- (void)drawGraphWithValues:(NSArray *)values inView:(UIView *)superview minY:(CGFloat)minY maxY:(CGFloat)maxY topPadding:(CGFloat)topPadding curveColor:(UIColor *)curveColor curveWidth:(CGFloat)curveWidth topGradientColor:(UIColor *)topGradientColor bottomGradientColor:(UIColor *)bottomGradientColor {
    
    // CREATE CGPOINTS
    NSArray *points = [self pointsFromValues:values withinView:superview minY:minY maxY:maxY topPadding:topPadding];
    UIBezierPath *curve = [self quadCurvedPathWithPoints:points];
    //生成渐变色
    CAGradientLayer *gradientLayer = [self createGradientWithTopColor:topGradientColor bottomColor:bottomGradientColor inView:superview];
    // CREATE LAYER WITH CURVE
    CAShapeLayer *curveLayer = [self createLayerWithCurve:curve color:curveColor width:curveWidth];
    
    CAShapeLayer *maskLayer = [self createMaskWithCurve:curve withinView:superview];
    
    gradientLayer.mask = maskLayer;
    [superview.layer addSublayer:gradientLayer];
    [superview.layer addSublayer:curveLayer];
    
//    [self bringSubviewToFront:self.slider];
    
}

#pragma mark - Layers
- (CAShapeLayer *)createLayerWithCurve:(UIBezierPath *)curve color:(UIColor *)color width:(CGFloat)width {
    
    CAShapeLayer *shapeLayer = [CAShapeLayer new];
    shapeLayer.path = [curve CGPath];
    
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = width;
    shapeLayer.fillRule = kCAFillRuleEvenOdd;
    [shapeLayer setLineCap:kCALineCapRound];
    
    return shapeLayer;
}
- (CAShapeLayer *)createMaskWithCurve:(UIBezierPath *)curve withinView:(UIView *)superview {
    
    CAShapeLayer *mask = [CAShapeLayer new];
    mask.frame = superview.bounds;
    [curve addLineToPoint:CGPointMake(contentWidth, superview.frame.size.height)];
    [curve addLineToPoint:CGPointMake(0, superview.frame.size.height)];
    [curve closePath];
    mask.path = curve.CGPath;
    
    return mask;
}

- (CAGradientLayer *)createGradientWithTopColor:(UIColor *)topColor bottomColor:(UIColor *)bottomColor inView:(UIView *)superview {
    
    CAGradientLayer *gradientLayer = [CAGradientLayer new];
    gradientLayer.frame = superview.bounds;
    gradientLayer.colors = @[(id)topColor.CGColor,
                             (id)bottomColor.CGColor];
    return gradientLayer;
}


- (UIBezierPath *)quadCurvedPathWithPoints:(NSArray *)points {
    UIBezierPath *path = [UIBezierPath bezierPath];
    NSValue *value = points[0];
    CGPoint p1 = [value CGPointValue];
    [path moveToPoint:p1];
    
    if (points.count == 2) {
        value = points[1];
        CGPoint p2 = [value CGPointValue];
        [path addLineToPoint:p2];
        return path;
    }
    
    for (NSUInteger i = 1; i < points.count; i++) {
        value = points[i];
        CGPoint p2 = [value CGPointValue];
        
        CGPoint midPoint = [self midPointForPointOne:p1 pointTwo:p2];
        [path addQuadCurveToPoint:midPoint controlPoint:[self controlPointForPointOne:midPoint pointTwo:p1]];
        [path addQuadCurveToPoint:p2 controlPoint:[self controlPointForPointOne:midPoint pointTwo:p2]];
        p1 = p2;
    }
    
    return path;
}
- (CGPoint)midPointForPointOne:(CGPoint)p1 pointTwo:(CGPoint)p2 {
    
    return CGPointMake((p1.x + p2.x) / 2, (p1.y + p2.y) / 2);
}

- (CGPoint)controlPointForPointOne:(CGPoint)p1 pointTwo:(CGPoint)p2 {
    
    CGPoint controlPoint = [self midPointForPointOne:p1 pointTwo:p2];
    CGFloat diffY = fabs(p2.y - controlPoint.y);
    
    if (p1.y < p2.y) {
        controlPoint.y += diffY;
        
    } else if (p1.y > p2.y) {
        controlPoint.y -= diffY;
    }
    
    return controlPoint;
}

- (NSMutableArray *)pointsFromValues:(NSArray *)values withinView:(UIView *)superview minY:(CGFloat)minY maxY:(CGFloat)maxY topPadding:(CGFloat)topPadding {
    
    NSMutableArray *points = [NSMutableArray new];
    
    for (int i = 0; i < values.count; i++) {
        CGFloat gap = fabs(contentWidth / MAX(values.count - 1, 0));
        CGFloat pX = i * gap;
        CGFloat verticalMin = superview.frame.size.height * minY;
        CGFloat verticalMax = superview.frame.size.height * maxY;
        // Curve also needs a floor
        CGFloat pY = (superview.frame.size.height + topPadding) - (((([[values objectAtIndex:i] floatValue] / verticalMax) * verticalMin)) + verticalMin);
        pY = isnan(pY) ? 0.0 : pY; //isan 一个数是无穷
        
        CGPoint p = CGPointMake(pX, pY);
        [points addObject:[NSValue valueWithCGPoint:p]];
    }
    
    return points;
}

-(void)makeDataX{
    self.xArray = [NSMutableArray arrayWithObjects:@"80",@"250",@"500",@"1K",@"3K",@"7K",@"10K", nil];
    self.yArray = [NSMutableArray arrayWithObjects:@"30",@"100",@"500",@"1K",@"10K", nil];
    //    self.pointArray = [NSMutableArray arrayWithObjects:@"30",@"100",@"500",@"1K",@"10K", nil];
    
    [self makeX];
}

//-(void)drawRect:(CGRect)rect{
//    self.xArray = [NSMutableArray arrayWithObjects:@"30",@"60",@"250",@"500",@"1K", nil];
//    self.yArray = [NSMutableArray arrayWithObjects:@"30",@"100",@"500",@"1K",@"10K", nil];
////    self.pointArray = [NSMutableArray arrayWithObjects:@"30",@"100",@"500",@"1K",@"10K", nil];
//
//    [self makeX];
//
////    [self makeY];
//
//}
-(void)makeX{
    UIView *view = [UIView new];
//    [self addSubview:view];
    view.frame = CGRectMake(0, 300, self.width, 1);
    view.backgroundColor = [UIColor lightGrayColor];
    CGFloat h = self.width / self.xArray.count;
    for (int i = 0; i < self.xArray.count; i++) {
        CGFloat gap = fabs(contentWidth / MAX(self.xArray.count - 1, 0));
        CGFloat pX = i * gap;
        
        UILabel *label = [UILabel new];
        label.text = self.xArray[i];
        [self addSubview:label];
        label.font = [UIFont systemFontOfSize:17];
        label.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
        label.textAlignment = NSTextAlignmentCenter;
        label.frame = CGRectMake(  i * h , 300 + 20, 40, 20);
        label.centerX = pX;
        
        UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake( i* h , 0, 1, 300)];
        lineV.centerX = pX;
        lineV.backgroundColor = [[UIColor colorWithHexString:@"#232323"] colorWithAlphaComponent:0.6];
        [self addSubview:lineV];
    }
    
    
}
-(void)makeY{
    UIView *view = [UIView new];
    [self addSubview:view];
    view.frame = CGRectMake(35, 0, 1, xViewWidth);
    view.backgroundColor = [UIColor lightGrayColor];
    CGFloat h = xViewWidth / self.yArray.count;
    for (int i = 0; i < self.yArray.count; i++) {
        UILabel *label = [UILabel new];
        label.text = self.yArray[i];
        [self addSubview:label];
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentRight;
        label.frame = CGRectMake(0, i * h, 40, 20);
    }
}
- (CGFloat)maxValueInArray:(NSArray *)values {
    
    CGFloat max = CGFLOAT_MIN;
    
    for (int i = 0; i < values.count; i++) {
        CGFloat value = [[values objectAtIndex:i] floatValue];
        if (value > max) {
            max = value;
        }
    }
    return max;
}

- (CGFloat)minValueInArray:(NSArray *)values {
    
    CGFloat min = CGFLOAT_MAX;
    
    for (int i = 0; i < values.count; i++) {
        CGFloat value = [[values objectAtIndex:i] floatValue];
        if (value < min) {
            min = value;
        }
    }
    return min;
}

#pragma mark - Orientation handle
- (void)createObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationDidChange) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)orientationDidChange {
    if (_values.count < 1) {
        return;
    }
    
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    CGRect f = self.superview.bounds;
    
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft || [[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight) {
        f.size = CGSizeMake(f.size.height, f.size.width);
    } else {
        f.size = CGSizeMake(f.size.width, f.size.height);
    }
    self.frame = f;
    
    [self drawGraphWithValues:_values inView:self minY:_minY maxY:_maxY topPadding:_topPadding curveColor:_curveColor curveWidth:_curveWidth topGradientColor:_topGradientColor bottomGradientColor:_bottomGradientColor];
}


@end
