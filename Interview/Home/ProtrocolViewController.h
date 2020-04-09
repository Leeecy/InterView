//
//  ProtrocolViewController.h
//  Interview
//
//  Created by kiss on 2019/11/21.
//  Copyright © 2019 cl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KSProtocolAlertView : UIView
/**
 弹框内容文本
 */
@property (nonatomic, copy) NSString *contentStr;
@property(nonatomic,assign)BOOL isClick;

@end

@interface ProtrocolViewController : UIViewController

@end

NS_ASSUME_NONNULL_END
