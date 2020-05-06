//
//  CLAddHeaderCollectionCell.h
//  Interview
//
//  Created by cl on 2020/3/16.
//  Copyright © 2020 cl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KSBatteryModel;
NS_ASSUME_NONNULL_BEGIN
#define identifier_CLAddHeaderCollectionCell @"CLAddHeaderCollectionCell"
@class CLAddHeaderCollectionCell;
@protocol CLAddHeaderCellDelegate <NSObject>
- (void)cellDidClick:(CLAddHeaderCollectionCell *)cell;
@end

@interface CLAddHeaderCollectionCell : UICollectionViewCell
@property(nonatomic,strong)KSBatteryModel *batteryM;
@property (strong , nonatomic)UIImageView *bgImage;
@property(nonatomic,copy)NSArray *imageArr;
@property(strong,nonatomic)UILabel *headerName;
@property(strong,nonatomic)UIImageView *headerImg;
@property (nonatomic , weak) id<CLAddHeaderCellDelegate>delegate;
//@property (nonatomic, weak) CLAddHeaderCollectionCell *cell;
@end

NS_ASSUME_NONNULL_END
