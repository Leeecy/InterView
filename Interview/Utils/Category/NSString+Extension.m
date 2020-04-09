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

/**
 十进制转换十六进制
 
 @param decimal 十进制数
 @return 十六进制数
 */
+ (NSString *)getHexByDecimal:(NSInteger)decimal {
    char *hexChar = ultostr(decimal, 16);
    NSString *hex = [NSString stringWithUTF8String:hexChar];
    return hex;
}
+(NSString *)to10:(NSString *)num{
    NSString *result = [NSString stringWithFormat:@"%ld", strtoul([num UTF8String],0,16)];
    return result;
}
//转换成十六进制
+ (NSString *)to16:(int)num{
    NSString *result = [NSString stringWithFormat:@"%@",[[NSString alloc] initWithFormat:@"%1x",num]];
    if ([result length] < 2) {
        result = [NSString stringWithFormat:@"0%@", result];
    }
    return result;
}
/**
 无符号长整型转C字符串
 
 @param num 无符号长整型
 @param base 进制 2~36
 @return C字符串
 */
char *ultostr(unsigned long num, unsigned base) {
    static char string[64] = {'\0'};
    size_t max_chars = 64;
    char remainder;
    int sign = 0;
    if (base < 2 || base > 36) {
        return NULL;
    }
    for (max_chars --; max_chars > sign && num != 0; max_chars --) {
        remainder = (char)(num % base);
        if ( remainder <= 9 ) {
            string[max_chars] = remainder + '0';
        } else {
            string[max_chars] = remainder - 10 + 'A';
        }
        num /= base;
    }
    if (max_chars > 0) {
        memset(string, '\0', max_chars + 1);
    }
    return string + max_chars + 1;
}
// 获取当前时间戳
+(NSString *)getCurrentTimestamp {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0]; // 获取当前时间0秒后的时间
    NSTimeInterval time = [date timeIntervalSince1970];// *1000 是精确到毫秒(13位),不乘就是精确到秒(10位)
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}

+(NSString*)CBUUIDToString:(CBUUID*)cbuuid{
    NSData* data = cbuuid.data;
    if ([data length] == 2)
    {
    const unsigned char *tokenBytes = [data bytes];
    return [NSString stringWithFormat:@"%02x%02x", tokenBytes[0], tokenBytes[1]];
    }
    else if ([data length] == 16)
    {
    NSUUID* nsuuid = [[NSUUID alloc] initWithUUIDBytes:[data bytes]];
    return [nsuuid UUIDString];
    }
    return [cbuuid description]; // an error?
}

@end
