//
//  CommomSuperFind.h
//  suanfa
//
//  Created by cl on 2019/4/16.
//  Copyright © 2019 cl. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface CommomSuperFind : NSObject
-(UIView*)findCommonSuperView:(UIView*)view other:(UIView*)viewOther;
- (UIView *)searchSuperView2:(UIView *)viewA andClass:(UIView *)viewB;
@end


NS_ASSUME_NONNULL_END
