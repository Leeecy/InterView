//
//  SwitchViewController.h
//  Interview
//
//  Created by kiss on 2019/9/19.
//  Copyright © 2019 cl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SwitchViewController : UITableViewController
@property(nonatomic,copy)void (^vocieTipBlock)(BOOL isOpen);
@end

NS_ASSUME_NONNULL_END
