//
//  UIViewController+NavigationTip.m
//  LJComponentManager
//
//  Created by phoenix on 16/7/4.
//  Copyright © 2016年 SEU. All rights reserved.
//

#import "UIViewController+NavigationTip.h"
#import "CLTipViewController.h"

@implementation UIViewController (NavigationTip)

+(nonnull UIViewController *)lj_paramsError {
    
    return [CLTipViewController paramsErrorTipController];
}

+(nonnull UIViewController *)lj_notURLController {
    
    return [CLTipViewController notURLTipController];
}

+(nonnull UIViewController *)lj_notFound {
    
    return [CLTipViewController notFoundTipConctroller];
}

@end
