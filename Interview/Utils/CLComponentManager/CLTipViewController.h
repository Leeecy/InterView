

#import <UIKit/UIKit.h>

@interface CLTipViewController : UIViewController

@property (nonatomic, readonly) BOOL isparamsError;
@property (nonatomic, readonly) BOOL isNotURLSupport;
@property (nonatomic, readonly) BOOL isNotFound;

+ (nonnull UIViewController *)paramsErrorTipController;

+ (nonnull UIViewController *)notURLTipController;

+ (nonnull UIViewController *)notFoundTipConctroller;

- (void)showDebugTipController:(nonnull NSURL *)URL
               withParameters:(nullable NSDictionary *)parameters;

@end
