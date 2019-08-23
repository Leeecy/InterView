//
//  AppLaunchController.m
//  suanfa
//
//  Created by cl on 2019/7/17.
//  Copyright © 2019 cl. All rights reserved.
// 对于pre-main阶段，Xcode9之后，Apple提供了一种测量方法，在 Xcode 中 Edit scheme -> Run -> Auguments 将环境变量DYLD_PRINT_STATISTICS 设为1 
/**
 1. pre-main阶段
 1.1. 加载应用的可执行文件（自身App的所有.o文件的集合）
 
 1.2. 加载动态链接器dyld（dynamic loader，是一个专门用来加载动态链接库的库）
 
 1.3. dyld递归加载应用所有依赖的动态链接库dylib
 
 优化:1>合并已有的dylib和使用静态库（static archives），减少dylib的使用个数 1.1、尽量不使用内嵌（embedded）的dylib，加载内嵌dylib性能开销较大
 
 2>减少ObjC类（class）、方法（selector）、分类（category）的数量
 3>、少在类的+load方法里做事情，尽量把这些事情推迟到+initiailize
 
 
 具体项目优化：
 1、排查无用的dylib（不确定的可以先删除，在编译下项目试试），减少dylib的数目
 
 2、检查framework应当设为optional和required，如果该framework在当前App支持的所有iOS系统版本都存在，那么就设为required，否则就设为optional
3、减少ObjC类（项目中不适用的的库，废弃的代码等）、方法（selector）、分类（category）的数量、无用的库、非基本类型的C++静态全局变量（通常是类或结构体）
 4、少在类的+load方法里做事情，尽量把这些事情推迟到+initiailize
 
 */

/*
 2. main()阶段
 2.1. dyld调用main()
 
 2.2. 调用UIApplicationMain()
 
 2.3. 调用applicationWillFinishLaunching
 
 2.4. 调用didFinishLaunchingWithOptions 优化：1》梳理各个二方/三方库，找到可以延迟加载的库，做延迟加载处理，比如放到首页控制器的viewDidAppear方法里 2》梳理业务逻辑，把可以延迟执行的逻辑，做延迟执行处理。比如检查新版本、注册推送通知等逻辑 3〉避免在首页控制器的viewDidLoad和viewWillAppear做太多事情，这2个方法执行完，首页控制器才能显示，部分可以延迟创建的视图应做延迟创建/懒加载处理 4》首页控制器用纯代码方式来构建 5〉采用性能更好的API。
 
 */


#import "AppLaunchController.h"
#import <MBProgressHUD.h>
@interface AppLaunchController ()<UITextViewDelegate>
@property(nonatomic,strong)MBProgressHUD *hud;
@property(nonatomic,strong)UIButton *startButton;
@end

@implementation AppLaunchController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =  [UIColor whiteColor];
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    self.hud.label.text = NSLocalizedString(@"正在更新...", @"HUD loading title");

//    [self doSomeWork];
    
    self.startButton = [[UIButton alloc]initWithFrame:CGRectMake(100, 150, 100, 50)];
    self.startButton.backgroundColor = [UIColor colorFromHex:@"#FF9B00"];
    [self.startButton setTitle:@"开始" forState:(UIControlStateNormal)];
    [self.view addSubview:self.startButton];
    [self.startButton addTarget:self action:@selector(startTouched:) forControlEvents:(UIControlEventTouchUpInside)];

    [self.view addSubview:self.startButton];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.hud hideAnimated:YES];
    });
    
    UITextView *textView = [[UITextView alloc] init];
    
    textView.frame = CGRectMake(40, 100, 300, 50);
    
    textView.editable = NO;
    
    textView.delegate = self;
    
    [self.view addSubview:textView];
     NSString *str = @"响应传递链文章链接";
     NSMutableAttributedString *mastring = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:22.0f]}];
    [mastring addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(0, str.length)];
    // 2.要有后面的方法，如果含有中文，url会无效，所以转码
    
    NSString *valueString1 = [[NSString stringWithFormat:@"firstPerson://%@",str] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    [mastring addAttribute:NSLinkAttributeName value:valueString1 range:NSMakeRange(0, str.length)];
    textView.attributedText = mastring;
    
    NSLog(@"ming -- 1");
    NSLog(@"ming -- 2");
    //                                                              DISPATCH_QUEUE_SERIAL
    dispatch_queue_t queue = dispatch_queue_create("mingming2", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t q = dispatch_queue_create("mingming2", DISPATCH_QUEUE_SERIAL);

    dispatch_sync(queue, ^{
        NSLog(@"ming -- 3");
        NSLog(@"ming -- 4");
        NSLog(@"ming -- 13");
        NSLog(@"ming -- 14");
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSLog(@"ming -- 5%@",[NSThread currentThread]);
//            [NSThread sleepForTimeInterval:0.3];
            
            NSLog(@"ming -- 6%@",[NSThread currentThread]);
        });
        NSLog(@"ming -- 7");
    });
    NSLog(@"ming -- 8");
    NSLog(@"+=====+++++++++++++=============+++++++++++++++++++++++++====");
    
    
    
    
    dispatch_queue_t queue1 = dispatch_get_global_queue(0, 0);
    dispatch_queue_t queue2 = dispatch_queue_create("cl", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_async(queue2, ^{
//        NSLog(@"A%@",[NSThread currentThread]);
//
//    });
    
    dispatch_sync(queue2, ^{
        
         NSLog(@"A%@",[NSThread currentThread]);
        dispatch_async(queue2, ^{
            NSLog(@"D%@",[NSThread currentThread]);

        });
    });
//    dispatch_sync(queue1, ^{
//        NSLog(@"B%@",[NSThread currentThread]);
//    });
    NSLog(@"X%@",[NSThread currentThread]);
    
    
}

-(IBAction)startTouched:(UIButton*)sender{
    [self.hud hideAnimated:YES];
}
-(void)doSomeWork{
    sleep(3.);
    [self.hud hideAnimated:YES];
}

-(BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction{
    if ([[URL scheme] isEqualToString:@"firstPerson"]) {
//https://liangdahong.com/2018/06/08/2018/%E6%B5%85%E8%B0%88-iOS-%E4%BA%8B%E4%BB%B6%E7%9A%84%E4%BC%A0%E9%80%92%E5%92%8C%E5%93%8D%E5%BA%94%E8%BF%87%E7%A8%8B/
        NSString *titleString = [NSString stringWithFormat:@"你点击了第一个文字:%@",[URL host]];
        [self clickLinkTitle:titleString];
        return NO;
        
    } else if ([[URL scheme] isEqualToString:@"secondPerson"]) {
        
        NSString *titleString = [NSString stringWithFormat:@"你点击了第二个文字:%@",[URL host]];
        
        [self clickLinkTitle:titleString];
        
        return NO;
    }
    
    return YES;
}
-(void)clickLinkTitle:(NSString *)title {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:title preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:action];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

//MARK:-响应

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    // 1.如果控件不允许与用用户交互,那么返回nil
    if (self.view.userInteractionEnabled == NO || self.view.alpha <= 0.01 || self.view.hidden == YES){
        return nil;
    }
    // 2. 如果点击的点在不在当前控件中,返回nil
    if (![self.view pointInside:point withEvent:event]){
        return nil;
    }
    // 3.从后往前遍历每一个子控件
    for(int i = (int)self.view.subviews.count - 1 ; i >= 0 ;i--){
        // 3.1获取一个子控件
        UIView *childView = self.view.subviews[i];
        // 3.2当前触摸点的坐标转换为相对于子控件触摸点的坐标
        CGPoint childP = [self.view convertPoint:point toView:childView];
        // 3.3判断是否在在子控件中找到了更合适的子控件(递归循环)
        UIView *fitView = [childView hitTest:childP withEvent:event];
        // 3.4如果找到了就返回
        if (fitView) {
            return fitView;
        }
    }
    // 4.没找到,表示没有比自己更合适的view,返回自己
    return self.view;
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    return NO;
}
@end
