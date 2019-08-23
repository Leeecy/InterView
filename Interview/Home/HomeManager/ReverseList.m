//
//  ReverseList.m
//  suanfa
//
//  Created by cl on 2019/4/16.
//  Copyright © 2019 cl. All rights reserved.
//

#import "ReverseList.h"

@implementation ReverseList
void reverChar(char *cha){
    char *begin = cha;
    
    char *end = cha + strlen(cha) -1;
    
    while (begin < end) {
        char temp = *begin;
        *(begin++) = *end;
        *(end--) = temp;
    }
}
@end
