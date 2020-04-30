//
//  TransViewCell.h
//  Interview
//
//  Created by kiss on 2020/4/22.
//  Copyright © 2020 cl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TransViewCell : UITableViewCell
@property (strong, nonatomic) UIImageView *bgimageView;         // 图片
@property (strong, nonatomic) UIView *bgView;                   // 背景
@property (strong, nonatomic) UILabel *titleLabel;              // 主标题
@property (strong, nonatomic) UILabel *contentLabel;            // 副标题

@end

NS_ASSUME_NONNULL_END
