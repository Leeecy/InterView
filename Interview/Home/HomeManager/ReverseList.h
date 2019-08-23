//
//  ReverseList.h
//  suanfa
//
//  Created by cl on 2019/4/16.
//  Copyright © 2019 cl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

struct Node {
    int data;
    struct Node *next;
};
@interface ReverseList : NSObject
struct Node* reverseList (struct Node *head);

void reverChar(char *cha);

@end

NS_ASSUME_NONNULL_END
