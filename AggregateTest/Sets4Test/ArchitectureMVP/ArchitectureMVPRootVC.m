//
//  ArchitectureMVPVC.m
//  AggregateTest
//
//  Created by 袁峥 on 16/12/30.
//  Copyright © 2016年 Yuen. All rights reserved.
//
#import "ArchitectureMVPRootVC.h"
#import "MVPTestViewController.h"
#import "MVPTestDataModel.h"
#import "MVPTestPresenter.h"

@interface ArchitectureMVPRootVC ()

@end

@implementation ArchitectureMVPRootVC

#pragma mark _________________________________________ Lifecycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"Architecture MVP";
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
    // Assembly MVP
    // View
    MVPTestViewController *__vc = [MVPTestViewController new];
    [self addChildViewController:__vc];
    [self.view addSubview:__vc.view];
    [__vc didMoveToParentViewController:self];
    
    // Model
    MVPTestDataModel *__model = [MVPTestDataModel new];
    __model.strVal = @"Changed Text";
    
    // Presenter
    MVPTestPresenter *__presenter = [[MVPTestPresenter alloc] initWithView:__vc model:__model];
    __vc.presenter = __presenter;
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
