//
//  TicketManager.m
//  suanfa
//
//  Created by cl on 2019/7/13.
//  Copyright © 2019 cl. All rights reserved.
//

#import "TicketManager.h"

#define Total 50

@interface TicketManager()

@property int tickets; //   剩余票数
@property int saleCount; // 卖出票数

@property (nonatomic, strong) NSThread *threadBJ;
@property (nonatomic, strong) NSThread *threadSH;

@property (nonatomic, strong) NSCondition *ticketCondition;//   加锁的第二种方式
@property (nonatomic, strong) NSLock *ticketLock;
@end


@implementation TicketManager
-(instancetype)init{
    if (self = [super init]) {
        self.tickets = Total;
        self.ticketLock = [[NSLock alloc]init];
    }
    return self;
}

-(void)starToSale{
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_queue_t queue1 = dispatch_queue_create("queue1", DISPATCH_QUEUE_CONCURRENT);

    dispatch_async(queue, ^{
        [self sale];
    });
    dispatch_async(queue1, ^{
        [self sale];
    });
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [self sale];
//    });
//
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [self sale];
//    });
    
//    dispatch_async(dispatch_queue_create("serial1", DISPATCH_QUEUE_SERIAL), ^{
//
//        [self sale];
//    });
//    dispatch_async(dispatch_queue_create("serial", DISPATCH_QUEUE_SERIAL), ^{
//
//        [self sale];
//    });
}

-(void)sale{
    
    while (true) {
//        @synchronized (self) {
//        [_ticketLock lock];
            if (self.tickets > 0) {
                [NSThread sleepForTimeInterval:0.5];
                self.tickets--;
                self.saleCount = Total - self.tickets;
                
                NSLog(@"%@:当前余票:   %d,  售出： %d",[NSThread currentThread].name, self.tickets, self.saleCount);
            }
//        [_ticketLock unlock];

//        }
    }
}
-(void)testNSOperationQueue{
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    NSBlockOperation *bo1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"这是bo1执行的任务 %@",[NSThread currentThread]);
    }];
    NSBlockOperation *bo2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"这是bo2执行的任务 %@",[NSThread currentThread]);
    }];
    NSBlockOperation *bo3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"这是bo3执行的任务 %@",[NSThread currentThread]);
    }];
    //bo1依赖于bo2
    [bo2 addDependency:bo1];
    //bo2依赖于bo3
    [bo3 addDependency:bo2];
    
    [queue addOperations:@[bo1,bo2,bo3] waitUntilFinished:YES];
    
    NSLog(@"如果上面waitUntilFinished是YES，我就会最后执行");
}

@end
