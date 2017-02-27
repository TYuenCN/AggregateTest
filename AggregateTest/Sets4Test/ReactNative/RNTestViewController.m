//
//  RNTestViewController.m
//  AggregateTest
//
//  Created by 袁峥 on 17/1/28.
//  Copyright © 2017年 Yuen. All rights reserved.
//

#import "RNTestViewController.h"
#import <UIKit/UIKit.h>
#import <React/RCTRootView.h>

@implementation RNTestViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    NSURL *jsCodeLocation;
    jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios"];
    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                        moduleName:@"RNHighScores"
                                                 initialProperties:@{
                                                                     @"scores" : @[
                                                                             @{
                                                                                 @"name" : @"Alex",
                                                                                 @"value": @"42"
                                                                                 },
                                                                             @{
                                                                                 @"name" : @"Joel",
                                                                                 @"value": @"10"
                                                                                 }
                                                                             ]
                                                                     }
                                                     launchOptions:nil];
    rootView.frame = self.view.bounds;
    [self.view addSubview:rootView];
}
@end
