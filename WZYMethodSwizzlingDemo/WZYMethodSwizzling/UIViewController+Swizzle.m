//
//  UIViewController+Swizzle.m
//  BPB
//
//  Created by CoderZYWang on 2017/1/17.
//  Copyright © 2017年 CoderZYWang. All rights reserved.
//

/*
 打印结果：
 如果实现了系统自带的原本方法：
 2017-01-17 17:34:51.529 WZYMethodSwizzling[3465:1595265] 1 - button click
 2017-01-17 17:34:51.539 WZYMethodSwizzling[3465:1595265] WZY---viewWillDisappear: <ViewController: 0x145dabd00>
 2017-01-17 17:34:52.058 WZYMethodSwizzling[3465:1595265] ViewController --- viewDidDisappear
 2017-01-17 17:34:57.513 WZYMethodSwizzling[3465:1595265] 2 - button click
 2017-01-17 17:34:57.516 WZYMethodSwizzling[3465:1595265] WZY---viewWillDisappear: <WZYViewController: 0x145e306b0>
 2017-01-17 17:34:58.021 WZYMethodSwizzling[3465:1595265] WZYViewController --- viewDidDisappear
 
 如果没有实现系统自带的原本方法：
 2017-01-17 18:07:46.438 WZYMethodSwizzling[3477:1603073] 1 - button click
 2017-01-17 18:07:46.448 WZYMethodSwizzling[3477:1603073] WZY---viewWillDisappear: <ViewController: 0x13d5a49b0>
 2017-01-17 18:07:47.171 WZYMethodSwizzling[3477:1603073] 2 - button click
 2017-01-17 18:07:47.174 WZYMethodSwizzling[3477:1603073] WZY---viewWillDisappear: <WZYViewController: 0x13d62c160>
 */

#import "UIViewController+Swizzle.h"

// 必须导入头文件
#import <objc/runtime.h>

@implementation UIViewController (Swizzle)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
     
        /** 原始方法获取 */
        Method originalMethod = class_getInstanceMethod([self class], @selector(viewWillDisappear:));
        /** 替换方法 */
        Method exchangeMethod = class_getInstanceMethod([self class], @selector(WZY_viewWillDisappear:));
        
        /*
         *  判断 self 是否包含方法 viewWillDisappear: ，若该类中包含该方法则返回 NO，反之返回 YES
         *
         *  参数一 被添加方法的类 self
         *  参数二 方法名 viewWillDisappear:
         *  参数三 实现这个方法的函数 exchangeMethod（指针指向）
         *  参数四 方法 exchangeMethod 的参数和返回值的描述的字串
         */
        BOOL didAddMethod = class_addMethod([self class], @selector(viewWillDisappear:), method_getImplementation(exchangeMethod), method_getTypeEncoding(exchangeMethod));
        
        if (didAddMethod) { // self 中没有该方法
            
            // 注意：一定要对该方法在该类中是否存在进行判断。如果我们替换的不是系统的方法，而是自定义的方法A。该类是有实现方法A的，但是该类的子类不一定实现了方法A。所以说如果在该类的子类中进行方法交换，那么一旦子类没有实现该方法，就会强行去父类中去寻找该方法进行方法交换，这样就违背了我们的本意而随意篡改了父类的方法。
            
            // 原本该方法的作用是什么，就让原始方法的实现去指向这个改方法的名称（替换该方法的指针）
            class_replaceMethod([self class],
                                @selector(viewWillDisappear:),
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else { // self 中包含该方法
           
            // 原本存在该方法，那么就让两个方法交换实现函数的指针指向
            method_exchangeImplementations(originalMethod, exchangeMethod);
        }
    });
}

#pragma mark - Method Swizzling
- (void)WZY_viewWillDisappear:(BOOL)animated {
    [self WZY_viewWillDisappear:animated];
    NSLog(@"WZY---viewWillDisappear: %@", self);
}

@end
