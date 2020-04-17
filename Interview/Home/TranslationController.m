//
//  TranslationController.m
//  Interview
//
//  Created by kiss on 2020/4/16.
//  Copyright © 2020 cl. All rights reserved.
//

#import "TranslationController.h"

@interface TranslationController ()
@property(nonatomic,strong)UIImageView *bottomImg;
@end

@implementation TranslationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
//    [self test];
   
}

-(void)test{
    UIView *bottomV = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 260)];
    [self.view addSubview:bottomV];

    UIImageView *img = [[UIImageView alloc]initWithFrame:bottomV.bounds];
    self.bottomImg = img;
    img.image = [UIImage imageNamed:@"bottom_bg"];
    [bottomV addSubview:self.bottomImg];

    [UIView animateWithDuration:0.5 animations:^{
        bottomV.frame = CGRectMake(0, ScreenHeight-260, ScreenWidth, 260);
    } completion:^(BOOL finished) {

    }];
}

@end
