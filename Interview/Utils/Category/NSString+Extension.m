//
//  NSString+Extension.m
//  Interview
//
//  Created by cl on 2019/7/20.
//  Copyright © 2019 cl. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
+(NSDictionary *)readJson2DicWithFileName:(NSString *)fileName {
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    return dic;
}
+(NSString*)compareInt:(NSInteger)left right:(NSInteger)right{
    NSString *result ;
    if (left < right) {
        if (left < 30 && right < 30) {
            result = @"左右";
        }else{
            result = @"左";
        }
        
    }else if (left > right){
        if (left < 30 && right < 30) {
            result = @"左右";
        }else{
            result = @"右";
        }
    }
    return result;
}
@end
