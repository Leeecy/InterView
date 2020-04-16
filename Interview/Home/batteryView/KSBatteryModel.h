//
//  KSBatteryModel.h
//  Interview
//
//  Created by kiss on 2020/4/11.
//  Copyright © 2020 cl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KSBatteryModel : NSObject
@property(nonatomic,strong)NSString *batteryL;//左边电池电量
@property(nonatomic,strong)NSString *batteryR;
@property(nonatomic,strong)NSString *headerName;//耳机名字
@property(nonatomic,strong)NSString *headerImgName;//耳机图片名字
@end

NS_ASSUME_NONNULL_END
