//
//  KSEQSliderViewController.h
//  FastPair
//
//  Created by kiss on 2019/10/8.
//  Copyright © 2019 KSB. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol KSEQSliderViewDelegate <NSObject>

-(void)sendSliderValue:(NSArray*)arr tag:(NSInteger)tag;
-(void)sendSliderReset:(NSArray*)resetArr;
-(void)bypassReset;
@end


@interface KSEQSliderViewController : BaseViewController
@property(nonatomic,strong)NSString *eqValue;
@property(nonatomic,assign)id <KSEQSliderViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
