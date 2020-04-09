//
//  KSEQCustomView.m
//  Interview
//
//  Created by kiss on 2019/10/16.
//  Copyright © 2019 cl. All rights reserved.
//

#import "KSEQCustomView.h"
#define KSDefaultButtonHeight 50
#define kWTAlertViewCornerRadius 9
@interface KSEQCustomView()
@property(nonatomic,strong) UIView * promptView;


@end
@implementation KSEQCustomView

-(instancetype)initWithFrame:(CGRect)frame btnArray:(NSArray *)btnArr{
    if (self =[super initWithFrame:frame]) {
        self.btnArr = btnArr;
        self.backgroundColor = [[UIColor blackColor ]colorWithAlphaComponent:0.4];
        UIView * promptView = [UIView new];
        promptView.layer.cornerRadius = kWTAlertViewCornerRadius;
        promptView.backgroundColor = [UIColor whiteColor];
        promptView.layer.masksToBounds = YES;
        [self addSubview:promptView];
        self.promptView = promptView;
        
        [promptView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(42);
            make.right.equalTo(self.mas_right).offset(-37);
            make.centerY.equalTo(self.mas_centerY);
            make.height.mas_equalTo(121 + 37);
        }];
        
        UILabel *tipL = [[UILabel alloc]init];
        tipL.text = NSLocalizedString(@"请添加名称", nil) ;
        tipL.textColor = [UIColor colorWithHexString:@"#333333"];
        tipL.font = [UIFont systemFontOfSize:15];
        [self.promptView addSubview:tipL];
        [tipL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.promptView.mas_centerX).offset(10);
            make.top.equalTo(promptView.mas_top).offset(20);
            make.size.mas_equalTo(CGSizeMake(80, 16));
        }];
        
        UIView *nameView = [[UIView alloc]init];
        nameView.backgroundColor = [UIColor colorFromHexStr:@"#F5F5F5"];
        [self.promptView addSubview:nameView];
        
        
        self.nameField = [[UITextField alloc]init];
        self.nameField.backgroundColor = [UIColor clearColor];
        self.nameField.font = [UIFont systemFontOfSize:16];
        self.nameField.placeholder = NSLocalizedString(@"请添加名称", nil);
        self.nameField.textColor = [UIColor blackColor];
        self.nameField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        [nameView addSubview:self.nameField];
        
        
        
        [nameView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.promptView.mas_top).offset(54);
        make.leading.equalTo(self.promptView.mas_leading).offset(13);
        make.trailing.equalTo(self.promptView.mas_trailing).offset(-13);
            make.height.mas_equalTo(37);
        }];
        
        [self.nameField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(nameView.mas_centerY);
        make.leading.equalTo(nameView.mas_leading).offset(10);
        make.trailing.equalTo(nameView.mas_trailing).offset(-5);
            make.height.mas_equalTo(28);
        }];
        
        
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
        
        UIView *lineV = [[UIView alloc]init];
        lineV.backgroundColor = [UIColor colorFromHexStr:@"#ECECEC"];
        [self.promptView addSubview:lineV];
        [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.promptView.mas_left).offset(0);
            make.right.equalTo(self.promptView.mas_right).offset(0);
            make.top.equalTo(self.promptView.mas_bottom).offset(-KSDefaultButtonHeight);
            make.height.mas_equalTo(1);
        }];
        
        UIView *verL = [[UIView alloc]init];
        verL.backgroundColor = [UIColor colorFromHexStr:@"#ECECEC"];
        [self.promptView addSubview:verL];
        [verL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.promptView.mas_centerX);
            make.top.equalTo(self.promptView.mas_bottom).offset(-KSDefaultButtonHeight);
            make.size.mas_equalTo(CGSizeMake(1, KSDefaultButtonHeight));
            
        }];
        
        
    }
    return self;
}
-(IBAction)dialogButtonTouchUpInside:(UIButton*)sender{
    [self.nameField resignFirstResponder];
    if (self.onButtonTouchUpFail) {
        self.onButtonTouchUpFail(self, sender.tag,self.nameField.text);
    }
}
// 点击提示框视图以外的其他地方时隐藏弹框
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     [self.nameField resignFirstResponder];
    CGPoint point = [[touches anyObject] locationInView:self];
    point = [self.promptView.layer convertPoint:point fromLayer:self.layer];
    if (![self.promptView.layer containsPoint:point]) {
        self.hidden = YES;
    }
    
}

- (void)close{
    [self.nameField resignFirstResponder];
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
