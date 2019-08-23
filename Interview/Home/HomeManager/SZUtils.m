//
//  SZUtils.m
//  TrendsCell
//
//  Created by 何松泽 on 2018/3/5.
//  Copyright © 2018年 何松泽. All rights reserved.
//

#import "SZUtils.h"
#import "SZDataModel.h"

@implementation SZUtils

+ (instancetype)shareUtils
{
    static SZUtils *utils = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        utils = [[SZUtils alloc] init];
    });
    return utils;
}

#pragma mark - 根据数据获取高度数组
- (NSArray *)getHeightArrayWithDatas:(NSArray <SZDataModel *>*)datas labelWidth:(CGFloat)labelWidth
{
    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
    for (int index = 0;index < datas.count;index++) {
        SZDataModel *model = datas[index];
        CGFloat labelHeight = [[SZUtils shareUtils] getLabelHeightWithWidth:labelWidth content:model.content];
        [tempArr addObject:[NSNumber numberWithFloat:labelHeight]];
    }
    return [tempArr copy];
}

- (CGFloat)getLabelHeightWithWidth:(CGFloat)width content:(NSString *)content
{
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:12.f]};
    CGRect labelSize = [content boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return labelSize.size.height;
}

@end
