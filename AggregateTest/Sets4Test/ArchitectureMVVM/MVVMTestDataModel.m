//
//  MVVMTestDataModel.m
//  AggregateTest
//
//  Created by 袁峥 on 16/12/30.
//  Copyright © 2016年 Yuen. All rights reserved.
//

#import "MVVMTestDataModel.h"

@implementation MVVMTestDataModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.strVal = @"Model.strVal 新值";
        });
    }
    
    return self;
}
@end
