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

@interface CLAddHeaderCollectionCell : UICollectionViewCell
@property(nonatomic,strong)KSBatteryModel *batteryM;
@end

NS_ASSUME_NONNULL_END
