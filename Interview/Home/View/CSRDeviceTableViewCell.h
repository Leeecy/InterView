//
//  CSRDeviceTableViewCell.h
//  Interview
//
//  Created by kiss on 2019/8/17.
//  Copyright © 2019 cl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
extern NSString * const DeviceCellIdentifier;

@interface CSRDeviceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *deviceNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *rssiLevelLabel;
@property (weak, nonatomic) IBOutlet UILabel *serviceCountLabel;
@end

NS_ASSUME_NONNULL_END
