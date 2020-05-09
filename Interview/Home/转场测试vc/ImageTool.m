//
//  ImageTool.m
//  Interview
//
//  Created by kiss on 2020/5/7.
//  Copyright © 2020 cl. All rights reserved.
//

#import "ImageTool.h"

@implementation ImageTool
#pragma mark - 切割UIImageView
+ (void)cuttingImageView:(UIImageView *)imageView cuttingDirection:(UIRectCorner)direction cornerRadii:(CGFloat)cornerRadii borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor backgroundColor:(UIColor *)backgroundColor{
    if (imageView.bounds.size.height != 0 && imageView.bounds.size.width != 0) {
        // 先截取UIImageView视图Layer生成的Image，然后再做渲染
        UIImage * image = nil;
        if (imageView.image) {
            image = imageView.image;
        }
        if (cornerRadii == 0) {
            cornerRadii = imageView.bounds.size.height / 2;
        }
        CGRect rect = CGRectMake(0, 0, imageView.bounds.size.width, imageView.bounds.size.height);
        UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
        CGContextRef currnetContext = UIGraphicsGetCurrentContext();
        if (currnetContext) {
            
            UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:direction cornerRadii:CGSizeMake(cornerRadii - borderWidth, cornerRadii - borderWidth)];
            CGContextAddPath(currnetContext,path.CGPath);
            CGContextClip(currnetContext);
            
            [image drawInRect:rect];
            [borderColor setStroke];// 画笔颜色
            [backgroundColor setFill];// 填充颜色
            [path stroke];
            [path fill];
//            CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathFillStroke);
            image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
        if ([image isKindOfClass:[UIImage class]]) {
            imageView.image = image;
        } else { // UITableViewCell的UIImageView，第一次创建赋图时，可能无法获取UIImageView视图layer的图片
            dispatch_async(dispatch_get_main_queue(), ^{
                [self cuttingImageView:(UIImageView *)imageView cuttingDirection:(UIRectCorner)direction cornerRadii:(CGFloat)cornerRadii borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor backgroundColor:(UIColor *)backgroundColor];
            });
        }
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self cuttingImageView:(UIImageView *)imageView cuttingDirection:(UIRectCorner)direction cornerRadii:(CGFloat)cornerRadii borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor backgroundColor:(UIColor *)backgroundColor];
        });
    }
}
@end
