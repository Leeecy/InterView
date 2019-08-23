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

@end

@implementation AlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CLAlertView *alertView = [[CLAlertView alloc]initWithTitle:@"请开启蓝牙以便我们查找并发现产品"];
    
    [alertView show];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
