//
//  Pop1ViewController.m
//  Interview
//
//  Created by kiss on 2019/9/9.
//  Copyright © 2019 cl. All rights reserved.
//

#import "Pop1ViewController.h"
#import "KSUpdateFailView.h"
@interface Pop1ViewController ()

@end

@implementation Pop1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self injected];
}

-(void)injected{
     NSArray *arr1 = @[@"取消",@"重试"];
    
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
