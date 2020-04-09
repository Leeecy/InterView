//
//  Pop3ViewController.m
//  Interview
//
//  Created by kiss on 2019/11/21.
//  Copyright © 2019 cl. All rights reserved.
//

#import "Pop3ViewController.h"
#import "VTProgressView.h"
@interface Pop3ViewController ()

@end

@implementation Pop3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     VTProgressView * updateView = [[VTProgressView alloc]initWithFrame:kKeyWindow.frame];
    [kKeyWindow addSubview:updateView];
    [updateView setProgress:0.5 animated:YES];
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
