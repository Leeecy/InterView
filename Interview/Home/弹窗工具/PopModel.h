//
//  PopModel.h
//  Interview
//
//  Created by kiss on 2020/4/29.
//  Copyright © 2020 cl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 遮罩的类型，有遮罩不能点击遮罩下的事件
 */
typedef NS_ENUM(NSInteger, AlertMaskType) {
    ///没有遮罩
    AlertMaskTypeNone,
    ///黑色遮罩
    AlertMaskTypeBlack,
    ///透明遮罩
    AlertMaskTypeClear
};

@protocol alertPopDelegate <NSObject>

-(void)clickAlert;

-(void)alertisConnecting;
@end
@interface PopModel : NSObject
@property(nonatomic, strong) UIView *maskView;
/**
顶部横幅弹窗
*/
+(PopModel*)sharevView;
+ (void)alertWithMessage:(NSString *)message;
+ (void)alertWithDismiss;
+ (void)alertWithMessage:(NSString *)message maskType:(AlertMaskType)maskType;
@property(weak,nonatomic)id <alertPopDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
