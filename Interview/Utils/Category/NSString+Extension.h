//
//  NSString+Extension.h
//  Interview
//
//  Created by cl on 2019/7/20.
//  Copyright © 2019 cl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Extension)
+(NSDictionary *)readJson2DicWithFileName:(NSString *)fileName;
+(NSString*)compareInt:(NSInteger)left right:(NSInteger)right;
@end

NS_ASSUME_NONNULL_END
