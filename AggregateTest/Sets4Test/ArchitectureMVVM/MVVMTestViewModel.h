//
//  MVVMTestViewModel.h
//  AggregateTest
//
//  Created by 袁峥 on 16/12/30.
//  Copyright © 2016年 Yuen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MVVMTestDataModel.h"

@interface MVVMTestViewModel : NSObject
@property (nullable, nonatomic, strong) NSString *strValAtViewModel;



- (instancetype _Nonnull)initWithModel:(MVVMTestDataModel *_Nonnull)model;
@end
