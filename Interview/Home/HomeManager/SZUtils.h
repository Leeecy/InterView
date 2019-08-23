//
//  SZUtils.h
//  TrendsCell
//
//  Created by 何松泽 on 2018/3/5.
//  Copyright © 2018年 何松泽. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class SZDataModel;
@interface SZUtils : NSObject

+ (instancetype)shareUtils;

- (NSArray *)getHeightArrayWithDatas:(NSArray <SZDataModel *>*)datas labelWidth:(CGFloat)labelWidth;

@end
