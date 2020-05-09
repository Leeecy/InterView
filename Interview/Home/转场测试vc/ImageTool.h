//
//  ImageTool.h
//  Interview
//
//  Created by kiss on 2020/5/7.
//  Copyright © 2020 cl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageTool : NSObject
/** 切割UIImageView圆角
 * @param imageView 需要进行切割的对象
 * @param direction 切割的方向
 * @param cornerRadii 圆角半径
 * @param borderWidth 边框宽度
 * @param borderColor 边框颜色
 * @param backgroundColor 背景色
 */
+ (void)cuttingImageView:(UIImageView *)imageView cuttingDirection:(UIRectCorner)direction cornerRadii:(CGFloat)cornerRadii borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor backgroundColor:(UIColor *)backgroundColor;
@end

NS_ASSUME_NONNULL_END
