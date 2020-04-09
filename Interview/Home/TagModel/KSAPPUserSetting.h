//
//  KSAPPUserSetting.h
//  FastPair
//
//  Created by cl on 2019/7/26.
//  Copyright © 2019 KSB. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KSAPPUserSetting : NSObject
+(instancetype)shareInstance;
@property (assign,nonatomic)BOOL isChinese;
@property (assign,nonatomic)BOOL isShowAlert;//隐私协议
@property(nonatomic,assign)NSInteger customCount;//eq自定义个数
@property(nonatomic,assign)NSArray *customEqFirst;
@property(nonatomic,assign)NSArray *customEqTwo;
@property(nonatomic,assign)NSArray *customEqThree;
@property(nonatomic,assign)NSArray *customEqFour;
@property(nonatomic,assign)NSArray *customEqFive;
@property(nonatomic,assign)BOOL isAddEq;//自定义是第六个按钮时是否被点击
@property(nonatomic,assign)BOOL isFirstEnterEq;//第一次进入EQ界面
@property(nonatomic,assign)NSInteger selectTag;//选中的tag 退出eq之后再重新进来
@property(nonatomic,assign)NSInteger quitTag;//选中的tag 退出eq之后再重新进来
@end

NS_ASSUME_NONNULL_END
