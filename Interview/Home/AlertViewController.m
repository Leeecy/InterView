//
//  AlertViewController.m
//  Interview
//
//  Created by cl on 2019/7/30.
//  Copyright © 2019 cl. All rights reserved.
//

#import "AlertViewController.h"
#import "CLAlertView.h"
#import "SOValueTrackingSlider.h"
@interface AlertViewController ()
@property(strong,nonatomic)UISwitch *aswitch;
@property(nonatomic,assign)BOOL isOr;
@property(nonatomic,strong)NSString *macStr;
@end

@implementation AlertViewController
-(UIImage*) OriginImage:(UIImage*)image scaleToSize:(CGSize)size{
      if([[UIScreen mainScreen] scale] == 2.0) {
             UIGraphicsBeginImageContextWithOptions(size, NO, 2.0);
         } else {
             UIGraphicsBeginImageContext(size);
         }
       UIGraphicsBeginImageContextWithOptions(size, NO, [[UIScreen mainScreen] scale]);
    [image drawInRect:CGRectMake(0,0, size.width, size.height)];
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self injected];
//    CLAlertView *alertView = [[CLAlertView alloc]initWithTitle:@"请开启蓝牙以便我们查找并发现产品"];
//
//    [alertView show];
    
    for (int i =0; i<5; i++) {
           SOValueTrackingSlider *slider = [[SOValueTrackingSlider alloc] initWithFrame:CGRectMake(-100+30*i,300, 300, 40)];
           slider.maxmumTrackTintColor = [UIColor redColor];
           slider.minimumTrackTintColor = [UIColor greenColor];
           slider.isVertical = YES;
           slider.delegate = self;
           
           [self.view addSubview:slider];
       }
    
        CGFloat sliderH = 10;
        CGFloat sliderW = 300;
        CGFloat sliderX = 30 ;
        CGFloat sliderY = ScreenHeight-60;
        UISlider *sli = [[UISlider alloc] init];
        
        sli.value = 0.5;
     UIImage * img = [self OriginImage:[UIImage imageNamed:@"圆角矩形 1 拷贝"] scaleToSize:CGSizeMake(350, 10)];
    [sli setMinimumTrackImage:img forState:(UIControlStateNormal)];
     [sli setMaximumTrackImage:img forState:(UIControlStateNormal)];
    //        [self.slider addTarget:self action:@selector(_sliderValueDidChanged:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:sli];
        sli.frame = CGRectMake(sliderX, sliderY, sliderW, sliderH);
        
}
-(void)injected{
    self.isOr = NO;
    self.view.backgroundColor =  [UIColor whiteColor];
//    if (!_aswitch) {
//        _aswitch = [[UISwitch alloc]init];
//        _aswitch.y = 200;
//        //        NSLog(@"%f",self.height);
//        _aswitch.x = ScreenWidth/2 - _aswitch.width;
//        _aswitch.onTintColor = [UIColor orangeColor];
//        [_aswitch addTarget:self action:@selector(switchTouched:) forControlEvents:UIControlEventValueChanged];
//      
//        [self.view addSubview:_aswitch];
//        
//    }
//    
//    UIButton *bgV = [[UIButton alloc]init];
//    [bgV addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:bgV];
//    [bgV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.aswitch);
//    }];
    
    UILabel *headL = [[UILabel alloc]init];
    headL.text = @"AAAAAASDFD";
    headL.textAlignment = NSTextAlignmentCenter;
    headL.font = ArialBoldFont(22);
    headL.textColor = [UIColor colorWithHexString:@"#2C2C2C"];
    [self.view addSubview:headL];
   
    [headL mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.equalTo(self.view.mas_top).offset(500);
       make.centerX.equalTo(self.view);
       make.size.mas_equalTo(CGSizeMake(200, 30));
    }];
    
    UILabel *headL1 = [[UILabel alloc]init];
     headL1.text = @"AAAA";
     headL1.textAlignment = NSTextAlignmentRight;
     headL1.font = ArialBoldFont(15);
     headL1.textColor = [UIColor colorWithHexString:@"#2C2C2C"];
     [self.view addSubview:headL1];
    
     [headL1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(550);
        make.trailing.equalTo(self.view.mas_trailing).offset(-ScreenWidth*0.5 - 5);
        make.size.mas_equalTo(CGSizeMake(80, 30));
     }];
    
    UILabel *headL2 = [[UILabel alloc]init];
     headL2.text = @"BBBB";
     headL2.textAlignment = NSTextAlignmentLeft;
     headL2.font = ArialBoldFont(15);
     headL2.textColor = [UIColor colorWithHexString:@"#2C2C2C"];
     [self.view addSubview:headL2];
    
     [headL2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(550);
        make.leading.equalTo(self.view.mas_leading).offset(ScreenWidth*0.5 + 5);
        make.size.mas_equalTo(CGSizeMake(80, 30));
     }];
    
    UILabel *headL3 = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth*0.5 +5, 600, 80, 30)];
     headL3.text = @"CCCC";
     headL3.textAlignment = NSTextAlignmentLeft;
     headL3.font = ArialBoldFont(15);
     headL3.textColor = [UIColor colorWithHexString:@"#2C2C2C"];
     [self.view addSubview:headL3];
    self.macStr = @"06";
    UIButton *addBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 600, 100, 60)];
    addBtn.backgroundColor = [UIColor redColor];
    [addBtn setTitle:@"111111"  forState:(UIControlStateNormal)];
    [addBtn addTarget:self action:@selector(addClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:addBtn];
    
    
}
-(IBAction)addClick:(UIButton*)sender{
    NSString *macStr = [NSString stringWithFormat:@"%.2d",[self.macStr intValue] + 1];
    NSLog(@"%@",macStr);
    self.macStr = macStr;
}
-(IBAction)click:(UIButton*)sender{
    [MBProgressHUD showAutoMessage:@"暂不支持z此功能" toView:self.view];
}
- (void)switchTouched:(UISwitch *)sw{
    
    sw.on = self.isOr ? true :false;
    
    if (sw.isOn) {
        NSLog(@"打开了");
    }else{
        NSLog(@"关闭了");
    }
//    if (!self.isOr) {
//        _aswitch.userInteractionEnabled = NO;
//    }
    
    
    
}

@end
