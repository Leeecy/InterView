//
//  HttpTool.m
//  Interview
//
//  Created by cl on 2019/7/20.
//  Copyright © 2019 cl. All rights reserved.
//

#import "HttpTool.h"
#import "NSString+Extension.h"
@implementation HttpTool
-(void)requestWithUrl:(NSString *)apiUrl withMethodType:(NetworkMethod)method withParams:(NSMutableDictionary *)params complate:(Complate)handle failure:(nonnull Failure)failure{
    if (!apiUrl || apiUrl.length <= 0) {
        return;
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    switch (method) {
            case Get:{
                [manager GET:apiUrl parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    handle(responseObject);
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error){
                    NSString *path = task.originalRequest.URL.path;
                    if ([path containsString:@"user"]) {
                        failure([NSString readJson2DicWithFileName:@"user"]);
                        
                    }
                }];
                
                break;}
            case Post:{
                [manager POST:apiUrl parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if (handle) {
                        handle(responseObject);
                    }
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    if (failure) {
                        failure(error);
                    }
                }];
            }
            
        default:
            break;
    }
}
@end
