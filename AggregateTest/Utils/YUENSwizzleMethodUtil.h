//
//  YUENSwizzleMethodUtil.h
//  AggregateTest
//
//  Created by 袁峥 on 16/9/23.
//  Copyright © 2016年 YUEN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YUENSwizzleMethodUtil : NSObject

/**
 * 交换任意两个类的方法实现。
 * 
 * 🌰举例：
 *
 *      如果有多个类对象，在不给 AppDelegate 添加代码的情况下，
 *  各自都拿到 AppDelegate 中的某方法的执行前，执行自身的机会。
 *  （可包含 App 生命周期方法、自定义的 AppDelegate 内的方法）
 *
 * @param originalClass 被替换方法所在的类对象
 * @param swizzledClass 替换方法所在的类对象
 * @param originalSel 被替换方法 SEL
 * @param swizzledSel 替换方法 SEL
 */
+ (void)swizzleMethodWithOriginalClass:(Class)originalClass
                         swizzledClass:(Class)swizzledClass
                           originalSel:(SEL)originalSel
                           swizzledSel:(SEL)swizzledSel
                      isInstanceMethod:(BOOL)isInstanceMethod;
@end













#pragma mark - YUENSwizzleMethodUtilTest_1

@interface YUENSwizzleMethodUtilTest_1 : NSObject

/**
 * 测试入口
 */
+ (void)configureSwizzle;

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
+ (void)iWannaGetApplicationDidEnterBackground:(UIApplication *)application;
@end



#pragma mark - YUENSwizzleMethodUtilTest_2

@interface YUENSwizzleMethodUtilTest_2 : NSObject

/**
 * 测试入口
 */
+ (void)configureSwizzle;

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
+ (void)iWannaGetApplicationDidEnterBackground:(UIApplication *)application;

@end
