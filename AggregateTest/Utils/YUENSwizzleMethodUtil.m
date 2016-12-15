//
//  YUENSwizzleMethodUtil.m
//  AggregateTest
//
//  Created by 袁峥 on 16/9/23.
//  Copyright © 2016年 YUEN. All rights reserved.
//

#import "YUENSwizzleMethodUtil.h"
#import <objc/runtime.h>
#import "AppDelegate.h"

@implementation YUENSwizzleMethodUtil

+ (void)swizzleMethodWithOriginalClass:(Class)originalClass
                         swizzledClass:(Class)swizzledClass
                           originalSel:(SEL)originalSel
                           swizzledSel:(SEL)swizzledSel
                      isInstanceMethod:(BOOL)isInstanceMethod
{
    Method __originalMethod = class_getInstanceMethod(originalClass, originalSel);
    Method __swizzledMethod;
    if (isInstanceMethod) {
        __swizzledMethod = class_getInstanceMethod(swizzledClass, swizzledSel);
    }
    else{
        __swizzledMethod = class_getClassMethod(swizzledClass, swizzledSel);
    }
    
    BOOL __didAddMethod = class_addMethod(originalClass, originalSel, method_getImplementation(__swizzledMethod), method_getTypeEncoding(__swizzledMethod));
    if (__didAddMethod) {
        if (__originalMethod) {
            class_replaceMethod(swizzledClass, swizzledSel, method_getImplementation(__originalMethod), method_getTypeEncoding(__originalMethod));
        }
        
    }else{
        method_exchangeImplementations(__originalMethod, __swizzledMethod);
    }
}
@end


#pragma mark - YUENSwizzleMethodUtilTest_1
@implementation YUENSwizzleMethodUtilTest_1

/**
 * 测试入口
 */
+ (void)configureSwizzle
{
    [YUENSwizzleMethodUtil swizzleMethodWithOriginalClass:[AppDelegate class] swizzledClass:[YUENSwizzleMethodUtilTest_1 class] originalSel:@selector(applicationDidEnterBackground:) swizzledSel:@selector(iWannaGetApplicationDidEnterBackground:) isInstanceMethod:false];
}


/**
 * 在 applicationDidEnterBackground: 被调用时候，
 * 需要本类 iWannaGetApplicationDidEnterBackground: 被调用，
 * 且 AppDelegate 中的方法依然要执行。
 *
 * ⚠️只能使用静态方法，或单例的实例方法去实现，因为要在被替换方法中，
 * 重新调用原来的方法（其实就是替换后的此类的方法）,
 * 此时 self 以是原本的被替换方法所在类的对象，无法调到此类的实例方法。
 *
 * 🌰举例：
 *
 * [[YUENSwizzleMethodUtilTest_1  sharedInstance] iWannaGetApplicationDidEnterBackground:]
 *
 * [YUENSwizzleMethodUtilTest_1 iWannaGetApplicationDidEnterBackground:]
 */
+ (void)iWannaGetApplicationDidEnterBackground:(UIApplication *)application
{
    NSLog(@"🔄 iWannaGetApplicationDidEnterBackground:(YUENSwizzleMethodUtilTest_1)");
    [YUENSwizzleMethodUtilTest_1 iWannaGetApplicationDidEnterBackground:application];
}

@end


#pragma mark - YUENSwizzleMethodUtilTest_2
@implementation YUENSwizzleMethodUtilTest_2

/**
 * 测试入口
 */
+ (void)configureSwizzle
{
    [YUENSwizzleMethodUtil swizzleMethodWithOriginalClass:[AppDelegate class] swizzledClass:[YUENSwizzleMethodUtilTest_2 class] originalSel:@selector(applicationDidEnterBackground:) swizzledSel:@selector(iWannaGetApplicationDidEnterBackground:) isInstanceMethod:false];
}


/**
 * 在 applicationDidEnterBackground: 被调用时候，
 * 需要本类 iWannaGetApplicationDidEnterBackground: 被调用，
 * 且 AppDelegate 中的方法依然要执行。
 *
 * ⚠️只能使用静态方法，或单例的实例方法去实现，因为要在被替换方法中，
 * 重新调用原来的方法（其实就是替换后的此类的方法）,
 * 此时 self 以是原本的被替换方法所在类的对象，无法调到此类的实例方法。
 *
 * 🌰举例：
 *
 * [[YUENSwizzleMethodUtilTest_1  sharedInstance] iWannaGetApplicationDidEnterBackground:]
 *
 * [YUENSwizzleMethodUtilTest_1 iWannaGetApplicationDidEnterBackground:]
 */
+ (void)iWannaGetApplicationDidEnterBackground:(UIApplication *)application
{
    NSLog(@"🔄 iWannaGetApplicationDidEnterBackground:(YUENSwizzleMethodUtilTest_2)");
    [YUENSwizzleMethodUtilTest_2 iWannaGetApplicationDidEnterBackground:application];
}

@end
