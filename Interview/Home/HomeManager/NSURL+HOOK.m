//
//  NSURL+HOOK.m
//  suanfa
//
//  Created by cl on 2019/7/5.
//  Copyright © 2019 cl. All rights reserved.
//

#import "NSURL+HOOK.h"
#import <objc/runtime.h>
@implementation NSURL (HOOK)
//+(void)load{
//    Method urlWithStr =  class_getClassMethod(self, @selector(URLWithString:));
//    Method cl_urlWithStr = class_getClassMethod(self, @selector(cl_URLWithString:));
//    method_exchangeImplementations(urlWithStr, cl_urlWithStr);
//}
//+(instancetype)cl_URLWithString:(NSString *)url{
//    NSURL *url1 = [NSURL cl_URLWithString:url];
//    if (url1 == nil) {
//        NSLog(@"空");
//    }
//    return url1;
//}
@end
