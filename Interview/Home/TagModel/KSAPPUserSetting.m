//
//  KSAPPUserSetting.m
//  FastPair
//
//  Created by cl on 2019/7/26.
//  Copyright © 2019 KSB. All rights reserved.
//

#import "KSAPPUserSetting.h"

@implementation KSAPPUserSetting

+(instancetype)shareInstance{
    static KSAPPUserSetting *setting = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        setting = [[self alloc]init];
    });
    return setting;
}
- (void)save{
    [[NSUserDefaults standardUserDefaults]synchronize];
}





-(void)setCustomCount:(NSInteger)customCount{
    [[NSUserDefaults standardUserDefaults]setInteger:customCount forKey:@"customCount"];
    [self save];
}
-(NSInteger)customCount{
    return [[NSUserDefaults standardUserDefaults]integerForKey:@"customCount"];
}


-(BOOL )isAddEq{
    return [[NSUserDefaults standardUserDefaults]boolForKey:@"isAddEq"];
    
}
-(void)setIsAddEq:(BOOL)isAddEq{
    [[NSUserDefaults standardUserDefaults]setBool:isAddEq forKey:@"isAddEq"];
    [self save];
}

-(void)setCustomEqFirst:(NSArray *)customEqFirst{
    [[NSUserDefaults standardUserDefaults]setObject:customEqFirst forKey:@"customEqFirst"];
    [self save];
}
-(NSArray *)customEqFirst{
     return [[NSUserDefaults standardUserDefaults]objectForKey:@"customEqFirst"];
}

-(void)setCustomEqTwo:(NSArray *)customEqTwo{
    [[NSUserDefaults standardUserDefaults]setObject:customEqTwo forKey:@"customEqTwo"];
    [self save];
}
-(NSArray *)customEqTwo{
     return [[NSUserDefaults standardUserDefaults]objectForKey:@"customEqTwo"];
}

-(void)setCustomEqThree:(NSArray *)customEqThree{
    [[NSUserDefaults standardUserDefaults]setObject:customEqThree forKey:@"customEqThree"];
    [self save];
}
-(NSArray *)customEqThree{
     return [[NSUserDefaults standardUserDefaults]objectForKey:@"customEqThree"];
}

-(void)setCustomEqFour:(NSArray *)customEqFour{
    [[NSUserDefaults standardUserDefaults]setObject:customEqFour forKey:@"customEqFour"];
    [self save];
}
-(NSArray *)customEqFour{
     return [[NSUserDefaults standardUserDefaults]objectForKey:@"customEqFour"];
}

-(void)setCustomEqFive:(NSArray *)customEqFive{
    [[NSUserDefaults standardUserDefaults]setObject:customEqFive forKey:@"customEqFive"];
    [self save];
}
-(NSArray *)customEqFive{
     return [[NSUserDefaults standardUserDefaults]objectForKey:@"customEqFive"];
}
-(void)setIsFirstEnterEq:(BOOL)isFirstEnterEq{
    [[NSUserDefaults standardUserDefaults]setBool:isFirstEnterEq forKey:@"isFirstEnterEq"];
    [self save];
}
-(BOOL)isFirstEnterEq{
    return [[NSUserDefaults standardUserDefaults]boolForKey:@"isFirstEnterEq"];
}
-(void)setSelectTag:(NSInteger)selectTag{
    [[NSUserDefaults standardUserDefaults] setInteger:selectTag forKey:@"selectTag"];
    [self save];
}
-(NSInteger)selectTag{
     return [[NSUserDefaults standardUserDefaults]integerForKey:@"selectTag"];
}
-(void)setQuitTag:(NSInteger)quitTag{
    [[NSUserDefaults standardUserDefaults] setInteger:quitTag forKey:@"quitTag"];
    [self save];
}
-(NSInteger)quitTag{
     return [[NSUserDefaults standardUserDefaults]integerForKey:@"quitTag"];
}
@end
