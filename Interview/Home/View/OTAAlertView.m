//
//  OTAAlertView.m
//  Interview
//
//  Created by kiss on 2019/8/30.
//  Copyright © 2019 cl. All rights reserved.
//

#import "OTAAlertView.h"
#define kWTDefaultButtonHeight 40
#define kWTDefaultButtonSpacerHeight 1
#define kWTAlertViewCornerRadius 7

#define kWTMargin 16
#define DiaViewTopHeight 100
@interface OTAAlertView() {
    CGFloat buttonSpacerHeight;
    CGFloat buttonHeight;
}
@property (nonatomic, strong) NSMutableArray* buttonArray;

@end

@implementation OTAAlertView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        // 触摸alert以外的区域是否关闭alert
        _closeOnTouchUpOutside = YES;
        self.buttonArray = [NSMutableArray array];
    }
    return self;
}
- (void)show {
    [self showViewWithbuttonIndex:0];
}
- (void)showViewWithbuttonIndex:(NSInteger)buttonIndex {
    [self.buttonArray removeAllObjects];
    self.dialogView = [[UIView alloc]init];
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:_dialogView];
    [_dialogView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(300, 300));
    }];
    [OTAAlertView removeCurrentAlert:[[[UIApplication sharedApplication] windows] firstObject]];
    
    [[[[UIApplication sharedApplication] windows] firstObject] addSubview:self];

    _dialogView.layer.opacity = 0.5f;
    _dialogView.layer.transform = CATransform3DMakeScale(1.2f, 1.2f, 1.0);
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f];
                         self.dialogView.layer.opacity = 1.0f;
                         self.dialogView.layer.transform = CATransform3DMakeScale(1, 1, 1);
                     }
                     completion:^(BOOL finished) {
                         
                     }];
    //icon
    UIView *topV = [[UIView alloc]init];
    [self.dialogView addSubview:topV];
    topV.backgroundColor = [UIColor redColor];
    [topV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.dialogView);
        make.height.mas_equalTo(100);
    }];
   
}
+ (void)removeCurrentAlert:(UIView*)parentView {
    NSEnumerator *subviewsEnum = [parentView.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            OTAAlertView* alertV = (OTAAlertView*)subview;
            [alertV removeFromSuperview];
        }
    }
}


- (void)addButtonsToView:(UIView *)container {
    if (!self.buttonTitles) {
        return;
    }
    CGFloat buttonWidth = container.bounds.size.width / self.buttonTitles.count;
    
    for (int i=0; i<self.buttonTitles.count; i++) {
        
        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [closeButton setFrame:CGRectMake(i * buttonWidth, container.bounds.size.height - buttonHeight, buttonWidth, buttonHeight)];
        
        [closeButton addTarget:self action:@selector(dialogButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [closeButton setTag:i];
        
        [closeButton setTitle:[self.buttonTitles objectAtIndex:i] forState:UIControlStateNormal];
       
        if (i == 1) {
             [closeButton setTitleColor:[UIColor colorFromHexStr:@"#EE8127"] forState:UIControlStateNormal];
        }else{
            [closeButton setTitleColor:[UIColor colorFromHexStr:@"#999999"] forState:UIControlStateNormal];
        }
        [closeButton.titleLabel setFont:[UIFont systemFontOfSize:17.0f]];
        closeButton.titleLabel.numberOfLines = 0;
        closeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [closeButton.layer setCornerRadius:kWTAlertViewCornerRadius];
        
        [container addSubview:closeButton];
        [self.buttonArray addObject:closeButton];
    }
}




- (void)dialogButtonTouchUpInside:(UIButton*)sender
{
    if (self.onButtonTouchUpInside) {
        self.onButtonTouchUpInside(self, sender.tag);
    }
}
- (void)close
{
    CATransform3D currentTransform = self.dialogView.layer.transform;
    
    self.dialogView.layer.opacity = 1.0f;
    
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         self.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f];
                         self.dialogView.layer.transform = CATransform3DConcat(currentTransform, CATransform3DMakeScale(0.6f, 0.6f, 1.0));
                         self.dialogView.layer.opacity = 0.0f;
                     }
                     completion:^(BOOL finished) {
                         for (UIView *v in [self subviews]) {
                             [v removeFromSuperview];
                         }
                         [self removeFromSuperview];
                     }
     ];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!_closeOnTouchUpOutside) {
        return;
    }
    
    UITouch *touch = [touches anyObject];
    if ([touch.view isKindOfClass:[OTAAlertView class]]) {
        [self close];
    }
}
// 创建Title和message label
- (void)createTitleAndMessageLabel {
        UILabel* titleLabel = [[UILabel alloc] init];
        titleLabel.numberOfLines = 0;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:15];
    
        CGSize containerMaxSize = CGSizeMake(self.dialogView.frame.size.width - 2 * kWTMargin, [UIScreen mainScreen].bounds.size.height - 3 * kWTDefaultButtonHeight - 2 * kWTMargin);
        // titleLabel
        CGSize strSize= [OTAAlertView sizeForFont:titleLabel.font str:self.title size:CGSizeMake(containerMaxSize.width, containerMaxSize.height/2) mode:NSLineBreakByWordWrapping];
        titleLabel.text = self.title;
        titleLabel.frame = CGRectMake((self.dialogView.frame.size.width - strSize.width)/2.0, kWTMargin, strSize.width, strSize.height);
        [self.dialogView addSubview:titleLabel];
    
        // messageLabel
        // 1.创建label
        UILabel* messageLabel = [[UILabel alloc] init];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentLeft;
        messageLabel.textColor = [UIColor colorFromHexStr:@"#2D2D2D"];
        messageLabel.font = [UIFont systemFontOfSize:13];
        // 2.计算展示的宽高
        CGSize messageSize= [OTAAlertView sizeForFont:titleLabel.font str:self.message size:CGSizeMake(containerMaxSize.width, containerMaxSize.height/2) mode:NSLineBreakByWordWrapping];
        messageLabel.text = self.message;
        messageLabel.frame = CGRectMake((self.dialogView.frame.size.width - messageSize.width)/2.0, CGRectGetMaxY(titleLabel.frame)+kWTMargin, messageSize.width, messageSize.height);
        [self.dialogView addSubview:messageLabel];
        // 3.重置containerview的frame
        self.dialogView.frame = CGRectMake(0, 0, self.dialogView.frame.size.width, CGRectGetMaxY(messageLabel.frame)+kWTMargin);
    
}
+ (CGSize)sizeForFont:(UIFont *)font str:(NSString*)str size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode {
    CGSize result;
    NSMutableDictionary *attr = [NSMutableDictionary new];
    attr[NSFontAttributeName] = font;
    if (lineBreakMode != NSLineBreakByWordWrapping) {
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        paragraphStyle.lineBreakMode = lineBreakMode;
        attr[NSParagraphStyleAttributeName] = paragraphStyle;
    }
    CGRect rect = [str boundingRectWithSize:size
                                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                 attributes:attr context:nil];
    result = rect.size;
    return result;
}

@end
