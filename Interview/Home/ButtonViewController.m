//
//  ButtonViewController.m
//  Interview
//
//  Created by kiss on 2019/10/16.
//  Copyright © 2019 cl. All rights reserved.
//

#import "ButtonViewController.h"
#import "KSEQCustomView.h"
#import "KSSegmentEqView.h"
#import "KSEqSlider.h"
#import "CLSlider.h"
#import "TeBatteryView.h"
#import "WZBSwitch.h"
#import "AppDelegate.h"
#define WZBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface ButtonViewController () <WZBSwitchDelegate>
@property(nonatomic,strong)NSMutableArray *array;
@property(nonatomic,strong)UIButton *btn1;
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,assign)NSInteger columnsNumber ;
@property(nonatomic,strong)KSSegmentEqView *segment;
@property(nonatomic,strong)CLSlider *slider;
@property(nonatomic,strong)UISwitch *mySwitch;
@property(nonatomic,strong)WZBSwitch *switchView;
@property(nonatomic,strong)NSString *name;

@end

@implementation ButtonViewController
-(void)clickSingle{
    
}
-(void)removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(void *)context{
   

}
- (void)switchValueChange:(WZBSwitch *)swith on:(BOOL)on {
    // do someing
    
}
- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context{
    NSLog(@"keyPath==%@",keyPath);
    if([keyPath isEqualToString:@"1"]) {

       }else{

       }
}

- (void)exitApplication{

    [UIView beginAnimations:@"exitApplication" context:nil];

    [UIView setAnimationDuration:0.5];

    [UIView setAnimationDelegate:self];

    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight  forView:self.view.window cache:NO];

    [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];

    self.view.window.bounds = CGRectMake(0, 0, 0, 0);

    [UIView commitAnimations];

}

- (void)animationFinished:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {

    if ([animationID compare:@"exitApplication"] == 0) {

        exit(0);

    }

}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createBtn];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.name = @"AAAA";
    WZBSwitch *switchView = [[WZBSwitch alloc] initWithFrame:CGRectMake(250, 400, 38, 20) switchValueChanged:^(WZBSwitch *swith, BOOL on) {
           // do someing
           NSLog(@"on----%d", on);
        self.name = @"BBBB";
        [self exitApplication];
        
       }];
    [self.view addSubview:switchView];
    // delegate
    switchView.delegate = self;
    [switchView setUpAllColors:^NSDictionary *(UIColor *__autoreleasing *onTintColor, UIColor *__autoreleasing *onBackgroundColor, UIColor *__autoreleasing *offTintColor, UIColor *__autoreleasing *offBackgroundColor, UIColor *__autoreleasing *tintColor) {
           // 也可以通过这种方法设置需要设置的颜色
           return @{OnTintColor : WZBColor(234, 67, 53), OnBackgroundColor : WZBColor(244, 161, 154), OffTintColor : WZBColor(255, 255, 255), OffBackgroundColor : WZBColor(214, 214, 214), TintColor : [UIColor colorWithRed:0.8252 green:0.8252 blue:0.8252 alpha:1.0]};
       }];
       switchView.onTintColor = [UIColor whiteColor];
       switchView.offBackgroundColor = [UIColor greenColor];
    self.switchView = switchView;
    
    NSString *str = [NSString stringWithFormat:@"%d",switchView.on];
    
     
    
    UISwitch *aswitch = [[UISwitch alloc]initWithFrame:CGRectMake(100, 200, 40, 20)];
       aswitch.onTintColor = [UIColor orangeColor];
        

       [aswitch setOn:YES];
       [aswitch addTarget:self action:@selector(switchTouched:) forControlEvents:UIControlEventValueChanged];
        aswitch.transform = CGAffineTransformMakeScale(0.6, 0.6);
       [self.view addSubview:aswitch];
    
    self.mySwitch = [[UISwitch alloc]initWithFrame:CGRectMake(20, 100, 90, 20)];
       [self.view addSubview:self.mySwitch];
       [self.mySwitch addTarget:self action:@selector(clickSingle) forControlEvents:UIControlEventValueChanged];
    
    
//    [self test1];
//    [self test2];
//    [self slider1];
    
    CLSlider *slider = [[CLSlider alloc] init];

    slider.minimumTrackTintColor = [UIColor redColor];
    slider.maximumTrackTintColor = [UIColor greenColor];
    [self.view addSubview:slider];
    /// 逆时针旋转90度
//    slider.transform = CGAffineTransformMakeRotation(-M_PI_2);
    /// 事件监听
    [slider addTarget:self action:@selector(_sliderValueDidChanged:) forControlEvents:UIControlEventValueChanged];
    /// 设置Frame
    CGFloat sliderW = 300;
    CGFloat sliderH = 2;
    CGFloat sliderX = 30 ;
//    slider.userInteractionEnabled = NO;
    CGFloat sliderY = CGRectGetMaxY(slider.frame) + 100;
    slider.frame = CGRectMake(sliderX, sliderY, sliderH, sliderW);
    [slider setThumbImage:[UIImage imageNamed:@"slider_bg"] forState:(UIControlStateNormal)];
    [self.view addSubview:slider];
//
//    CLSlider *slider1 = [[CLSlider alloc] init];
//
//      slider1.minimumTrackTintColor = [UIColor redColor];
//      slider1.maximumTrackTintColor = [UIColor greenColor];
//      [self.view addSubview:slider1];
//      /// 逆时针旋转90度
//      slider1.transform = CGAffineTransformMakeRotation(-M_PI_2);
//      /// 事件监听
//      [slider1 addTarget:self action:@selector(_sliderValueDidChanged:) forControlEvents:UIControlEventValueChanged];
//      /// 设置Frame
//      CGFloat sliderW1 = 300;
//      CGFloat sliderH1 = 2;
//      CGFloat sliderX1 = (self.view.width - sliderH) *.5f +20;
//      CGFloat sliderY1 = CGRectGetMaxY(slider1.frame) + 100;
//      slider1.frame = CGRectMake(sliderX1, sliderY1, sliderH1, sliderW1);
//      [slider1 setThumbImage:[self OriginImage:[UIImage imageNamed:@"圆形 (1)"] scaleToSize:CGSizeMake(14, 14)] forState:(UIControlStateNormal)];
    
    
//    [self createSlider];
    
   
   UILabel *textL = [[UILabel alloc]initWithFrame:CGRectMake(30, ScreenHeight-64 -20, ScreenWidth -30*2, 50)];
   textL.numberOfLines = 0 ;
   textL.text = NSLocalizedString(@"音量+1111\n(默认)", nil);
   textL.textColor = [UIColor colorWithHexString:@"#46464E"];
   textL.font = [UIFont systemFontOfSize:12];
   textL.textAlignment = NSTextAlignmentCenter;
   [self.view addSubview:textL];
    
    UILabel *textL1 = [[UILabel alloc]init];
     textL1.numberOfLines = 0 ;
     textL1.text = NSLocalizedString(@"音量+1111(默认)", nil);
     textL1.textColor = [UIColor colorWithHexString:@"#46464E"];
     textL1.font = [UIFont systemFontOfSize:12];
     textL1.textAlignment = NSTextAlignmentCenter;
     [self.view addSubview:textL1];
    [textL1 mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(self.view.mas_top).offset(200);
        make.right.equalTo(self.view.mas_right).offset(-100);
        make.size.mas_equalTo(CGSizeMake(50, 15));
    }];
    
    TeBatteryView *batteryV1= [[TeBatteryView alloc]initWithFrame:CGRectMake(290,  170, 20, 10) num:8];
    [self.view addSubview:batteryV1];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [batteryV1 mas_updateConstraints:^(MASConstraintMaker *make) {
            batteryV1.centerY = textL1.centerY;
        }];
    });
    
   
    
}
-(void)createBtn{
     for (int i=0; i<2; i++) {
    
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag = 100 + i;
            [btn setTitle:_array[i] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"常规"] forState:(UIControlStateNormal)];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    //        btn.clipsToBounds = YES;
         [self.view addSubview:btn];
            
         btn.frame = CGRectMake( 150 + 80 *i,300 ,70 , 40);
         
        }
}
-(IBAction)clickBtn:(UIButton*)sender{
     [sender setBackgroundImage:[UIImage imageNamed:@"按下"] forState:(UIControlStateNormal)];
}
-(UIImage*) OriginImage:(UIImage*)image scaleToSize:(CGSize)size{UIGraphicsBeginImageContext(size);//size为CGSize类型，即你所需要的图片尺寸
    [image drawInRect:CGRectMake(0,0, size.width, size.height)];
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
    
}

-(void)createSlider{
        CGFloat width = (ScreenWidth -30 *2) /9;
       for (int i = 0; i< 10; i++) {
           CGFloat sliderW = 300;
           CGFloat sliderH = 2;
           CGFloat sliderX = 30 + width *i;
           CGFloat sliderY = 200;
           NSLog(@"x==%f",sliderX);
           self.slider = [[CLSlider alloc] init];
           self.slider.transform = CGAffineTransformMakeRotation(-M_PI_2);
           self.slider.maximumTrackTintColor = [UIColor colorWithHexString:@"#EDEDED"];
           self.slider.minimumTrackTintColor = [UIColor colorWithHexString:@"#F9A435"];
          [self.slider addTarget:self action:@selector(_sliderValueDidChanged:) forControlEvents:UIControlEventValueChanged];
           [self.view addSubview:self.slider];
           self.slider.frame = CGRectMake(sliderX, sliderY, sliderH, sliderW);
            [self.slider setThumbImage:[self OriginImage:[UIImage imageNamed:@"圆点大"] scaleToSize:CGSizeMake(14, 14)] forState:(UIControlStateNormal)];
          
       }
}
-(IBAction)switchTouched:(UISwitch*)sw{
    
    if ([sw isOn]) {
        
    }else{
       sw.tintColor=[UIColor redColor];
    }
    
}

-(void)_sliderValueDidChanged:(KSEqSlider*)slider{
    NSLog(@"value==%f",slider.value);
}
-(void)slider1{
    KSEqSlider *slider = [[KSEqSlider alloc] init];
    slider.hidden = NO;
    slider.minimumTrackTintColor = [UIColor redColor];
    slider.maximumTrackTintColor = [UIColor greenColor];
    [self.view addSubview:slider];
    /// 逆时针旋转90度
    slider.transform = CGAffineTransformMakeRotation(-M_PI_2);
    /// 事件监听
    [slider addTarget:self action:@selector(_sliderValueDidChanged:) forControlEvents:UIControlEventValueChanged];
    /// 设置Frame
    CGFloat sliderW = 247;
    CGFloat sliderH = 2;
    CGFloat sliderX = (self.view.width - sliderH) *.5f;
    CGFloat sliderY = CGRectGetMaxY(slider.frame) + 100;
    slider.frame = CGRectMake(sliderX, sliderY, sliderH, sliderW);
}
-(void)test2{
    NSArray *titles = @[@"广州",@"北京",@"上海",@"深圳"];
    _segment = [[KSSegmentEqView alloc] initWithSegmentedTitles:titles];
           
    _segment.segmentClickBlock = ^(NSInteger index) {
               // 让底部的内容scrollView滚动到对应位置
           };
    
    [self.view addSubview:_segment];
    [self.segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(100);
    make.size.mas_equalTo(CGSizeMake(300, 40));
    }];
}
-(void)test1{
    UIButton * btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn2 setTitle:@"default" forState:UIControlStateNormal];
        btn2.frame = CGRectMake(30, 500, 100, 40);
        [btn2 setBackgroundImage:[UIImage imageNamed:@"圆角矩形 8 拷贝 7"] forState:(UIControlStateNormal)];
    //    [btn2 setBackgroundImage:[UIImage imageNamed:@"圆角矩形 8 拷贝 8"] forState:(UIControlStateSelected)];
        [btn2 addTarget:self action:@selector(selectClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [btn2 setTitleColor:[UIColor colorFromHexStr:@"#F29011"] forState:UIControlStateNormal];
        btn2.titleLabel.font = [UIFont systemFontOfSize:11];
        btn2.layer.cornerRadius = 6;
        [self.view addSubview:btn2];
        
        
        
       
        self.array = [NSMutableArray arrayWithObjects:@"default",@"自定义", nil];
         [self show];
        
        
         NSMutableArray * marr = [[NSMutableArray alloc]initWithObjects:@"11111",@"22222",@"33333",@"44444",@"55555",nil];
        
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];

         NSArray * array = [marr copy];

         [defaults setObject:array forKey:@"ProductCode"];

         [defaults synchronize];
}
-(IBAction)selectClick:(UIButton*)sender{
    if (sender.selected) {
        NSLog(@"选中了");
        [sender setBackgroundImage:[UIImage imageNamed:@"圆角矩形 8 拷贝 8"] forState:(UIControlStateSelected)];
        sender.selected = NO;
    }else{
       NSLog(@"未选中");
        
        [sender setBackgroundImage:[UIImage imageNamed:@"圆角矩形 8 拷贝 7"] forState:(UIControlStateNormal)];
        sender.selected = YES;
    }

}
//展示数据
- (void)show{
    CGFloat sw = [UIScreen mainScreen].bounds.size.width;
    CGFloat leftSpace = 20 ; //左间距和右间距
    CGFloat space = 25; //每个item的间距
    CGFloat btnW = (sw - leftSpace * 2 - space * 2)/3; //每个item的宽
    
    if (self.array.count >3) {
        self.columnsNumber = 2;//两行
    }else{
        self.columnsNumber = 1;
    }
    
    
    UIView  * bgV = [[UIView alloc]initWithFrame:CGRectMake(0, 200, 375, 200)];
    [self.view addSubview:bgV];
    self.bgView = bgV;
    
    for (int i=0; i<_array.count; i++) {
        NSInteger index = i % 3;
        NSInteger page = i / 3;
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 100 + i;
        [btn setTitle:_array[i] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor cyanColor]];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(addBtn:) forControlEvents:UIControlEventTouchUpInside];
//        btn.clipsToBounds = YES;
        btn.layer.cornerRadius = 6;
        [bgV addSubview:btn];
        
        btn.frame = CGRectMake( leftSpace + space * (i % 3) + btnW * (i % 3),50 * page  ,btnW , 35);
     
          
        
        
        
        
    }
}
-(IBAction)addBtn:(UIButton*)sender{
    if (sender.tag == 100) {
        NSLog(@"点击了第一个");
    }else if(sender.tag == 105){
        NSLog(@"点击了第6个");
    }else{
        NSLog(@"点击了了%@",sender.titleLabel.text);
        NSArray *arr1 = @[@"取消",@"保存"];
        KSEQCustomView * fail = [[KSEQCustomView alloc]initWithFrame:kKeyWindow.frame btnArray:arr1];
        hq_weak(fail)
        hq_weak(self)
        fail.onButtonTouchUpFail = ^(KSEQCustomView * _Nonnull alertView, NSInteger buttonIndex,NSString *name) {
            hq_strong(fail)
            hq_strong(self)
            if (buttonIndex == 0) {
                [fail close];
            }else{
                [fail close];
                NSLog(@"%@",name);
                
                if (self.array.count >= 0 && self.array.count < 6) {
                    
                    [self.bgView removeFromSuperview];
                    
//                    [self.array addObject:name];
                    [self.array insertObject:name atIndex:self.array.count -1];
                    NSLog(@"添加后 - %@",self.array);
                    
                    // 重新排布
                    [self show];
                    
                }
                
            }
        };
         [kKeyWindow addSubview:fail];
    }
    
    
}
/**
 c重新排布 删除

 */
-(void)changeLayout:(UIButton *)bbb{
    NSLog(@"%@",NSStringFromClass([bbb class]));
    
    #warning 先移除 (view) 再添加
    
    if (_array.count >=0) {
        [_array  removeObjectAtIndex:bbb.tag-100];
        
        [self.bgView removeFromSuperview];
        
        NSLog(@"删除后 - %@",_array);
    }
    
    //重新排布
    [self show];
}

-(void)dealloc{
    [self removeObserver:self forKeyPath:[NSString stringWithFormat:@"%d",self.switchView.on]];
}

@end
