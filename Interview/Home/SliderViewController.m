//
//  SliderViewController.m
//  Interview
//
//  Created by kiss on 2019/12/7.
//  Copyright © 2019 cl. All rights reserved.
//

#import "SliderViewController.h"
#import "YTSliderView.h"
@interface SliderViewController ()<YTSliderViewDelegate>

@end

@implementation SliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
//    YTSliderSetting *setting_v = [YTSliderSetting defaultSetting];
//    YTSliderView *slider_v = [[YTSliderView alloc]initWithFrame:CGRectMake(100, 400, 120, 30) setting:setting_v];
//    slider_v.currentPercent = 0.2;
//    slider_v.tag = 1000;
//    slider_v.delegate = self;
//    [self.view addSubview:slider_v];
    
    
//    YTSliderSetting *setting = [YTSliderSetting defaultSetting];
//    YTSliderView *slider_a = [[YTSliderView alloc]initWithFrame:CGRectMake(100, 300, 120, 20) setting:setting];
//    slider_a.anchorPercent = 0.5;
//    slider_a.tag = 3000;
//    slider_a.delegate = self;
//    [self.view addSubview:slider_a];
//
//
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
