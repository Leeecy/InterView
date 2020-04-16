//
//  SliderViewController.m
//  Interview
//
//  Created by kiss on 2019/12/7.
//  Copyright © 2019 cl. All rights reserved.
//

#import "SliderViewController.h"
#import "YTSliderView.h"
#import "BatteryBarView.h"
#import "BatteryView.h"
@interface SliderViewController ()<YTSliderViewDelegate>

@end

@implementation SliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
//    [self testSlider];
//    BatteryBarView *barView = [[BatteryBarView alloc]initWithFrame:CGRectMake(40.f, 160.f, 36, 16)];
//    [self.view addSubview:barView];
    
    BatteryView *battY = [[BatteryView alloc]initWithFrame:CGRectMake(50, 220, 150, 140)];
//    battY.transform = CGAffineTransformMakeRotation(-M_PI*0.5);
    [self.view addSubview:battY];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
   BatteryBarView *barView = self.view.subviews.lastObject;
   barView.batteryPower = [self randomNumber];
   
}
- (NSUInteger)randomNumber{
    return arc4random_uniform(100) + 1;
    
}
-(void)testSlider{
    YTSliderSetting *setting_h = [YTSliderSetting verticalSetting];
    YTSliderView *slider_h = [[YTSliderView alloc]initWithFrame:CGRectMake(100, 100, 10, 400) setting:setting_h];
    slider_h.anchorPercent = 0;
    slider_h.tag = 2000;
    slider_h.delegate = self;
    [self.view addSubview:slider_h];
}

- (void)ytSliderViewDidBeginDrag:(YTSliderView *)view {
    NSLog(@"DidBeginDrag");
}

- (void)ytSliderViewDidEndDrag:(YTSliderView *)view {
    NSLog(@"DidEndDrag");
}

- (void)ytSliderView:(YTSliderView *)view didChangePercent:(CGFloat)percent {
    if(view.tag == 1000) {
        NSLog(@"1000Tag percent:%f",percent);
    }
    else if(view.tag == 2000) {
        NSLog(@"2000Tag percent%f",percent);
    } else if(view.tag == 3000) {
        NSLog(@"3000Tag percent%f",percent);
    }
}

@end
