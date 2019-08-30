//
//  OTAFirmController.m
//  Interview
//
//  Created by kiss on 2019/8/30.
//  Copyright © 2019 cl. All rights reserved.
//

#import "OTAFirmController.h"
#import "OTAAlertView.h"
@interface OTAFirmController ()

@end

@implementation OTAFirmController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
     OTAAlertView* alertView = [[OTAAlertView alloc] init];
    alertView.onButtonTouchUpInside = ^(OTAAlertView * _Nonnull alertView, NSInteger buttonIndex) {
        NSLog(@"index==%ld",buttonIndex);
        [alertView close];
    };
    alertView.title = @"这个Alert只设置了title";
    alertView.message = @"1、修复了些已知问题 \n2、改善连接配对不稳定问题 \n3、添加协议 \n4、请将耳机处于此设备的接受范围<50m";
    [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"取消", @"立即更新", nil]];
    [alertView show];
}


@end
