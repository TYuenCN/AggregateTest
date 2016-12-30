//
//  MVVMTestViewModel.m
//  AggregateTest
//
//  Created by 袁峥 on 16/12/30.
//  Copyright © 2016年 Yuen. All rights reserved.
//

#import "MVVMTestViewModel.h"

@interface MVVMTestViewModel ()
@property (nullable, nonatomic, strong) MVVMTestDataModel *model;
@end

@implementation MVVMTestViewModel

- (instancetype)init
{
    NSAssert(true, @"Use initWithModel:");
    return nil;
}
- (instancetype _Nonnull)initWithModel:(MVVMTestDataModel *_Nonnull)model
{
    self = [super init];
    if (self) {
        self.model = model;
        self.strValAtViewModel = self.model.strVal;
    }
    
    return self;
}
@end
