//
//  HttpTool.h
//  Interview
//
//  Created by cl on 2019/7/20.
//  Copyright © 2019 cl. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    Get = 0,
    Post,
    Put,
    Delete
} NetworkMethod;
typedef void(^Complate)(id data);

typedef void(^Failure)(id data);
NS_ASSUME_NONNULL_BEGIN

@interface HttpTool : NSObject
-(void)requestWithUrl:(NSString *)apiUrl withMethodType:(NetworkMethod)method withParams:(NSMutableDictionary *)params complate:(Complate)handle failure:(Failure)failure;
@end

NS_ASSUME_NONNULL_END
