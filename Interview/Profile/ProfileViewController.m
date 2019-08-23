//
//  ProfileViewController.m
//  Interview
//
//  Created by cl on 2019/7/20.
//  Copyright © 2019 cl. All rights reserved.
//

#import "ProfileViewController.h"
#import "HoverViewFlowLayout.h"
#import "UserInfoHeader.h"
#import "User.h"
#import "NSString+Extension.h"
#import "ChatListController.h"
#define kUserInfoHeaderHeight          350 + SafeAreaTopHeight
#define kSlideTabBarHeight             40
NSString * const kUserInfoCell         = @"UserInfoCell";

@interface ProfileViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIViewControllerTransitioningDelegate,UIScrollViewDelegate,OnTabTapActionDelegate,UserInfoDelegate>
@property (nonatomic, copy) NSString              *uid;
@property (nonatomic, assign) CGFloat             itemWidth;
@property (nonatomic, assign) CGFloat             itemHeight;
@property (nonatomic, strong) UserInfoHeader      *userInfoHeader;
@property (nonatomic, strong) User                *user;
@property (nonatomic, assign) NSInteger           tabIndex;



@end

@implementation ProfileViewController

-(instancetype)init{
    self = [super init];
    if (self) {
        _uid = @"9703528";
        _tabIndex = 0;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCollectionView];
    [self loadUserData];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavigationBarTitleColor:ColorClear];
    [self setNavigationBarBackgroundColor:ColorClear];
    [self setStatusBarBackgroundColor:ColorClear];
    [self setStatusBarHidden:NO];
}
-(void)loadUserData{
//    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
//    [params setValue:_uid forKey:@"uid"];
//    NSString *url = [NSString stringWithFormat:@"%@user",BaseUrl];
//    [[HttpTool new] requestWithUrl:url withMethodType:Get withParams:params complate:^(id data) {
//
//    } failure:^(id data) {
//        NSLog(@"data--%@",data);
//    }];
    
    NSDictionary *dic =  [NSString readJson2DicWithFileName:@"user"];
    self.user = [User mj_objectWithKeyValues:dic[@"data"]];
    [self setTitle:self.user.nickname];
    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];


}
-(void)initCollectionView{
    _itemWidth = (ScreenWidth - (CGFloat)(((NSInteger)(ScreenWidth)) % 3) ) / 3.0f - 1.0f;
    _itemHeight = _itemWidth * 1.35f;
    HoverViewFlowLayout *layout = [[HoverViewFlowLayout alloc] initWithTopHeight:SafeAreaTopHeight + kSlideTabBarHeight];
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 0;
    _collectionView = [[UICollectionView  alloc]initWithFrame:ScreenFrame collectionViewLayout:layout];
    _collectionView.backgroundColor = ColorClear;
    if (@available(iOS 11.0, *)) {
        _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.showsVerticalScrollIndicator = NO;
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[UserInfoHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kUserInfoCell];
    [self.view addSubview:_collectionView];

}
//MARK:-UICollectionViewDataSource Delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0 && kind == UICollectionElementKindSectionHeader) {
        UserInfoHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kUserInfoCell forIndexPath:indexPath];
        _userInfoHeader = header;
        if(_user) {
            [header initData:_user];
            header.delegate = self;
            header.slideBar.delegate = self;
        }
        

        
        return header;
    }
    return [UICollectionReusableView new];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(section == 1) {
        return 0;//return _tabIndex == 0 ? _workAwemes.count : _favoriteAwemes.count;
    }
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    AwemeCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kAwemeCollectionCell forIndexPath:indexPath];
//    Aweme *aweme;
//    if(_tabIndex == 0) {
//        aweme = [_workAwemes objectAtIndex:indexPath.row];
//    }else {
//        aweme = [_favoriteAwemes objectAtIndex:indexPath.row];
//    }
//    [cell initData:aweme];
    return nil;
}
//MARK:-UICollectionFlowLayout Delegate
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if(section == 0) {
        return CGSizeMake(ScreenWidth, kUserInfoHeaderHeight);
    }
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return  CGSizeMake(_itemWidth, _itemHeight);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
//    NSLog(@"offset---    %lf",offsetY);
    if (offsetY < 0) {
        [_userInfoHeader overScrollAction:offsetY];
    }else{
        [_userInfoHeader scrollToTopAction:offsetY];

    }
}
-(void)onUserActionTap:(NSInteger)tag{
    switch (tag) {
            case UserInfoHeaderAvatarTag:{
                
            }break;
            case UserInfoHeaderSendTag://聊天
            [self.navigationController pushViewController:[[ChatListController alloc] init] animated:YES];
            break;
            case UserInfoHeaderFocusCancelTag:
            case UserInfoHeaderFocusTag:{
                if(_userInfoHeader) {
                    [_userInfoHeader startFocusAnimation];
                }
            }break;
            
        default:
            break;
    }
}
-(void)onTabTapAction:(NSInteger)index{
    if (_tabIndex == index) {
        return;
    }
    _tabIndex = index;
    [UIView setAnimationsEnabled:NO];

}
@end
