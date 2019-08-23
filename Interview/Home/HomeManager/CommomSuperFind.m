//
//  CommomSuperFind.m
//  suanfa
//
//  Created by cl on 2019/4/16.
//  Copyright © 2019 cl. All rights reserved.
//

#import "CommomSuperFind.h"

@implementation CommomSuperFind
-(UIView*)findCommonSuperView:(UIView *)view other:(UIView *)viewOther{
//    NSMutableArray *result = [NSMutableArray array];
    NSArray *arrOne = [self findSuperView:view];
    NSArray *arrTwo = [self findSuperView:viewOther];
    __block UIView * classResult = nil;
    [arrOne enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        for (NSUInteger i = 0; i <arrTwo.count; ++i) {
            if (obj == arrTwo[i]) {
                classResult = obj;
                NSLog(@"Common SuperView=%@",[obj description]);
                *stop = YES;
            }
        }
    }];
    return classResult;
}

-(NSArray*)findSuperView:(UIView*)view{
    if (view == nil) {
        return @[];
    }
    
    UIView *temp = view.superview;
    
    NSMutableArray *result  = [NSMutableArray array];
    
    while (temp) {
        [result addObject:temp];
        temp = temp.superview;
    }
    
    return result;
}

- (UIView *)searchSuperView2:(UIView *)viewA andClass:(UIView *)viewB {
    NSArray *arr1 = [self findSuperView:viewA];
    NSArray *arr2 = [self findSuperView:viewB];
    NSSet *set = [NSSet setWithArray:arr2];
    __block UIView *  classResult = nil;
    
    [arr1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([set containsObject:obj]) {
            NSLog(@"Common SuperView=%@",[obj description]);
            classResult = obj;
            *stop = YES;
        }
    }];
    return classResult;
}




@end
