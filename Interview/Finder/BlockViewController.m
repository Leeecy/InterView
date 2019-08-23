//
//  BlockViewController.m
//  Interview
//
//  Created by cl on 2019/7/19.
//  Copyright © 2019 cl. All rights reserved.
//首先, block是一个对象, 所以block理论上是可以retain/release的. 但是block在创建的时候它的内存是默认是分配在栈(stack)上, 而不是堆(heap)上的. 所以它的作用域仅限创建时候的当前上下文(函数, 方法...), 当你在该作用域外调用该block时, 程序就会崩溃.

/*
 1.一般情况下你不需要自行调用copy或者retain一个block. 只有当你需要在block定义域以外的地方使用时才需要copy. Copy将block从内存栈区移到堆区.
 
 2.其实block使用copy是MRC留下来的也算是一个传统吧, 在MRC下, 如上述, 在方法中的block创建在栈区, 使用copy就能把他放到堆区, 这样在作用域外调用该block程序就不会崩溃.
 
 3.但在ARC下, 使用copy与strong其实都一样, 因为block的retain就是用copy来实现的, 所以block使用copy还能装装逼, 说明自己是从MRC下走过来的
 */

/*
NSStackBlock    存储于栈区
NSGlobalBlock   存储于程序数据区
NSMallocBlock   存储于堆区
 */

/*
 1.没有外部变量的情况下，block属于全局区 globalBlock
 2 有外部变量的情况下
 2.1 无论全局变量、全局静态变量、局部静态变量，block依然在全局区 globalBlock
 2.2 普通外部变量 ，copy、strong修饰的block在堆区mallocBlock，weak修饰的block在栈区stackBlock
 本质:有普通外部变量的block，它创建后就是在栈区，只是copy、strong修饰的block会把它从栈区移动到堆区，而weak不会。
 在arc下copy、strong修饰的block没有区别
 */
#import "BlockViewController.h"

@interface BlockViewController ()
@property (nonatomic, copy) void(^block)();

@end

@implementation BlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =  [UIColor whiteColor];
    [self test1];
    
}

- (void)test1
{
    __block int i = 0;
    void (^block1)() = ^{
        //此处若不引用外部变量i，则block1是静态block，若引用，则为栈block
//        i++;
//        NSLog(@"i = %d",i);
    };
    
    block1();
    
    NSLog(@"%@",block1);
    
    int value = 10;
    void(^blockA)(void) = ^{
        NSLog(@"value: %d",value);
    };
    NSLog(@" block is: %@", blockA);

    
    void(^blockB)(void) = ^{
        NSLog(@"blockB");
    };
    NSLog(@"block is: %@",blockB);
    
    _block = [blockA copy];
    
    NSLog(@"block is: %@",self.block);

}

@end
