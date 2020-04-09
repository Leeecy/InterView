//
//  NSObject+Extension.h
//  Interview
//
//  Created by kiss on 2019/11/5.
//  Copyright © 2019 cl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Extension)
-(int)getTempEqValue:(CGFloat)value firstFloat:(CGFloat)float1 otherFloat:(CGFloat)float2;
-(int)getOffexY:(NSString*)value firstFloat:(CGFloat)float1 otherFloat:(CGFloat)float2;
-(NSString*)getTempStr:(NSString*)str;
@end

NS_ASSUME_NONNULL_END
