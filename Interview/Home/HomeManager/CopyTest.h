//
//  CopyTest.h
//  suanfa
//
//  Created by cl on 2019/7/6.
//  Copyright © 2019 cl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CopyTest : NSObject
@property (strong, nonatomic) NSArray *bookArray1;
@property (copy, nonatomic) NSArray *bookArray2;

@property (strong, nonatomic) NSString *strStrong;
@property (copy, nonatomic) NSString *strCopy;
@end

NS_ASSUME_NONNULL_END
