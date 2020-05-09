//
//  TransSecondController.m
//  Interview
//
//  Created by kiss on 2020/5/6.
//  Copyright © 2020 cl. All rights reserved.
//

#import "TransSecondController.h"

@interface TransSecondController ()

@end

@implementation TransSecondController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
