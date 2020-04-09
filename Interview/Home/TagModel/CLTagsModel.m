//
//  CLTagsModel.m
//  Interview
//
//  Created by kiss on 2019/12/9.
//  Copyright © 2019 cl. All rights reserved.
//

#import "CLTagsModel.h"

@implementation CLTagsModel
- (instancetype)init {
    self = [super init];
    if (self) {
        self.normalTitleColor = [UIColor colorWithHexString:@"#707070"];
        self.selectTitleColor = [UIColor colorWithHexString:@"#E47D2A"];
        self.selectImg = [UIImage imageNamed:@"圆角矩形 8 拷贝 8"];
        self.normalImg = [UIImage imageNamed:@"常规"];
    }
    return self;
}

@end
