//
//  CLTagsModel.h
//  Interview
//
//  Created by kiss on 2019/12/9.
//  Copyright © 2019 cl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLTagsModel : NSObject
@property (strong, nonatomic, nullable) UIColor *bgColor;

@property(nonatomic,strong,nullable) UIColor *slcColor;
@property(nonatomic,strong,nullable)UIColor *nrmColor;
@property (strong, nonatomic, nullable) UIColor *normalTitleColor;
@property(nonatomic,strong,nullable)UIColor *selectTitleColor;
@property(nonatomic,strong,nullable) UIImage *selectImg;
@property(nonatomic,strong,nullable)UIImage *normalImg;
@property(nonatomic,assign)BOOL isAddNewBtn;//添加了新eq
@property(nonatomic,assign)BOOL isAddLastBtn;//添加最后一个Button
@end

NS_ASSUME_NONNULL_END
