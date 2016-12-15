//
//  UIViewController+MediatorWeafRefRegister.m
//  AggregateTest
//
//  Created by 袁峥 on 16/12/15.
//  Copyright © 2016年 Yuen. All rights reserved.
//

#import "UIViewController+MediatorWeafRefRegister.h"
#import "YUENSwizzleMethodUtil.h"
#import "YUENMediator.h"

@implementation UIViewController (MediatorWeafRefRegister)
+ (void)load
{
    [YUENSwizzleMethodUtil swizzleMethodWithOriginalClass:[UIViewController class]
                                            swizzledClass:[UIViewController class]
                                              originalSel:@selector(viewDidLoad)
                                              swizzledSel:@selector(handleViewDidLoad)
                                         isInstanceMethod:true];
}

- (void)handleViewDidLoad
{
    
    //
    //
    // Register Weak Ref
    [[YUENMediator sharedInstance] registVC:[super init]];
    
    
    //
    //
    // Call Original
    [self handleViewDidLoad];
}
@end
