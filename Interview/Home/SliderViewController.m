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
#import "KSProgressTimeView.h"
#import "PopModel.h"
#import "KSBatteryVertical.h"
@interface SliderViewController ()<YTSliderViewDelegate,KSProgressTimeViewDelegate,alertPopDelegate>
@property (nonatomic ,weak)KSProgressTimeView *progressView;
@property(nonatomic,strong) UILabel *descLab;
@property(nonatomic,strong)UIView *batteryBgV;
@property(nonatomic,strong)UISlider *slider;
@property(nonatomic,assign)int batteryNum;//电池电量
@property(nonatomic,assign)int batteryHeight;//电池高度

@property(nonatomic,strong)KSBatteryVertical *verticalV;
@end

@implementation SliderViewController
-(void)viewWillAppear:(BOOL)animated{
    PopModel *pop = [PopModel sharevView];
    pop.delegate = self;
}
-(void)alertisConnecting{
    NSLog(@"alertisConnecting");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    self.batteryNum = 20;
    self.batteryHeight = self.batteryNum  * 0.5;
    [self setSlider];
    self.verticalV = [[KSBatteryVertical alloc]initWithFrame:CGRectMake(100, 280, 5, 10) num:5];
    [self.view addSubview:self.verticalV];
    
    [PopModel alertWithMessage:@"连接失败" maskType:AlertMaskTypeBlack];
    PopModel *pop = [PopModel sharevView];
    pop.delegate = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [PopModel alertWithDismiss];
    });
//    [self testSlider];
//    BatteryBarView *barView = [[BatteryBarView alloc]initWithFrame:CGRectMake(40.f, 160.f, 36, 16)];
//    [self.view addSubview:barView];
    
//    BatteryView *battY = [[BatteryView alloc]initWithFrame:CGRectMake(50, 220, 150, 140)];
//    battY.transform = CGAffineTransformMakeRotation(-M_PI*0.5);
    BatteryView *battY = [[BatteryView alloc]initWithFrame:CGRectMake(50, 400, 20, 50)];
//    battY.backgroundColor = [UIColor greenColor];
    [self.view addSubview:battY];
    
    CGFloat batteryX =50.5;
    UIView *batteryView = [[UIView alloc]initWithFrame:CGRectMake(batteryX,450 -self.batteryNum*0.5-1, 20-1, self.batteryNum*0.5)];
    batteryView.layer.cornerRadius = 2;
    batteryView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:batteryView];
    self.batteryBgV = batteryView;
    
     KSProgressTimeView *view=[[KSProgressTimeView alloc]initWithFrame:CGRectMake(50, 200, ScreenWidth-50*2, 30)];
     view.layer.borderColor=[UIColor blackColor].CGColor;
    view.layer.borderWidth=2;
    //计时条背景色   timing bar background color
    view.backgroundColor=[UIColor blackColor];
    //计时条颜色     timing bar  color
    view.timeCountColor=[UIColor blackColor];
    view.originTimeFrequency=50;
    view.timeInterval=1;
    view.delegate=self;
    view.totalTimeFrequency=50;
    //计时栏颜色     timing lab  color
    view.timeCountLabColor=[UIColor blackColor];
    [self.view addSubview:view];
    self.progressView =view;
    
    UILabel *descLab=[[UILabel alloc]init];
    descLab.font=[UIFont systemFontOfSize:10];
    descLab.textAlignment=NSTextAlignmentCenter;
    descLab.textColor = [UIColor redColor];
    [self.view addSubview:descLab];
    self.descLab = descLab;
   
    [descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(20);
        make.top.equalTo(view.mas_bottom).offset(5);
        make.centerX.equalTo(self.view);
    }];
    
//    [self startRun];
    
    [self setupBottomBtn];
}
-(void)setSlider{
    /// 创建Slider 设置Frame
       UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake((ScreenWidth - 247) * .5f, 500, 247, 50)];
       self.slider = slider;
       /// 添加Slider
       [self.view addSubview:slider];
    slider.minimumValue = 0.0;
     slider.maximumValue = 30.0;
    slider.value = 10;
    [slider addTarget:self action:@selector(sliderValueDidChanged:) forControlEvents:UIControlEventValueChanged];

}
-(void)sliderValueDidChanged:(UISlider*)slider{
    NSLog(@"slideValue==%.f",slider.value);
    int value = (int)slider.value;
    self.batteryBgV.y = 450 -self.batteryNum*0.5 -1 - value;
    self.batteryBgV.height = self.batteryNum*0.5 + value;
}

-(void)startRun{
    [self.progressView KSProgramTimerStart];
}
-(void)timeChange:(NSString *)text{
    NSLog(@"text = %@",text);
    self.descLab.text = text;

}
-(void)KSProgressTimeUp:(KSProgressTimeView *)KSProgressTimeView{
    NSLog(@"time over");
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//   BatteryBarView *barView = self.view.subviews.lastObject;
//   barView.batteryPower = [self randomNumber];
   
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
-(void)addClicked{
    NSLog(@"1111111");
}
-(void)setupBottomBtn{
    UIButton *cancelButton = [[UIButton alloc] init];
    [self.view addSubview:cancelButton];

    [cancelButton setTitle:NSLocalizedString(@"+添加新耳机", nil)  forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
//    cancelButton.backgroundColor = [UIColor redColor];
    [cancelButton addTarget:self action:@selector(addClicked) forControlEvents:UIControlEventTouchUpInside];
    CGFloat bottomHeight;
    bottomHeight =  iPhoneX ? SafeAreaBottomHeight+44:44;
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-22);
        make.left.equalTo(self.view.mas_left).offset(22);
        make.bottom.equalTo(self.view.mas_bottom).offset(-bottomHeight);
        make.height.mas_equalTo(41);
    }];
}
@end
