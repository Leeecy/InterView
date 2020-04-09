//
//  VTProgressView.m
//  VTUpdate
//
//  Created by kiss on 2019/11/21.
//  Copyright © 2019 kiss. All rights reserved.
//

#import "VTProgressView.h"

@interface VTProgressView()
@property(nonatomic,strong) UIView * promptView;
@property(nonatomic) float progress;

@property(nonatomic, strong) UIColor* progressTintColor ;
@property(nonatomic, strong) UIColor* trackTintColor;
@property(nonatomic,strong)UIProgressView *progressView;
@property(nonatomic,strong)UILabel *numL;

@end

@implementation VTProgressView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        self.backgroundColor = [[UIColor blackColor ]colorWithAlphaComponent:0.2];
        UIView * promptView = [UIView new];
        promptView.layer.cornerRadius = 16;
        promptView.backgroundColor = [UIColor whiteColor];
        promptView.layer.masksToBounds = YES;
        [self addSubview:promptView];
        self.promptView = promptView;
        CGFloat topH = iPhoneX ? 200 :130;
        [promptView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(42);
            make.right.equalTo(self.mas_right).offset(-37);
            make.top.equalTo(self.mas_top).offset(topH);
            make.height.mas_equalTo(50 + 205);
        }];
        
        UIImageView *bg_img = [[UIImageView alloc]init];
        bg_img.image = [UIImage imageNamed:@"图层 801 拷贝 2"];
        [self.promptView addSubview:bg_img];
        [bg_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.promptView);
        }];
        
        
        
        UILabel *tipL = [[UILabel alloc]init];
        tipL.text = NSLocalizedString(@"升级过程大约需要7-10分钟", nil);
        tipL.numberOfLines = 0;
        tipL.textColor = [UIColor colorWithHexString:@"#666666"];
        tipL.font = [UIFont boldSystemFontOfSize:12.67];
        [self.promptView addSubview:tipL];
        [tipL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.promptView.mas_left).offset(37);
            make.top.equalTo(self.promptView.mas_top).offset(70);
            make.size.mas_equalTo(CGSizeMake(250, 60));
        }];
      
       
        self.progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(37, 150, ScreenWidth -37*4, 2)];
        //背景颜色
        self.progressView.backgroundColor = [UIColor grayColor];
        //已完成进度颜色
        self.progressView.progressTintColor = [UIColor orangeColor];
        self.progressView.progress = 0.5;
        //动画
       [UIView animateWithDuration:1 animations:^{
           [self.progressView setProgress:0.01 animated:YES];
//           [self close];
       } completion:^(BOOL finished){
           //NULL
       }];
        [self.promptView addSubview:self.progressView];
        
        UILabel *label = [[UILabel alloc]init];
        label.text = @"0%";
        label.textColor = [UIColor colorFromHexStr:@"#333333"];
        label.font = [UIFont systemFontOfSize:16];
//        label.backgroundColor = [UIColor redColor];
        [self.promptView addSubview:label];
        self.numL = label;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.progressView.mas_leading);
            make.top.equalTo(self.progressView.mas_bottom).offset(15);
            make.size.mas_equalTo(CGSizeMake(50, 20));
        }];
    }
    return self;
}

// 点击提示框视图以外的其他地方时隐藏弹框
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    CGPoint point = [[touches anyObject] locationInView:self];
    point = [self.promptView.layer convertPoint:point fromLayer:self.layer];
    if (![self.promptView.layer containsPoint:point]) {
        self.hidden = YES;
    }
    
}

- (void)close{
    CATransform3D currentTransform = self.promptView.layer.transform;
    self.promptView.layer.opacity = 1.0f;
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         self.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f];
                         self.promptView.layer.transform = CATransform3DConcat(currentTransform, CATransform3DMakeScale(0.6f, 0.6f, 1.0));
                         self.promptView.layer.opacity = 0.0f;
                     }
                     completion:^(BOOL finished) {
                         for (UIView *v in [self subviews]) {
                             [v removeFromSuperview];
                         }
                         [self removeFromSuperview];
                     }
     ];
}
-(void)setProgress:(float)progress animated:(BOOL)animated{
//
    NSLog(@"progress==%f",progress);
    [self.progressView setProgress:progress animated:YES];
    [self.numL mas_updateConstraints:^(MASConstraintMaker *make) {
         make.leading.equalTo(self.progressView.mas_leading).offset((ScreenWidth -37*4) * progress -15);
    }];
    self.numL.text = [NSString stringWithFormat:@"%.0f%@",progress*100,@"%"];

}
@end
