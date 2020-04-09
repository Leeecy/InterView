//
//  GifViewController.m
//  Interview
//
//  Created by kiss on 2019/12/19.
//  Copyright © 2019 cl. All rights reserved.
//

#import "GifViewController.h"
#import "LLGifImageView.h"
//size
#define GifImageWidth 216

@interface GifViewController ()
@property (nonatomic, strong) LLGifImageView *gifImageView;
@end

@implementation GifViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorFromHexStr:@"#212121"];
    UILabel *textL = [[UILabel alloc]initWithFrame:CGRectMake(30, ScreenHeight-64 -20, ScreenHeight -30*2, 40)];
    textL.numberOfLines = 0 ;
    textL.text = NSLocalizedString(@"Make sure the earbud is on and the phone is within 50cm of the earburd.", nil);
    textL.textColor = [UIColor colorWithHexString:@"#5A5A5A"];
    textL.font = [UIFont systemFontOfSize:12];
    textL.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:textL];
   
    
    NSData *localData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"gif" ofType:@"gif"]];
    _gifImageView = [[LLGifImageView alloc] initWithFrame:CGRectMake((ScreenWidth -GifImageWidth)*0.5, 200, GifImageWidth, GifImageWidth)];
    _gifImageView.backgroundColor = [UIColor clearColor];
    _gifImageView.contentMode = UIViewContentModeScaleAspectFit;
     _gifImageView.gifData = localData;
    _gifImageView.speed = 1.5;
    [self.view addSubview:_gifImageView];
    [_gifImageView startGif];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
