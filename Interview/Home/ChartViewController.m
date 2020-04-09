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
#import "KSEqSlider.h"
@interface ChartViewController ()<KSChartViewDelegate>
@property(strong,nonatomic)KSChartView *chartV ;

@property(strong,nonatomic)NSMutableArray *values;
@property(nonatomic,strong)KSEqSlider *slider;
@end

@implementation ChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSlider];
    self.view.backgroundColor = [UIColor whiteColor];
    [self drawChart];
}

-(void)setupSlider{
    CGFloat sliderH = 1;
   CGFloat sliderW = 300;
   CGFloat sliderX = 50;
   CGFloat sliderY = 100;
   self.slider = [[KSEqSlider alloc] init];

   CGFloat value = 0.5;
   self.slider.isShowTitle = YES;
    self.slider.titleStyle = KSEqTopTitleStyle;
   self.slider.value = value;

//   self.slider.delegate = self;
//        [self.slider addTarget:self action:@selector(_sliderValueDidChanged:) forControlEvents:UIControlEventValueChanged];
   [self.view addSubview:self.slider];
    self.slider.frame = CGRectMake(sliderX, sliderY, sliderW, sliderH);
}

-(void)drawChart{
    [self.chartV removeFromSuperview];
    self.values = [[NSMutableArray alloc] initWithObjects:@(0), @(300), @(50), @(20), @(90) ,@(270), @(100),nil];
    
    //    [self.chartV removeFromSuperview];
    
    self.chartV = [[KSChartView alloc]initWithFrame:CGRectMake(30, 200, ScreenWidth,300) values:self.values curveColor:[UIColor greenColor] curveWidth:4.0 topGradientColor:[UIColor redColor] bottomGradientColor:[UIColor whiteColor] minY:1 maxY:1 topPadding:300];
    self.chartV.delegate = self;
    [self.view addSubview:self.chartV];
    
//    self.chartV.backgroundColor = [UIColor orangeColor];
}

-(IBAction)sliderValue:(UISlider*)sender{
    NSLog(@"value ---%f",sender.value);
    
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
