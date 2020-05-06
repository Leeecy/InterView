//
//  InterScaleViewController.h
//  HHTransitionDemo
//
//  Created by 豫风 on 2018/4/20.
//  Copyright © 2018年 豫风. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLAddHeaderCollectionCell;
@interface InterScaleViewController : UIViewController

@property (strong, nonatomic) UIImage *bgImage;
@property (strong, nonatomic) NSString *imageName;
@property (strong, nonatomic) NSString *headerName;
@property (strong, nonatomic) NSString *bottomName;
@property(nonatomic,strong)CLAddHeaderCollectionCell *addCell;
@property (strong, nonatomic) NSIndexPath *selectIndexPath;
@end
