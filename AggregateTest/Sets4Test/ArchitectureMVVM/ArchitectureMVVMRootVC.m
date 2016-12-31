//
//  ArchitectureMVVMRootVC.m
//  AggregateTest
//
//  Created by 袁峥 on 16/12/30.
//  Copyright © 2016年 Yuen. All rights reserved.
//

#import "ArchitectureMVVMRootVC.h"
#import "MVVMTestViewModel.h"
#import "MVVMTestDataModel.h"

@interface ArchitectureMVVMRootVC ()

@end

@implementation ArchitectureMVVMRootVC

#pragma mark _________________________________________ Lifecycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"Architecture MVVM";
        self.view.backgroundColor = [UIColor whiteColor];
        
        // 从 Navi 下边开始布局
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //
    //
    // Assembly MVVM
    // ViewModel
    MVVMTestDataModel *__dataModel = [MVVMTestDataModel new];
    MVVMTestViewModel *__viewModel = [[MVVMTestViewModel alloc] initWithModel:__dataModel];
    
    // View
    MVVMTestViewController *__vc = [MVVMTestViewController new];
    __vc.viewModel = __viewModel;
    
    //
    //
    // Add View
    [self addChildViewController:__vc];
    [self.view addSubview:__vc.view];
    [__vc didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
