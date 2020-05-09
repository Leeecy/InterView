//
//  SearchViewController.m
//  Interview
//
//  Created by kiss on 2020/3/28.
//  Copyright © 2020 cl. All rights reserved.
//

#import "SearchViewController.h"
#import <MBProgressHUD.h>
#import "SSProgressHUD.h"
@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    [self annularDeterminateExample];
}

-(void)annularDeterminateExample{
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.mode = MBProgressHUDModeAnnularDeterminate;
//     hud.label.text = NSLocalizedString(@"正在搜索",nil);
//
//    hud.progress = 0.5;
    UIView *customView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, 30, 30)];
    customView.backgroundColor = [UIColor clearColor];
    SSProgressHUD *hud = [[SSProgressHUD alloc]initWithCustomView:customView];
    
    hud.backgroundColor = [UIColor clearColor];
    [hud showLoading];
    
//    [self showLoadingText:@"正在搜索"];
//       __weak typeof(self) weakSelf = self;
//       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//           [weakSelf hideHUDAnimated:YES finished:^{
//               NSLog(@"finish");
//           }];
//       });
//
    
}

@end
