//
//  YUENMediator+Root.h
//  AggregateTest
//
//  Created by 袁峥 on 16/12/15.
//  Copyright © 2016年 Yuen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface YUENMediator : NSObject
@property (nonnull, nonatomic, strong, readonly) NSHashTable *p_weakVCs;
@property (nonnull, nonatomic, strong, readonly) NSHashTable *p_weakControls;

#pragma mark - Methods
#pragma mark _________________________ Create
+ (instancetype _Nonnull)sharedInstance;


#pragma mark _________________________ Register

/**
 * @Description 注册 VC 到 Mediator； Mediator 保留一份弱引用；
 *
 * @param vc 需要注册到弱引用集合的 ViewController
 */
- (void)registVC:(UIViewController * _Nonnull)vc;

/**
 * @Description 根据 Class 查询，在 Mediator 保存的 VC 弱引用集合中；
 *
 * @param c 根据某类型的 Class，在弱引用集合中查询是否有存活的指定类型的对象
 */
- (UIViewController * _Nullable)queryVCWithClass:(Class _Nonnull)c;
@end







@interface YUENMediator (Root)

#pragma mark _________________________ Root
/**
 * @Description 配置启动时的初始视图
 */
- (void)configureStartup;

/**
 * 展现初始根视图
 */
- (void)presentRootViewController;

/**
 * 展现::JSPatch 测试页面
 */
- (void)presentJSPatchTestVC;

/**
 * 展现::ArchitectureMVP 测试页面
 */
- (void)presentArchitectureMVP;

/**
 * 展现::ArchitectureMVVM 测试页面
 */
- (void)presentArchitectureMVVM;
@end
