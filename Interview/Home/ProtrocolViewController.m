//
//  ProtrocolViewController.m
//  Interview
//
//  Created by kiss on 2019/11/21.
//  Copyright © 2019 cl. All rights reserved.
//

#import "ProtrocolViewController.h"

#define leftMargin (40 *kScale)
#define topMargin (84 *kScale)
#define kScale (ScreenWidth) / 375.0
@interface KSProtocolAlertView()
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UITextView *textView;

@end

@implementation KSProtocolAlertView
-(instancetype)init{
    if (self == [super init]) {
        [self addSubview:self.contentView];
        
        [self.contentView addSubview:self.textView];
        [self setFrame];
    }
    return self;
}
- (void)setFrame{
    CGFloat width = self.contentView.bounds.size.width;
    CGFloat height = self.contentView.bounds.size.height;
    CGFloat margin = 20 *kScale;
   
    self.textView.frame = CGRectMake(margin,margin *0.7, width -margin *2, height - margin *5);
}

- (void)setContentStr:(NSString *)contentStr{
    _contentStr = contentStr;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:contentStr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5 *kScale;
    [attributedString addAttributes:@{NSParagraphStyleAttributeName:paragraphStyle,
                                      NSFontAttributeName:[UIFont systemFontOfSize:13]
                                      } range:NSMakeRange(0, contentStr.length)];
    self.textView.attributedText = attributedString;
    
}
- (UITextView *)textView{
    if (_textView == nil) {
        _textView = [[UITextView alloc] init];
        _textView.scrollEnabled = YES;
        _textView.showsHorizontalScrollIndicator = NO;
        _textView.showsVerticalScrollIndicator = NO;
        _textView.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _textView.font = [UIFont systemFontOfSize:14];
        _textView.editable = NO;
    }
    return _textView;
}
- (UIView *)contentView{
    if (_contentView == nil) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.frame = CGRectMake(10, topMargin, ScreenWidth - 10*2 , ScreenHeight - topMargin);
        _contentView.layer.cornerRadius = 10 *kScale;
    }
    return _contentView;
}
@end

@interface ProtrocolViewController ()
@property (nonatomic, strong) UITextView *textView;
@end

@implementation ProtrocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *noteVideoPath = [[NSBundle mainBundle] pathForResource:@"policy" ofType:@"txt"];
    NSString *content = [[NSString alloc] initWithContentsOfFile:noteVideoPath encoding:NSUTF8StringEncoding error:nil];
    self.textView.frame = CGRectMake(10,80, ScreenWidth -10 *2, ScreenHeight -80);
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:content];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5 *kScale;
    [attributedString addAttributes:@{NSParagraphStyleAttributeName:paragraphStyle,
                                      NSFontAttributeName:[UIFont systemFontOfSize:13]
                                      } range:NSMakeRange(0, content.length)];
    self.textView.attributedText = attributedString;
    
    [self.view addSubview:self.textView];
    
}

-(UITextView *)textView{
    if (_textView == nil) {
        _textView = [[UITextView alloc] init];
        _textView.scrollEnabled = YES;
        _textView.showsHorizontalScrollIndicator = NO;
        _textView.showsVerticalScrollIndicator = NO;
        _textView.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _textView.font = [UIFont systemFontOfSize:14];
        _textView.editable = NO;
    }
    return _textView;
}

@end
