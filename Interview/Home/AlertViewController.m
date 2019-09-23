//
//  AlertViewController.m
//  Interview
//
//  Created by cl on 2019/7/30.
//  Copyright © 2019 cl. All rights reserved.
//

#import "AlertViewController.h"
#import "CLAlertView.h"
@interface AlertViewController ()
@property(strong,nonatomic)UISwitch *aswitch;
@property(nonatomic,assign)BOOL isOr;
@end

@implementation AlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    [self injected];
//    CLAlertView *alertView = [[CLAlertView alloc]initWithTitle:@"请开启蓝牙以便我们查找并发现产品"];
//
//    [alertView show];
}
-(void)injected{
    self.isOr = NO;
    self.view.backgroundColor =  [UIColor whiteColor];
    if (!_aswitch) {
        _aswitch = [[UISwitch alloc]init];
        _aswitch.y = 200;
        //        NSLog(@"%f",self.height);
        _aswitch.x = ScreenWidth/2 - _aswitch.width;
        _aswitch.onTintColor = [UIColor orangeColor];
        [_aswitch addTarget:self action:@selector(switchTouched:) forControlEvents:UIControlEventValueChanged];
      
        [self.view addSubview:_aswitch];
        
    }
    
    UIButton *bgV = [[UIButton alloc]init];
    [bgV addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bgV];
    [bgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.aswitch);
    }];
    
    
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
