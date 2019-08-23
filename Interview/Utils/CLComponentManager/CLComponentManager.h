//
//  CLComponentManager.h
//  suanfa
//
//  Created by cl on 2019/7/10.
//  Copyright © 2019 cl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIViewController+NavigationTip.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CLConnectorPrt ;


@interface CLComponentManager : NSObject

#pragma mark - 向总控制中心注册挂接点

// connector自load过程中，注册自己
+(void)registerConnector:(nonnull id<CLConnectorPrt>)connector;

// 通过URL获取viewController实例
+ (nullable UIViewController *)viewControllerForURL:(nonnull NSURL *)URL;
+ (nullable UIViewController *)viewControllerForURL:(nonnull NSURL *)URL withParameters:(nullable NSDictionary *)params;
@end

NS_ASSUME_NONNULL_END
