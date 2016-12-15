//
//  JSPatchTestRootVC.m
//  AggregateTest
//
//  Created by 袁峥 on 16/12/14.
//  Copyright © 2016年 Yuen. All rights reserved.
//

#import "JSPatchTestRootVC.h"
#import <JSPatch/JPEngine.h>

@interface JSPatchTestRootVC ()

@end

@implementation JSPatchTestRootVC

#pragma mark _________________________________________ Lifecycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"JSPatch";
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self changeBg];
    [self configureSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark _________________________________________ Configure
- (void)configureSubviews
{
    //
    //
    // Button::Change Bg
    UIButton *__btn4ChangeBg = [UIButton buttonWithType:UIButtonTypeSystem];
    [__btn4ChangeBg setTitle:@"Change Bg" forState:UIControlStateNormal];
    [__btn4ChangeBg addTarget:self action:@selector(btn4ChangeBg:) forControlEvents:UIControlEventTouchUpInside];
    __btn4ChangeBg.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview:__btn4ChangeBg];
    [__btn4ChangeBg addConstraint:[NSLayoutConstraint constraintWithItem:__btn4ChangeBg attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:42.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:__btn4ChangeBg attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:__btn4ChangeBg attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:8.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:__btn4ChangeBg attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-8.0]];
}
#pragma mark _________________________________________ Methods
- (void)changeBg
{
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark _________________________________________ Actions
- (void)btn4ChangeBg:(UIButton *)btn
{
    [JPEngine startEngine];
    NSString *__jsPath4ChangeBg = [[NSBundle mainBundle] pathForResource:@"ChangeBg" ofType:@"js"];
    NSString *__script = [NSString stringWithContentsOfFile:__jsPath4ChangeBg encoding:NSUTF8StringEncoding error:nil];
    [JPEngine evaluateScript:__script];
    
    //
    //
    //
    [self changeBg];
}
@end
