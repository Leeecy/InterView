//
//  PopModel.m
//  Interview
//
//  Created by kiss on 2020/4/29.
//  Copyright © 2020 cl. All rights reserved.
//

#import "PopModel.h"
#import "XWHud.h"
#define kDefaultLastTime 20
#define kDefaultAnimationTime 0.3
#define HEIGHT_IPHONEX_BOTTOM_WHITE 25
@implementation PopModel
+(PopModel*)sharevView{
    static PopModel *shareView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareView = [[PopModel alloc]init];

    });
    return shareView;
}



+ (void)alertWithMessage:(NSString *)message{
    PopModel *pop = [PopModel sharevView];
    
    CGFloat topY = 30;
    if ([message isEqualToString:@""] || message == nil) {
        return;
    }
    
     CGFloat statusBarHeight = 0;
    if (iPhoneX) {
        statusBarHeight = 0;
    }
    UIViewController *vc = [self topViewController];
    
    __block UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, - HEIGHT_IPHONEX_BOTTOM_WHITE, ScreenWidth, HEIGHT_IPHONEX_BOTTOM_WHITE);
    
    view.backgroundColor = [UIColor colorFromHexStr:@"#F1A5A5"];
    if (vc.navigationController.navigationBarHidden) {
        [vc.view addSubview:view];
    } else {
        [vc.navigationController.navigationBar.superview addSubview:view];
    }
    
    XWHud *hud = [[XWHud alloc]initWithSize:CGSizeMake(18, 18) toView:view];
    hud = hud;
    [hud startHud];
    
    UILabel *lab = [[UILabel alloc] init];
    lab.frame = CGRectMake(kMaxX(hud.frame) +5, statusBarHeight, ScreenWidth, HEIGHT_IPHONEX_BOTTOM_WHITE);
    lab.backgroundColor = [UIColor clearColor];
    lab.text = message;
    lab.textAlignment = NSTextAlignmentLeft;
    lab.textColor = [UIColor colorWithHexString:@"#666666"];
    lab.font = [UIFont systemFontOfSize:13];
    [view addSubview:lab];
    
    [UIView animateWithDuration:kDefaultAnimationTime delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        view.frame = CGRectMake(0, topY, ScreenWidth, HEIGHT_IPHONEX_BOTTOM_WHITE);
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"20s消失");
        if (pop.delegate && [pop.delegate respondsToSelector:@selector(alertisConnecting)]) {
                [pop.delegate alertisConnecting];
            }
            [view removeFromSuperview];
            view = nil;
        });
        
    }];
}

+(UIViewController *)topViewController {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    return [self topVisibleViewControllerOfViewControlller:rootViewController];
}

+ (UIViewController *)topVisibleViewControllerOfViewControlller:(UIViewController *)vc {
    if ([vc isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)vc;
        return [self topVisibleViewControllerOfViewControlller:tabBarController.selectedViewController];
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)vc;
        return [self topVisibleViewControllerOfViewControlller:navigationController.visibleViewController];
    } else if (vc.presentedViewController) {
        return [self topVisibleViewControllerOfViewControlller:vc.presentedViewController];
    } else if (vc.childViewControllers.count > 0){
        return [self topVisibleViewControllerOfViewControlller:vc.childViewControllers.lastObject];
    }
    
    return vc;
}
+ (void)alertWithDismiss{
    NSLog(@"%@",[[self topViewController].view subviews]);
}

+ (void)alertWithMessage:(NSString *)message maskType:(AlertMaskType)maskType{
    PopModel *pop = [PopModel sharevView];
    
    
    CGFloat topY = 30;
    if ([message isEqualToString:@""] || message == nil) {
        return;
    }
    
     CGFloat statusBarHeight = 0;
    if (iPhoneX) {
        statusBarHeight = 0;
    }
    UIViewController *vc = [self topViewController];
    
    __block UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, - HEIGHT_IPHONEX_BOTTOM_WHITE, ScreenWidth, HEIGHT_IPHONEX_BOTTOM_WHITE);
    
    view.backgroundColor = [UIColor colorFromHexStr:@"#F1A5A5"];
    if (vc.navigationController.navigationBarHidden) {
        [vc.view addSubview:view];
        if (maskType == AlertMaskTypeBlack) {
            pop.maskView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
             pop.maskView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
            [[self getSuperView] addSubview:pop.maskView];
        }
        
    } else {
        
        if (maskType == AlertMaskTypeBlack) {
            pop.maskView = [UIView new];
            pop.maskView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
             pop.maskView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.2];
            [[self getSuperView] addSubview:pop.maskView];
        }
        
        [[self getSuperView] addSubview:view];
    }
    
    XWHud *hud = [[XWHud alloc]initWithSize:CGSizeMake(18, 18) toView:view];
    hud = hud;
    [hud startHud];
    
    UILabel *lab = [[UILabel alloc] init];
    lab.frame = CGRectMake(kMaxX(hud.frame) +5, statusBarHeight, ScreenWidth, HEIGHT_IPHONEX_BOTTOM_WHITE);
    lab.backgroundColor = [UIColor clearColor];
    lab.text = message;
    lab.textAlignment = NSTextAlignmentLeft;
    lab.textColor = [UIColor colorWithHexString:@"#666666"];
    lab.font = [UIFont systemFontOfSize:13];
    [view addSubview:lab];
    
    [UIView animateWithDuration:kDefaultAnimationTime delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        view.frame = CGRectMake(0, topY, ScreenWidth, HEIGHT_IPHONEX_BOTTOM_WHITE);
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"20s消失");
        if (pop.delegate && [pop.delegate respondsToSelector:@selector(alertisConnecting)]) {
                [pop.delegate alertisConnecting];
            }
            [pop.maskView removeFromSuperview];
          
            [view removeFromSuperview];
            view = nil;
        });
        
    }];
}
+(UIView *)getSuperView
{
    if ([self isKindOfClass:[UIView class]]) {
        return (UIView *)self;
    }else if ([self isKindOfClass:[UIViewController class]]){
        return [(UIViewController *)self view];
    }else if([UIApplication sharedApplication].keyWindow){
        return [UIApplication sharedApplication].keyWindow;
    }
    return nil;
}
@end
