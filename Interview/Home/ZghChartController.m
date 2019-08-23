//
//  ZghChartController.m
//  StudyiOSDemo
//
//  Created by zhouguanghui on 2019/7/29.
//  Copyright © 2019 zhouguanghui. All rights reserved.
//

#import "ZghChartController.h"
#import "JTChartView.h"

@interface ZghChartController ()<sliderProtocol>

@property (nonatomic, strong) JTChartView *chartView;

@property(nonatomic,strong)UIView *baseView;

@property (nonatomic, strong) UIColor *curveColor;
@property (nonatomic, strong) UIColor *gradientColorOne;
@property (nonatomic, strong) UIColor *gradientColorTwo;

@property(nonatomic,strong)NSMutableArray *sliderArr;



@property(nonatomic,strong)NSArray *dataArray;

@end

@implementation ZghChartController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.sliderArr = [[NSMutableArray alloc] initWithObjects:@(0), @(200), @(50), @(20), @(90) ,nil];
    self.curveColor = [UIColor colorWithRed:0.204 green:0.286 blue:0.369 alpha:0.5];
    self.gradientColorOne = [UIColor colorWithRed:0.102 green:0.737 blue:0.612 alpha:0.5];
    self.gradientColorTwo = [UIColor colorWithRed:0.18 green:0.8 blue:0.443 alpha:0.5];

    self.baseView  = [[UIView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-100)];
//    self.baseView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.baseView];
//    _dataArray = @[@"基础动画",@"图层",@"核心动画"];
    
//    [self loadBtnWithArr:_dataArray andColCount:3];
    
    
}


-(void)loadBtnWithArr:(NSArray *)dataArr andColCount:(NSInteger )colcount{
    
    CGFloat space = 20;
    
    for (NSInteger i = 0; i<dataArr.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:_dataArray[i] forState:UIControlStateNormal];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 5;
        btn.backgroundColor = [UIColor redColor];
        [self.view addSubview:btn];
        
        //所在行
        NSInteger row = i / colcount;
        //所在列
        NSInteger col = i % colcount;
        
//        btn.frame = CGRectMake(space + (BTN_WIDTH + space)*col, NAVIGATION_BAR_HEIGHT +20 +(BTN_HEIGHT + space)*row, BTN_WIDTH, BTN_HEIGHT);
    }
    
}


-(void)btnClick:(UIButton *)sender{
    
    if ([sender.titleLabel.text isEqualToString:_dataArray[0]]) {
        //
//        CoreAnimationController *coreVC = [[CoreAnimationController alloc]init];
//        coreVC.title = @"core";
//        [self.navigationController pushViewController:coreVC animated:YES];
        
        
    }else if ([sender.titleLabel.text isEqualToString:_dataArray[1]]){
        //
      
    }else if ([sender.titleLabel.text isEqualToString:_dataArray[2]]){
        //
       
    }
    
}



-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self drawGraph];
}

#pragma mark - Example
- (void)drawGraph {
    
    // Create baseView for JTChartView
    self.baseView.layer.masksToBounds = true;
    self.baseView.layer.cornerRadius = 3.0;
    self.baseView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.15];
    
    // Base method
    self.chartView = [[JTChartView alloc] initWithFrame:self.baseView.bounds values:self.sliderArr curveColor:self.curveColor curveWidth:3.0 topGradientColor:self.gradientColorOne bottomGradientColor:self.gradientColorTwo minY:90.0/100 maxY:1.0 topPadding:200.0];
    self.chartView.delegate = self;
    [self.baseView addSubview:self.chartView];
}

-(void)sendValue:(UISlider *)slider{
   
    CGFloat value = slider.value;
//    NSArray *arr;
//    if (slider.tag == 2) {
//     arr = [[NSArray alloc] initWithObjects:@(20), @(100), @(50), @(20), @(90) ,nil];
//    }else if (slider.tag == 3){
//      arr = [[NSArray alloc] initWithObjects:@(100), @(60), @(100), @(20), @(90) ,nil];
//    }
    
    [self.chartView.subView removeFromSuperview];
    NSLog(@"subview---%@",self.chartView.subView);
//    [self.sliderArr insertObject:@(value) atIndex:slider.tag-1];
    [self.sliderArr replaceObjectAtIndex:slider.tag-1 withObject:@(value)];
     NSLog(@"%@",self.sliderArr);
    
    NSArray *sliders = [NSArray arrayWithArray:self.sliderArr];
    [self.chartView drawGraphWithValues:sliders minY:90.0/100 maxY:1.0 topPadding:200.0 curveColor:self.curveColor curveWidth:3.0 topGradientColor:self.gradientColorOne bottomGradientColor:self.gradientColorTwo];
    
   
}



@end
