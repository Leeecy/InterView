//
//  CSRDeviceTableViewCell.m
//  Interview
//
//  Created by kiss on 2019/8/17.
//  Copyright © 2019 cl. All rights reserved.
//

#import "CSRDeviceTableViewCell.h"
NSString * const DeviceCellIdentifier = @"deviceCellIdentifier";

@implementation CSRDeviceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.layer.borderColor = [UIColor clearColor].CGColor;
    self.contentView.layer.borderWidth = 1;
    self.contentView.layer.cornerRadius = 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (NSString *)reuseIdentifier {
    return DeviceCellIdentifier;
}
@end
