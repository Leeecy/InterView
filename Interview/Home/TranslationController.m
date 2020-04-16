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
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 226)];;
    
    self.bottomImg = img;
//    CATransition *transition = [CATransition animation];
//    transition.duration = 1;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    transition.type = kCATransitionFade;
//    [img.layer addAnimation:transition forKey:@"a"];
    img.image = [UIImage imageNamed:@"bottom_bg"];
    [self.view addSubview:self.bottomImg];
   [UIView animateKeyframesWithDuration:3 delay:0 options:UIViewKeyframeAnimationOptionRepeat animations:^{
         
        img.transform = CGAffineTransformMakeTranslation(0, 260);//xy移动距离;
    } completion:^(BOOL finished) {
       
         
    }];
    
    
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
