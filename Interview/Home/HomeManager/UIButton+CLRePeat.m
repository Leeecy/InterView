//
//  UIButton+CLRePeat.m
//  suanfa
//
//  Created by cl on 2019/7/5.
//  Copyright © 2019 cl. All rights reserved.
//

#import "UIButton+CLRePeat.h"
#import <objc/runtime.h>
#define defaultInterval 0.2  //默认时间间隔


@implementation UIButton (CLRePeat)
-(NSTimeInterval)timeInterval{
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}
- (void)setTimeInterval:(NSTimeInterval)timeInterval {
    objc_setAssociatedObject(self, @selector(timeInterval), @(timeInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isIgnoreEvent {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setIsIgnoreEvent:(BOOL)isIgnoreEvent {
    objc_setAssociatedObject(self, @selector(isIgnoreEvent), @(isIgnoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originSel = @selector(sendAction:to:forEvent:);
        SEL newSel = @selector(newSendAction:to:forEvent:);
        
        Method originMethod = class_getInstanceMethod(self, originSel);
        Method newMethod = class_getInstanceMethod(self, newSel);

        BOOL isAdd = class_addMethod(self, originSel, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
        if (isAdd) {
            class_replaceMethod(self, newSel, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
        }else {
            method_exchangeImplementations(originMethod, newMethod);
        }
    });
}

-(void)newSendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if ([NSStringFromClass([self class]) isEqualToString:@"CLButton"]) {
        self.timeInterval = (self.timeInterval == 0) ? defaultInterval : self.timeInterval;
        
        if (self.isIgnoreEvent){
//            self.isIgnoreEvent = NO;
            return;
        }else if (self.timeInterval > 0){
            [self performSelector:@selector(resetIsIgnoreEvent) withObject:nil afterDelay:5];
            
//            [self setIsIgnoreEvent:NO];
        }
    }
    
    self.isIgnoreEvent = YES;
    [self newSendAction:action to:target forEvent:event];
}
- (void)resetIsIgnoreEvent{
    [self setIsIgnoreEvent:NO];
}
@end
