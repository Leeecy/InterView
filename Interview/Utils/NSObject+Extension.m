//
//  NSObject+Extension.m
//  Interview
//
//  Created by kiss on 2019/11/5.
//  Copyright © 2019 cl. All rights reserved.
//

#import "NSObject+Extension.h"


@implementation NSObject (Extension)
-(int)getTempEqValue:(CGFloat)value firstFloat:(CGFloat)float1 otherFloat:(CGFloat)float2 {
    
    CGFloat sub = float1 - float2;
    
    CGFloat floa1 = round(value*sub/(292-8)) ;
    CGFloat floa2 = round(292*sub/(292-8) -float1);
    return floa1 - floa2;
}

-(int)getOffexY:(NSString*)value firstFloat:(CGFloat)float1 otherFloat:(CGFloat)float2 {
    
//    CGFloat sub = float1 - float2;
//    CGFloat floa1 = round(value*(292-8)/sub) ;
//    CGFloat floa2 = round(292 -float1*(292-8)/sub);
//    return  floa1 + floa2;
    CGFloat value1 = [self input0x16String:value];
           CGFloat floa1 = round(value1*71/5) ;
           //CGFloat floa2 = round(292 -12*71/12);//计算-36到12
           CGFloat floa2 = round(292 -10*71/5);
           return  floa1 + floa2;
}
- (int)input0x16String:(NSString *)string{
    char *_0x16String = (char *)string.UTF8String;
    NSMutableString *binaryString = [[NSMutableString alloc] init];
    for (int i = 0; i < string.length; i++) {
        char c = _0x16String[i];
        NSString *binary = [self binaryWithHexadecimal:[NSString stringWithFormat:@"%c",c]];
        [binaryString appendString:binary];
    }
    
    if ([binaryString characterAtIndex:0] == '1') {
        //反码
        for (int i = (int)binaryString.length - 1; i > 0; i--) {
            char c = [binaryString characterAtIndex:i];
            c = c^0x1;
            [binaryString replaceCharactersInRange:NSMakeRange(i, 1) withString:[NSString stringWithFormat:@"%c",c]];
        }
        
        //补码
        BOOL flag = NO; //进位
        NSInteger lastIndex = binaryString.length - 1;
        char lastChar = [binaryString characterAtIndex:lastIndex];
        if (lastChar == '0') {
            lastChar = '1';
        } else {
            lastChar = '0';
            flag = YES;
        }
        
        [binaryString replaceCharactersInRange:NSMakeRange(lastIndex, 1) withString:[NSString stringWithFormat:@"%c",lastChar]];
        
        if (flag) {
            for (int i = (int)binaryString.length - 2; i > 0; i--) {
                char c = [binaryString characterAtIndex:i];
                if (flag) {//进位
                    if (c == '0') {
                        c = '1';
                        flag = NO;
                        [binaryString replaceCharactersInRange:NSMakeRange(i, 1) withString:[NSString stringWithFormat:@"%c",c]];
                        break;
                    } else if (c == '1'){
                        c = '0';
                        flag = YES;
                        [binaryString replaceCharactersInRange:NSMakeRange(i, 1) withString:[NSString stringWithFormat:@"%c",c]];
                    }
                }
            }
        }
    }
    
    int result = 0;
    int bit = 0;
    //计算
    for (int i = (int)binaryString.length - 1; i > 0; i--) {
        char c = [binaryString characterAtIndex:i];
        if (c == '1') {
            result += pow(2, bit);
        }
        ++bit;
    }
    if ([binaryString characterAtIndex:0] == '1') {
        result = result *-1;
    }
    return result;
}

-(NSString *)binaryWithHexadecimal:(NSString *)string{
    // 现将16进制转换车无符号的10进制
    long a = strtoul(string.UTF8String, NULL, 16);
    NSMutableString *binary = [[NSMutableString alloc] init];
    while (a/2 !=0) {
        [binary insertString:[NSString stringWithFormat:@"%ld",a%2] atIndex:0];
        a = a/2;
    }
    
    [binary insertString:[NSString stringWithFormat:@"%ld",a%2] atIndex:0];
    
    //不够4位的高位补0
    while (binary.length%4 !=0) {
        [binary insertString:@"0" atIndex:0];
    }
    return binary;
}
-(NSString*)getTempStr:(NSString*)str{
    if ([[str substringFromIndex:str.length -4] isEqualToString:@"_ble"] ||[[str substringFromIndex:str.length -4] isEqualToString:@"_BLE"]) {
        str = [str substringToIndex:str.length-4];
        if ([str containsString:@"R"]) {
            str = @"TE-D01g_R";
        }else if ([str containsString:@"L"]){
            str = @"TE-D01g_L";
        }
    }
    return str;
}
@end
