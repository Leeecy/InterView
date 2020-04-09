//
//  Pop5ViewController.m
//  Interview
//
//  Created by kiss on 2019/12/3.
//  Copyright © 2019 cl. All rights reserved.
//

#import "Pop5ViewController.h"
#import "KSUpdateFailView.h"
@interface Pop5ViewController ()

@end

@implementation Pop5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    NSArray *arr1 = @[@"确定"];
    
    KSUpdateFailView * fail = [[KSUpdateFailView alloc]initWithFrame:kKeyWindow.frame btnArray:arr1];
    hq_weak(fail)
    fail.onButtonTouchUpFail = ^(KSUpdateFailView * _Nonnull alertView, NSInteger buttonIndex) {
        hq_strong(fail)
        if (buttonIndex == 0) {
            [fail close];
        }else{
            NSLog(@"1111");
        }
    };
     [kKeyWindow addSubview:fail];
}



@end
