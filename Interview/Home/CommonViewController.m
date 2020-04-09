//
//  CommonViewController.m
//  suanfa
//
//  Created by cl on 2019/7/17.
//  Copyright © 2019 cl. All rights reserved.
//

#import "CommonViewController.h"
#import "CommomSuperFind.h"
#import <Masonry.h>
@interface CommonViewController ()
@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;

@end

@implementation CommonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =  [UIColor whiteColor];
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 100)];
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 100)];
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 100)];
    [view1 addSubview:view2];
    [view1 addSubview:view3];
    [self.view addSubview:view1];
    
    CommomSuperFind *find = [[CommomSuperFind alloc]init];
    [find findCommonSuperView:view2 other:view3];
    [find searchSuperView2:view1 andClass:view3];
    
    self.label1 = [[UILabel alloc]init];
    _label1.backgroundColor = [UIColor grayColor];
    _label1.text = @"1111111111111111label11111111111111111label1";
    _label1.textColor = [UIColor blackColor];
    [self.view addSubview:self.label1];
    
    self.label2 = [[UILabel alloc]init];
    _label2.text = @"1111111111111111label1";
    _label2.backgroundColor = [UIColor greenColor];
    _label2.textColor = [UIColor blackColor];
    [self.view addSubview:self.label2];
    
    
    
    [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(400);
        make.height.mas_equalTo(18);
    }];
    
    [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.label1.mas_right);
        make.top.mas_equalTo(self.label1);
        make.right.mas_offset(0);
    }];
    // 水平方向别扯我
    [_label1 setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    
    
}



@end
