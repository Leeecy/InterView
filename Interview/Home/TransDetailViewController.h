//
//  TransDetailViewController.h
//  Interview
//
//  Created by kiss on 2020/4/22.
//  Copyright © 2020 cl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TransDetailViewController : UIViewController
@property (strong, nonatomic) UIImage *bgImage;
@property (strong, nonatomic) NSString *imageName;
@property (strong, nonatomic) NSString *titles;
@property (strong, nonatomic) NSString *titleTwo;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSIndexPath *selectIndexPath;
@end

NS_ASSUME_NONNULL_END
