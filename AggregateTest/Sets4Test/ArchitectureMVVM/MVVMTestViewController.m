//
//  MVVMTestViewController.m
//  AggregateTest
//
//  Created by 袁峥 on 16/12/31.
//  Copyright © 2016年 Yuen. All rights reserved.
//

#import "MVVMTestViewController.h"

@interface MVVMTestViewController ()
@property (nullable, nonatomic, strong) UILabel *p_lbl;
@property (nullable, nonatomic, strong) UIButton *p_btn;
@property (nullable, nonatomic, strong) NSTimer *p_timer;
@property (nonatomic, assign) NSInteger p_timerCount;
@end

@implementation MVVMTestViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.p_lbl = [[UILabel alloc] init];
    self.p_lbl.adjustsFontSizeToFitWidth = true;
    [self.view addSubview:self.p_lbl];
    self.p_lbl.translatesAutoresizingMaskIntoConstraints = false;
    [self.p_lbl addConstraint:[NSLayoutConstraint constraintWithItem:self.p_lbl attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.p_lbl attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.p_lbl attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.p_lbl attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
    
    
    
    self.p_timerCount = 6;
    __weak typeof(self) __ws = self;
    self.p_timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:true block:^(NSTimer * _Nonnull timer) {
        __strong typeof(self) __ss = __ws;
        __ss.p_timerCount--;
        __ss.p_lbl.text = [NSString stringWithFormat:@"%ld 秒后，Model 将自动变动，亦将导致更新 View's Label", (long)self.p_timerCount];
        if (__ss.p_timerCount == 0) {
            [self.p_timer invalidate];
            self.p_timer = nil;
        }
    }];
}
@end
