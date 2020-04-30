//
//  Pop2ViewController.m
//  Interview
//
//  Created by kiss on 2019/11/20.
//  Copyright © 2019 cl. All rights reserved.
//

#import "Pop2ViewController.h"
#import "CLUpdateSuccessView.h"

@interface Pop2ViewController ()

@end

@implementation Pop2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *arr1 = @[@"完成"];
    CLUpdateSuccessView * success = [[CLUpdateSuccessView alloc]initWithFrame:kKeyWindow.frame btnArray:arr1];
    success.onButtonSuccess = ^(CLUpdateSuccessView * _Nonnull alertView, NSInteger buttonIndex) {
        [alertView close];
    };
     [kKeyWindow addSubview:success];
}


@end
