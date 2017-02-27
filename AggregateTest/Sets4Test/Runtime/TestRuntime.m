//
//  TestRuntime.m
//  AggregateTest
//
//  Created by 袁峥 on 17/2/14.
//  Copyright © 2017年 Yuen. All rights reserved.
//

#import "TestRuntime.h"
#import <objc/runtime.h>

static void newTFunc2(){
    NSLog(@"tFunc has been replaced to newTFunc2, and invoked.");
}





@implementation TestRuntime
- (void)tFunc
{
    NSLog(@"tFunc invoked.");
}
- (void)newTFunc
{
    NSLog(@"tFunc has been replaced to newTFunc, and invoked.");
}

/**
 * 通过类名/方法名反射得到相应的类和方法
 */
- (void)getClassSelFromString
{
    Class class = NSClassFromString(@"TestRuntimeTestClass");
    id viewController = [[class alloc] init];
    SEL selector = NSSelectorFromString(@"tFunc");
    [self performSelector:selector];
}

/**
 * 替换某个类的方法为新的实现
 */
- (void)replaceClassMethod
{
    Class class = NSClassFromString(@"TestRuntime");
    // 跟具体的类无关。
    // 只是单纯的返回一个 @selector 或 Runtime 中的 SEL
    SEL selector = NSSelectorFromString(@"tFunc");
    
    //
    //
    // 使用 ObjC Method 替换
    Method m = class_getInstanceMethod(class, @selector(newTFunc));
    class_replaceMethod(class, selector, method_getImplementation(m), [@"v@" UTF8String]);
    [self performSelector:selector];
    
    //
    //
    // 使用 C Method 替换
    class_replaceMethod(class, selector, newTFunc2, [@"v@" UTF8String]);
    [self performSelector:selector];
}


/**
 * 新注册一个类，为类添加方法，并调用
 */
- (void)registNewClassAddMethodInvokeMethod
{
    // 指定父类
    Class sCls = NSClassFromString(@"NSObject");
    // 创建新类
    Class cls = objc_allocateClassPair(sCls, "TestRuntimeClassDynamicCreate", 0);
    // 注册新类
    objc_registerClassPair(cls);
    // 向新注册的类添加方法
    IMP imp = imp_implementationWithBlock(^void(){
        NSLog(@"TestRuntimeClassDynamicCreate Dynamic Crate Method methodDynamic invoked.");
    });
    class_addMethod(cls, NSSelectorFromString(@"methodDynamic"), imp, "v@");
    
    //
    //
    // 创建并调用
    id obj = [cls new];
    [obj performSelector:@selector(methodDynamic)];
    //[obj performSelector:NSSelectorFromString(@"methodDynamic")];
}
@end




@implementation TestRuntimeTestClass

@end
