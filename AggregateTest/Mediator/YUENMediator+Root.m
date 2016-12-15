//
//  YUENMediator+Root.m
//  AggregateTest
//
//  Created by 袁峥 on 16/12/15.
//  Copyright © 2016年 Yuen. All rights reserved.
//

#import "YUENMediator+Root.h"
#import "RootTableViewController.h"
#import "RootNavigationController.h"
#import "JSPatchTestRootVC.h"


@interface YUENMediator()
@property (nonnull, nonatomic, strong) NSHashTable *p_weakVCs;
@property (nonnull, nonatomic, strong) NSHashTable *p_weakControls;
@end

@implementation YUENMediator
#pragma mark - Methods
#pragma mark _________________________ Create
+ (instancetype _Nonnull)sharedInstance
{
    static YUENMediator *__sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [YUENMediator new];
        __sharedInstance.p_weakVCs = [NSHashTable weakObjectsHashTable];
        __sharedInstance.p_weakControls = [NSHashTable weakObjectsHashTable];
    });
    
    return __sharedInstance;
}

#pragma mark _________________________ Register

/**
 * @Description 注册 VC 到 Mediator； Mediator 保留一份弱引用；
 *
 * @param vc 需要注册到弱引用集合的 ViewController
 */
- (void)registVC:(UIViewController * _Nonnull)vc
{
    [self.p_weakVCs addObject:vc];
}

/**
 * @Description 根据 Class 查询，在 Mediator 保存的 VC 弱引用集合中；
 *
 * @param c 根据某类型的 Class，在弱引用集合中查询是否有存活的指定类型的对象
 */
- (UIViewController * _Nullable)queryVCWithClass:(Class _Nonnull)c
{
    NSArray *__arr = self.p_weakVCs.allObjects;
    for (UIViewController *__vc in __arr) {
        
        if (__vc != nil && [__vc class] == c) {
            return __vc;
        }
    }
    
    return nil;
}

@end






@implementation YUENMediator (Root)
#pragma mark _________________________ UI
/**
 * @Description 配置启动时的初始视图
 */
- (void)configureStartup
{
    [self configureLandingPage];
}

/**
 * LandingPage 展现逻辑
 */
- (void)configureLandingPage
{
    [self presentRootViewController];
}

/**
 * @Description 展现初始根视图
 */
- (void)presentRootViewController
{
    RootTableViewController *__rootVC = [RootTableViewController new];
    RootNavigationController *__rootNavi = [[RootNavigationController alloc] initWithRootViewController:__rootVC];
    [UIApplication sharedApplication].keyWindow.rootViewController = __rootNavi;
}



/**
 * 展现::JSPatch 测试页面
 */
- (void)presentJSPatchTestVC
{
    UIViewController *__vc4RootNavi = [self queryVCWithClass:[RootNavigationController class]];
    if ([__vc4RootNavi isKindOfClass:[RootNavigationController class]]) {
        RootNavigationController *__rootNavi = (RootNavigationController *)__vc4RootNavi;
        JSPatchTestRootVC *__toVC = [JSPatchTestRootVC new];
        [__rootNavi pushViewController:__toVC animated:true];
    }
}
@end
