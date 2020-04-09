//
//  TeviChartViewController.m
//  Interview
//
//  Created by kiss on 2019/12/26.
//  Copyright © 2019 cl. All rights reserved.
//

#import "TeviChartViewController.h"
#import "CLChartView.h"
@interface TeviChartViewController ()<CLChartViewDelegate>
@property(strong,nonatomic)CLChartView *chartV ;
@property(nonatomic,strong)UIView *chartBgV;//
@property(strong,nonatomic)NSMutableArray *values;
@end

@implementation TeviChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.values = [[NSMutableArray alloc] initWithObjects:@(8), @(292), @(50), @(20), @(90) ,@(270), @(100),nil];
    [self drawGraph];
}

- (void)drawGraph {
    [self.chartV removeFromSuperview];
    [self.chartBgV removeFromSuperview];
    // Base method 50 340 topGradientColor 7a7a7a
    
    CGFloat heightV = iPhoneX ? 150 :80;
//    self.chartBgV = [[UIView alloc] initWithFrame:CGRectMake(chartVOfferX-10, SafeAreaTopHeight + heightV, SCREEN_WIDTH, 300)];
//    [self.view addSubview:self.chartBgV];
    self.chartV = [[CLChartView alloc] initWithFrame:CGRectMake(chartVOfferX, SafeAreaTopHeight + heightV, ScreenWidth, 300) values:self.values curveColor:[UIColor colorFromHexStr:@"#838383"] curveWidth:3.0 topGradientColor:[UIColor colorWithHexString:@"#777777"] bottomGradientColor:[UIColor colorFromHexStr:@"#191919"] minY:100/100 maxY:1.0 topPadding:300.0];
    self.chartV.delegate = self;
    [self.view addSubview:self.chartV];
}
 

@end
