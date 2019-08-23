//
//  TextViewController.m
//  suanfa
//
//  Created by cl on 2019/7/17.
//  Copyright © 2019 cl. All rights reserved.
//

#import "TextViewController.h"
#import "CLTextView.h"
#import <objc/runtime.h>
#import <objc/message.h>
@interface TextViewController ()<UITextViewDelegate>

@end

@implementation TextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =  [UIColor whiteColor];
    
    // 通过运行时，发现UITextView有一个叫做“_placeHolderLabel”的私有变量
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([UITextView class], &count);
    
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *objcName = [NSString stringWithUTF8String:name];
        NSLog(@"%d : %@",i,objcName);
    }
    
    [self setupTextView];
   
}

- (void)setupTextView{
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 100)];
    [textView setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:textView];
    // _placeholderLabel
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = @"请输入内容";
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = [UIColor lightGrayColor];
    [placeHolderLabel sizeToFit];
    [textView addSubview:placeHolderLabel];
    // same font
    textView.font = [UIFont systemFontOfSize:13.f];
    placeHolderLabel.font = [UIFont systemFontOfSize:13.f];
    [textView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
                                                                        
}

-(void)setTextView{
    CLTextView *textView = [[CLTextView alloc] initWithFrame:CGRectMake(10, 100, self.view.frame.size.width, 30)];
    textView.backgroundColor = [UIColor redColor];
    //    textView.placeholder = @"ws1111111111111";
    textView.delegate = self;
    [self.view addSubview:textView];
    // textView.text = @"试试会不会调用文本改变的代理方法"; // 不会调用文本改变的代理方法
    //    textView.attributedText = [[NSAttributedString alloc] initWithString:@"富文本"];
    
    // self.textView = textView;
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(CLTextView *)textView // 此处取巧，把代理方法参数类型直接改成自定义的WSTextView类型，为了可以使用自定义的placeholder属性，省去了通过给控制器WSTextView类型属性这样一步。
{
    if (textView.hasText) { // textView.text.length
        textView.placeholder = @"";
        
    } else {
        textView.placeholder = @"请输入内容";
        
    }
}

@end
