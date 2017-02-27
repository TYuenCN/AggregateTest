//
//  TestRunLoop.m
//  AggregateTest
//
//  Created by 袁峥 on 17/2/21.
//  Copyright © 2017年 Yuen. All rights reserved.
//

#import "TestRunLoop.h"

void runLoopEntryCallback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){
    NSLog(@"Test Thread RunLoop Entry.");
}

void runLoopTimer(CFRunLoopTimerRef timer, void *info)
{
    NSLog(@"runLoopTimer.");
}

@interface TestRunLoop()
@property (nullable, nonatomic, strong) NSThread *t;
@property (nullable, nonatomic, strong) NSRunLoop *r;
@property (nullable, nonatomic, strong) NSMachPort *p;
@end

@implementation TestRunLoop
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self start];
    }
    return self;
}

- (void)start
{
    self.t = [[NSThread alloc] initWithTarget:self selector:@selector(newThread) object:nil];
    [self.t start];
    
//    [NSTimer scheduledTimerWithTimeInterval:3 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        [self performSelector:@selector(testFun) onThread:self.t withObject:nil waitUntilDone:NO modes:@[NSDefaultRunLoopMode]];
//        
//    }];
}
- (void)newThread
{
    self.t.name = @"com.yuen.testThread";
    NSRunLoop *__runLoop = [NSRunLoop currentRunLoop];
    self.r = __runLoop;
    CFRunLoopRef __cfRunLoop =  CFRunLoopGetCurrent();
    //CFRunLoopAddCommonMode(__cfRunLoop, kCFRunLoopDefaultMode);
    CFRunLoopObserverRef __cfObserver = CFRunLoopObserverCreate(kCFAllocatorSystemDefault, kCFRunLoopBeforeWaiting, YES, 0, runLoopEntryCallback, nil);
    CFRunLoopAddObserver(__cfRunLoop, __cfObserver, kCFRunLoopDefaultMode);
    
    CFRunLoopTimerRef __t = CFRunLoopTimerCreate(kCFAllocatorSystemDefault, 0, 2, 0, 0, runLoopTimer, nil);
    CFRunLoopAddTimer(__cfRunLoop, __t, kCFRunLoopDefaultMode);
    [__runLoop addPort:[NSMachPort port]forMode:NSDefaultRunLoopMode];
    
    NSTimer *_timer = [NSTimer timerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"nstimer.");
    }];
    [__runLoop addTimer:_timer forMode:NSDefaultRunLoopMode];
    BOOL b = [__runLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
//    [__runLoop run];
    //NSLog(@"%d", b);
}
- (void)testFun
{
    NSLog(@"testFun.");
//    NSRunLoop *__runLoop = [NSRunLoop currentRunLoop];
//    [__runLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    
}
@end
