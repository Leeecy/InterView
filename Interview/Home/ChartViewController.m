//
//  ChartViewController.m
//  Interview
//
//  Created by kiss on 2019/8/2.
//  Copyright © 2019 cl. All rights reserved.
//

#import "ChartViewController.h"
#import "GQYVerticalSlider.h"
#import "KSChartView.h"

@interface ChartViewController ()<KSChartViewDelegate>
@property(strong,nonatomic)KSChartView *chartV ;
@property(assign,nonatomic)CGFloat value5;
@property(assign,nonatomic)CGFloat value4;
@property(assign,nonatomic)CGFloat value3;
@property(assign,nonatomic)CGFloat value2;
@property(assign,nonatomic)CGFloat value1;
@property(strong,nonatomic)NSMutableArray *values;

@end

@implementation ChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _value1 = 80;
    _value2 = 250;
    _value3 = 80;
    _value4 = 120;
    _value5 = 160;
    [self drawChart];
    

    GQYVerticalSlider *slider = [[GQYVerticalSlider alloc]initWithFrame:CGRectMake(100, 200, 10, 200)];
    //    [slider sizeToFit];
    [self.view addSubview:slider];
    slider.titleStyle = TopTitleStyle;
    slider.maximumValue = 300;
    slider.minimumValue = 0;

    
    slider.touchSliderValueChange = ^(CGFloat value,BOOL isEnd,NSInteger tag) {
        NSLog(@"%f",value);
        slider.sliderValueLabel.text = [NSString stringWithFormat:@"%.f%%",value];
    };
    [slider setValue:88 animated:YES];
    
    
    UISlider *slider1 = [[UISlider alloc]init];
    slider1.frame = CGRectMake(100, 100, 100, 20);
    slider1.maximumValue =300;
    slider1.minimumValue = 0;
    slider1.value = 40;
    slider1.maximumTrackTintColor = [UIColor blueColor];
    slider1.minimumTrackTintColor = [UIColor redColor];
    [slider1 addTarget:self action:@selector(sliderValue:) forControlEvents:(UIControlEventValueChanged)];
    [self.view addSubview:slider1];
}

-(void)drawChart{
    [self.chartV removeFromSuperview];
    self.values = [[NSMutableArray alloc] initWithObjects:@(_value1), @(_value2), @(_value3),@(_value4),@(_value5),nil];
    
    //    [self.chartV removeFromSuperview];
    
    self.chartV = [[KSChartView alloc]initWithFrame:CGRectMake(50, 300, 340, 300) values:self.values curveColor:[UIColor greenColor] curveWidth:4.0 topGradientColor:[UIColor redColor] bottomGradientColor:[UIColor whiteColor] minY:1 maxY:1 topPadding:300];
    self.chartV.delegate = self;
    [self.view addSubview:self.chartV];
}

-(IBAction)sliderValue:(UISlider*)sender{
    NSLog(@"value ---%f",sender.value);
    _value1 = sender.value;
    
    [self drawChart];
}
//-(void)setCircle{
//    KSCircleView *dialView = [[KSCircleView alloc] initWithFrame:CGRectMake(40,140, 275, 275)];
//    dialView.minNum = 17;
//    dialView.maxNum = 40;
//    dialView.progress = 0.0;
//
//    //    [self.view addSubview:dialView];
//
//    self.circleView = [[SXCircleView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - 219/2, 100, 219, 219) lineWidth:5 circleAngle:240 imageName:@"qian"];
//
//    [self.view addSubview:self.circleView];
//    [self.circleView addTarget:self action:@selector(newValue:) forControlEvents:UIControlEventValueChanged];
//}
//- (void) newValue:(SXCircleView*)slider{
//    NSLog(@"newValue:%d",slider.angle);
//}

-(void)sendValue:(CGFloat)value andTag:(NSInteger)tag{
    NSLog(@"vale---%f tag---%ld",value,tag);
    
    [self.chartV.subView removeFromSuperview];
    //    self.chartV.layer.hidden = YES;
    [self.values replaceObjectAtIndex:tag withObject:@(value)];
    NSArray *sliders = [NSArray arrayWithArray:self.values];
    
    //    self.chartV = [[KSChartView alloc]initWithFrame:CGRectMake(50, 300, 340, 300) values:sliders curveColor:[UIColor greenColor] curveWidth:4.0 topGradientColor:[UIColor redColor] bottomGradientColor:[UIColor whiteColor] minY:1 maxY:1 topPadding:300];
    
    [self.chartV drawGraphWithValues:sliders minY:100/100 maxY:1.0 topPadding:300.0 curveColor:[UIColor greenColor] curveWidth:3.0 topGradientColor:[UIColor redColor] bottomGradientColor:[UIColor whiteColor]];
    
    //    self.chartV.delegate = self;
    //    [self.view addSubview:self.chartV];
}


@end
