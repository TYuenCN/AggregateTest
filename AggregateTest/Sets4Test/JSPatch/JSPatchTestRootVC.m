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
        
        // 从 Navi 下边开始布局
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

- (void)setProperty:(NSString *)property
{
    _property = property;
    NSLog(@"Set Property(property)::%@", property);
}

#pragma mark _________________________________________ Configure
- (void)configureSubviews
{
    //
    //
    // Button::Change Bg
    UIButton *__btn4Entrance = [UIButton buttonWithType:UIButtonTypeSystem];
    [__btn4Entrance setTitle:@"Entrance" forState:UIControlStateNormal];
    [__btn4Entrance addTarget:self action:@selector(btn4Entrance:) forControlEvents:UIControlEventTouchUpInside];
    __btn4Entrance.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview:__btn4Entrance];
    [__btn4Entrance addConstraint:[NSLayoutConstraint constraintWithItem:__btn4Entrance attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:42.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:__btn4Entrance attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:10.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:__btn4Entrance attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:8.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:__btn4Entrance attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-8.0]];
}
#pragma mark _________________________________________ Methods
- (void)changeBg
{
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)callWithArg1:(NSString *)arg1 arg2:(NSString *)arg2
{
    NSLog(@"callWithArg1::%@  arg2::%@", arg1, arg2);
}

- (void)callFromSelectorWithObject:(id)obj
{
    NSLog(@"callFromSelectorWithObject::%@", obj);
}

- (void)testNull:(NSNull *_Nullable)null
{
    if ([null isKindOfClass:[NSNull class]]) {
        NSLog(@"Argument is NSNull Object.");
    }else{
        NSLog(@"Argument is nil.");
    }
}


- (NSArray *_Nullable)array
{
    return @[[NSMutableString stringWithString:@"JS"]];
}

- (NSMutableDictionary *_Nullable)dict
{
    return [[NSMutableDictionary alloc] init];
}


- (void)request:(void(^_Nullable)(NSString *_Nullable content, BOOL success))callback
{
    callback( @"This is content.", true );
}

- (void(^_Nullable)(NSDictionary *_Nullable arg))genBlock
{
    return ^(NSDictionary * arg){
        NSLog(@"OC Block Print::%@", arg);
    };
}
#pragma mark _________________________________________ Actions
- (void)btn4Entrance:(UIButton *)btn
{
    [JPEngine startEngine];
    NSString *__jsPath4ChangeBg = [[NSBundle mainBundle] pathForResource:@"main" ofType:@"js"];
    NSString *__script = [NSString stringWithContentsOfFile:__jsPath4ChangeBg encoding:NSUTF8StringEncoding error:nil];
    [JPEngine evaluateScript:__script];
}
@end
