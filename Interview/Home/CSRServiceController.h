//
//  CSRServiceController.h
//  Interview
//
//  Created by kiss on 2019/8/17.
//  Copyright © 2019 cl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTLibrary.h"
#import "GaiaLibrary.h"
NS_ASSUME_NONNULL_BEGIN

@interface CSRServiceController : UITableViewController<CSRConnectionManagerDelegate, CSRUpdateManagerDelegate>
@property (nonatomic) CSRPeripheral *chosenPeripheral;
@end

NS_ASSUME_NONNULL_END
