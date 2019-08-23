//
//  CLConnector.m
//  suanfa
//
//  Created by cl on 2019/7/10.
//  Copyright © 2019 cl. All rights reserved.
//

#import "CLConnector.h"
#import "CLComponentManager.h"
#import "CLTestViewController.h"
@implementation CLConnector

+ (void)load {
    
    @autoreleasepool {
        
        [CLComponentManager registerConnector:[self getInstance]];
    }
}

/**
 *  单例
 */
+ (nonnull CLConnector *)getInstance {
    
    static CLConnector *sharedConnector = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedConnector = [[CLConnector alloc] init];
    });
    
    return sharedConnector;
}


#pragma mark - LJCMConnectorPrt 中间件接入协议

/**
 *  当前业务组件可导航的URL询问判断
 *  (1)当调用方需要通过判断URL是否可导航显示界面的时候，告诉调用方该组件实现是否可导航URL；可导航，返回YES，否则返回NO
 *  (2)这个方法跟connectToOpenURL:params配套实现；如果不实现，则调用方无法判断某个URL是否可导航
 */

- (BOOL)canOpenURL:(nonnull NSURL *)URL {
    
    if ([URL.host isEqualToString:@"ModuleBDetail"]) {
        return YES;
    }
    
    return NO;
}

/**
 *  业务模块挂接中间件，注册自己能够处理的URL，完成url的跳转；
 *  (1)通过connector向componentManager挂载可导航的URL，具体解析URL的host还是path，由connector自行决定；
 *  (2)如果URL在本业务组件可导航，则从params获取参数，实例化对应的viewController进行返回；如果参数错误，则返回一个错误提示的[UIViewController paramsError]; 如果不需要中间件进行present展示，则返回一个[UIViewController notURLController],表示当前可处理；如果无法处理，返回nil，交由其他组件处理；
 *  (3)需要在connector中对参数进行验证，不同的参数调用生成不同的ViewController实例；也可以通过参数决定是否自行展示，如果自行展示，则用户定义的展示方式无效；
 *  (4)如果挂接的url较多，这里的代码比较长，可以将处理方法分发到当前connector的category中；
 */
- (nullable UIViewController *)connectToOpenURL:(nonnull NSURL *)URL params:(nullable NSDictionary *)params {
    
    // 处理scheme://ModuleADetail的方式
    // tip: url较少的时候可以通过if-else去处理，如果url较多，可以自己维护一个url和ViewController的map，加快遍历查找，生成viewController；
    if ([self canOpenURL:URL]) {
        
        CLTestViewController *viewController = [[CLTestViewController alloc] init];
        if (params[@"key"] != nil) {
            
            viewController.valueLabel.text = params[@"key"];
        } else if(params[@"image"]) {
            
            id imageObj = params[@"image"];
            if (imageObj && [imageObj isKindOfClass:[UIImage class]]) {
                
                viewController.valueLabel.text = @"this is image";
                viewController.imageView.image = params[@"image"];
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:viewController animated:YES completion:nil];
                return [UIViewController lj_notURLController];
            } else {
                
                viewController.valueLabel.text = @"no image";
                viewController.imageView.image = [UIImage imageNamed:@"noImage"];
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:viewController animated:YES completion:nil];
                return [UIViewController lj_notURLController];
            }
        } else {
            // nothing to do
        }
        return viewController;
    }
    
    
    else {
        // nothing to to
    }
    
    return nil;
}
@end
