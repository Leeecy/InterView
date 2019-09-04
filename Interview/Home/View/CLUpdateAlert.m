//
//  CLUpdateAlert.m
//  TeviPair
//
//  Created by kiss on 2019/8/30.
//  Copyright © 2019 kiss. All rights reserved.
//

#import "CLUpdateAlert.h"
#define KSDefaultButtonHeight 40
#define kWTAlertViewCornerRadius 7
@interface CLUpdateAlert()
@property(nonatomic,strong) UIView * promptView;
@end

@implementation CLUpdateAlert
-(instancetype)initWithFrame:(CGRect)frame content:(NSString*)content btnArray:(NSArray *)btnArr{
    if (self =[super initWithFrame:frame]) {
        self.btnArr = btnArr;
        self.backgroundColor = [[UIColor blackColor ]colorWithAlphaComponent:0.4];
        UIView * promptView = [UIView new];
        promptView.layer.cornerRadius = 23.3;
        promptView.backgroundColor = [UIColor whiteColor];
        promptView.layer.masksToBounds = YES;
        [self addSubview:promptView];
        self.promptView = promptView;
        CGFloat topH = iPhoneX ? 200 :130;
        [promptView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(42);
            make.right.equalTo(self.mas_right).offset(-37);
            make.top.equalTo(self.mas_top).offset(topH);
            make.height.mas_equalTo(110 + 40*6);
        }];
        
        UIImageView *icon = [[UIImageView alloc]init];
        icon.backgroundColor = [UIColor orangeColor];
        [self.promptView addSubview:icon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.promptView.mas_centerX);
            make.top.equalTo(self.promptView.mas_top).offset(40);
            make.size.mas_equalTo(CGSizeMake(74, 74));
        }];
        
        UILabel *tipL = [[UILabel alloc]init];
        tipL.text = @"2.0V版本上线";
        tipL.textColor = [UIColor colorWithHexString:@"#282828"];
        tipL.font = [UIFont boldSystemFontOfSize:27];
        [self.promptView addSubview:tipL];
        [tipL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.promptView.mas_left).offset(20);
            make.top.equalTo(icon.mas_bottom).offset(50);
            make.size.mas_equalTo(CGSizeMake(180, 27));
        }];
        CGFloat height = 260;
        CGFloat buttonWidth = (self.width - 42 -37) / btnArr.count;
        
        for (int i=0; i<btnArr.count; i++) {
            
            UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [closeButton addTarget:self action:@selector(dialogButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
            [closeButton setTag:i];
            
            [closeButton setTitle:[btnArr objectAtIndex:i] forState:UIControlStateNormal];
            
            if (i == 1) {
                [closeButton setTitleColor:[UIColor colorFromHexStr:@"#EE8127"] forState:UIControlStateNormal];
                
            }else{
                [closeButton setTitleColor:[UIColor colorFromHexStr:@"#999999"] forState:UIControlStateNormal];
            }
            [closeButton.titleLabel setFont:[UIFont systemFontOfSize:17.0f]];
            closeButton.titleLabel.numberOfLines = 0;
            closeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
            [closeButton.layer setCornerRadius:kWTAlertViewCornerRadius];
            [self.promptView addSubview:closeButton];
           
            [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.promptView.mas_left).offset( i*buttonWidth);
                make.top.equalTo(self.promptView.mas_bottom).offset(-KSDefaultButtonHeight);
                make.size.mas_equalTo(CGSizeMake(buttonWidth, KSDefaultButtonHeight));
            }];
       
            
        }
        
        NSLog(@"%f",self.promptView.height);
        
        UIView *lineV = [[UIView alloc]init];
        lineV.backgroundColor = [UIColor colorFromHexStr:@"#ECECEC"];
        [self.promptView addSubview:lineV];
        [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.promptView.mas_left).offset(0);
            make.right.equalTo(self.promptView.mas_right).offset(0);
            make.top.equalTo(self.promptView.mas_bottom).offset(-KSDefaultButtonHeight);
            make.height.mas_equalTo(1);
        }];
        
        UILabel *contentL = [[UILabel alloc]init];
        contentL.textColor = [UIColor colorWithHexString:@"#2D2D2D"];
        contentL.font = [UIFont systemFontOfSize:13];
        contentL.numberOfLines = 0;
        contentL.text = content;
        [self.promptView addSubview:contentL];
        
        NSMutableDictionary *attDic = [NSMutableDictionary dictionary];
        [attDic setValue:[UIFont systemFontOfSize:13] forKey:NSFontAttributeName];      // 字体大小
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:contentL.text attributes:attDic];
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.lineSpacing = 8;                                                          // 设置行之间的间距
        [attStr addAttribute:NSParagraphStyleAttributeName value:style range: NSMakeRange(0, contentL.text.length)];
        CGFloat contentH = [attStr boundingRectWithSize:CGSizeMake(self.width - 200, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
        contentL.attributedText = attStr;
       
//        contentL.frame = CGRectMake(72, 200, SCREEN_WIDTH-134,contentH);
        [contentL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.promptView.mas_left).offset(20);
            make.right.equalTo(self.promptView.mas_right).offset(-20);
             make.top.equalTo(tipL.mas_bottom).offset(20);
            make.height.mas_equalTo(contentH);
        }];
        
        [self.promptView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height +contentH + KSDefaultButtonHeight);
        }];
        
    }
    return self;
}
-(IBAction)dialogButtonTouchUpInside:(UIButton*)sender{
    if (self.onButtonTouchUpInside) {
        self.onButtonTouchUpInside(self, sender.tag);
    }
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
@end
