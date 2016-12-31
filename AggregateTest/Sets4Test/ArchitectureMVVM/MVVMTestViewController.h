//
//  MVVMTestViewController.h
//  AggregateTest
//
//  Created by 袁峥 on 16/12/31.
//  Copyright © 2016年 Yuen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MVVMTestViewModel.h"

@interface MVVMTestViewController : UIViewController
@property (nullable, nonatomic, strong) MVVMTestViewModel *viewModel;
@end
