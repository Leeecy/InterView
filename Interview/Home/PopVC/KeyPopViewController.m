//
//  KeyPopViewController.m
//  Interview
//
//  Created by kiss on 2020/1/2.
//  Copyright © 2020 cl. All rights reserved.
//

#import "KeyPopViewController.h"
#import "KSKeyConfigView.h"
@interface KeyPopViewController ()
@property(strong,nonatomic)UIButton *leftBtn;
@end

@implementation KeyPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
      self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftBtn setTitle:@"1111" forState:(UIControlStateNormal)];
    self.leftBtn.backgroundColor = [UIColor whiteColor];
    [self.leftBtn addTarget:self action:@selector(popV:) forControlEvents:(UIControlEventTouchUpInside)];
    self.leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.leftBtn setTitleColor:[UIColor colorWithHexString:@"#F38629"] forState:(UIControlStateNormal)];
    self.leftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    self.leftBtn.frame= CGRectMake(ScreenWidth * 0.5- 50, 200, 100, 40);
    [self.view addSubview:self.leftBtn];
}

-(IBAction)popV:(id)sender{
    KSKeyConfigView *keyView = [[KSKeyConfigView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight)];
    [UIView animateWithDuration:0.2 animations:^{
        keyView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
                } completion:^(BOOL finished) {

                }];
        [kKeyWindow addSubview:keyView];
}

@end
