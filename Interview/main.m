/***
 MARK:-AFN  AFURLSessionManager :对NSURLSession做一系列封装
 AFURLRequestSerialization 设置request的请求类型，get,post,put...等 2、往request里添加一些参数设置
 
 **/

/* SDWebImage
 1.首先会在 SDWebImageCache 中寻找图片是否有对应的缓存, 它会以url 作为数据的索引先在内存中寻找是否有对应的缓存
 2.如果缓存未找到就会利用通过MD5处理过的key来继续在磁盘中查询对应的数据, 如果找到了, 就会把磁盘中的数据加载到内存中，并将图片显示出来
 3.如果在内存和磁盘缓存中都没有找到，就会向远程服务器发送请求，开始下载图片
 4.下载后的图片会加入缓存中，并写入磁盘中
 5.整个获取图片的过程都是在子线程中执行，获取到图片后回到主线程将图片显示出来
 */

/*
 block：本质就是封装了函数调用的objc对象 首地址是isa结构体指针 __block会导致对象被retain，有可能导致循环引用 用__block 必须在外面要调用block一次  2、block捕获：自动变量的值（基本数据类型-值，对象类型指针-对象地址）；静态变量的地址
 */

/**
 runtime ：运行时 创建OC 类和对象，进行消息发送和转发 1、给系统分类添加属性、方法 2、方法交换 3 获取对象的属性、私有属性 4 kvc kvo 5、字典转模型
 */
/**
 单利：整个系统只需要拥有一个的全局对象、实例唯一 例如做一些配置数据
 */


/**
 @synchronized 操作数据的时候，防止多个操作同时操作一个数据导致数据的错乱或者非即时
 */

/*
 main前优化:1、加载大量动态链接库 2、注册大量Objc类 、初始化类对象 (Objc 的 +load 方法) 3、加载大量分类里的方法 4、加载大量 C++ 静态对象
 main后优化：1、在applicationWillFinishLaunching 执行了 UITabBarController 以及 子控制器的创建，并在 viewDidLoad 方法里执行了大量的耗时操作 2、大量第三方应用的配置和启动项的累积 3、在 UITabBarController 第一个子控制器的 viewWillAppear 方法里执行了大量的耗时操作
 */
//MARK:-tableview优化 1、提前计算并缓存好高度，数据请求下来的时候 计算好高度 2、因为heightForRow最频繁的调用  3、复杂界面时异步绘制  5、复用cell 6、滑动时按需加载图片 7、少用或不用透明图层，使用不透明视图 8、减少subViews 9、少用addView给cell动态添加view，可以初始化的时候就添加，然后通过hide控制是否显示
//viewDidUnload 当发出内存警告调用，释放view=nil
//信号量：dispatch_semaphore_create  并发队列中的任务同步执行
//init->loadView(从nib载入视图)->viewDidLoad->viewWillAppear->viewDidAppear->viewWillDisappear->viewDidDisappear->dealloc

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

CFAbsoluteTime StartTime;

int main(int argc, char * argv[]) {
    StartTime = CFAbsoluteTimeGetCurrent();

    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
