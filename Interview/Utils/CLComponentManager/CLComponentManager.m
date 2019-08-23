//
//  CLComponentManager.m
//  suanfa
//
//  Created by cl on 2019/7/10.
//  Copyright © 2019 cl. All rights reserved.
//

#import "CLComponentManager.h"
#import "CLConnectorPrt.h"
#import "CLTipViewController.h"
// 全部保存各个模块的connector实例
static NSMutableDictionary<NSString *, id<CLConnectorPrt>> *gConnectorMap = nil;

@implementation CLComponentManager
+(void)registerConnector:(id<CLConnectorPrt>)connector{
    if (![connector conformsToProtocol:@protocol(CLConnectorPrt)]) {
        return;
    }
    
    @synchronized(gConnectorMap) {
        
        if (gConnectorMap == nil){
            
            gConnectorMap = [[NSMutableDictionary alloc] initWithCapacity:5];
        }
        
        NSString *connectorClsStr = NSStringFromClass([connector class]);
        if ([gConnectorMap objectForKey:connectorClsStr] == nil) {
            
            [gConnectorMap setObject:connector forKey:connectorClsStr];
        }
    }
}

+ (nullable UIViewController *)viewControllerForURL:(nonnull NSURL *)URL{
    return [self viewControllerForURL:URL withParameters:nil];
}

+ (nullable UIViewController *)viewControllerForURL:(nonnull NSURL *)URL withParameters:(nullable NSDictionary *)params {
    if(!gConnectorMap || gConnectorMap.count <= 0) return nil;
    
    __block UIViewController *returnObj = nil;
    __block int queryCount = 0;
    NSDictionary *userParams = [self userParametersWithURL:URL andParameters:params];
    

    [gConnectorMap enumerateKeysAndObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSString * _Nonnull key, id<CLConnectorPrt>  _Nonnull connector, BOOL * _Nonnull stop) {
        
        queryCount++;
        if([connector respondsToSelector:@selector(connectToOpenURL:params:)]){
            
            returnObj = [connector connectToOpenURL:URL params:userParams];
            if(returnObj && [returnObj isKindOfClass:[UIViewController class]]){
                
                *stop = YES;
            }
        }
    }];
    
#if DEBUG
    if (!returnObj && queryCount == gConnectorMap.count) {
        [((CLTipViewController *)[UIViewController lj_notFound]) showDebugTipController:URL withParameters:params];
        return nil;
    }
#endif
    
    
    if (returnObj) {
        if ([returnObj isKindOfClass:[CLTipViewController class]]) {
#if DEBUG
            [((CLTipViewController *)returnObj) showDebugTipController:URL withParameters:params];
#endif
            return nil;
        } else if([returnObj class] == [UIViewController class]){
            return nil;
        } else {
            return returnObj;
        }
    }
    
    
    return nil;

}
/**
 * 从url获取query参数放入到参数列表中
 */
+ (NSDictionary *)userParametersWithURL:(nonnull NSURL *)URL andParameters:(nullable NSDictionary *)params {
    
    NSArray *pairs = [URL.query componentsSeparatedByString:@"&"];
    NSMutableDictionary *userParams = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        if (kv.count == 2) {
            
            NSString *key = [kv objectAtIndex:0];
            NSString *value = [self URLDecodedString:[kv objectAtIndex:1]];
            [userParams setObject:value forKey:key];
        }
    }
    [userParams addEntriesFromDictionary:params];
    return [NSDictionary dictionaryWithDictionary:userParams];
}
/**
 * 对url的value部分进行urlDecoding
 */
+ (nonnull NSString *)URLDecodedString:(nonnull NSString *)urlString
{
    NSString *result = urlString;
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_9_0
    result = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                                   (__bridge CFStringRef)urlString,
                                                                                                   CFSTR(""),
                                                                                                   kCFStringEncodingUTF8);
#else
    result = [urlString stringByRemovingPercentEncoding];
#endif
    return result;
}

@end
