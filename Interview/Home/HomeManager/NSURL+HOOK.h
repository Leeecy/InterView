//
//  NSURL+HOOK.h
//  suanfa
//
//  Created by cl on 2019/7/5.
//  Copyright © 2019 cl. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface NSURL (HOOK)
+(instancetype)cl_URLWithString:(NSString*)url;
@end

NS_ASSUME_NONNULL_END
