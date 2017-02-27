//
//  TestRuntime.h
//  AggregateTest
//
//  Created by 袁峥 on 17/2/14.
//  Copyright © 2017年 Yuen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestRuntime : NSObject
- (void)tFunc;
/**
 * 通过类名/方法名反射得到相应的类和方法
 */
- (void)getClassSelFromString;

/**
 * 替换某个类的方法为新的实现
 */
- (void)replaceClassMethod;

/**
 * 新注册一个类，为类添加方法，并调用
 */
- (void)registNewClassAddMethodInvokeMethod;
@end

@interface TestRuntimeTestClass : NSObject

@end
