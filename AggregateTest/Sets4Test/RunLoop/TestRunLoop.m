//
//  TestRunLoop.m
//  AggregateTest
//
//  Created by 袁峥 on 17/2/21.
//  Copyright © 2017年 Yuen. All rights reserved.
//

#import "TestRunLoop.h"


void runLoopEntryCallback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){
    if (activity == kCFRunLoopEntry) {
        NSLog(@"Test Thread RunLoop Entry.----kCFRunLoopEntry");
    }
    else if (activity == kCFRunLoopBeforeTimers) {
        NSLog(@"Test Thread RunLoop Entry.----kCFRunLoopBeforeTimers");
    }
    else if (activity == kCFRunLoopBeforeSources) {
        NSLog(@"Test Thread RunLoop Entry.----kCFRunLoopBeforeSources");
    }
    else if (activity == kCFRunLoopBeforeWaiting) {
        NSLog(@"Test Thread RunLoop Entry.----kCFRunLoopBeforeWaiting");
    }
    else if (activity == kCFRunLoopAfterWaiting) {
        NSLog(@"Test Thread RunLoop Entry.----kCFRunLoopAfterWaiting");
    }
    else if (activity == kCFRunLoopExit) {
        NSLog(@"Test Thread RunLoop Entry.----kCFRunLoopExit");
    }
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
- (void)ponthread
{
    NSLog(@"[self performSelector:@selector(ponthread) onThread:self.t withObject:nil waitUntilDone:false]");
}
- (void)start
{
    self.t = [[NSThread alloc] initWithTarget:self selector:@selector(newThread) object:nil];
    [self.t start];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CFRunLoopWakeUp([self.r getCFRunLoop]);
    });
    
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
    CFRunLoopObserverRef __cfObserver = CFRunLoopObserverCreate(kCFAllocatorSystemDefault, kCFRunLoopAllActivities, YES, 0, runLoopEntryCallback, nil);
    CFRunLoopAddObserver(__cfRunLoop, __cfObserver, kCFRunLoopDefaultMode);
    
    CFRunLoopTimerRef __t = CFRunLoopTimerCreate(kCFAllocatorSystemDefault, 0, 2, 0, 0, runLoopTimer, nil);
//    CFRunLoopAddTimer(__cfRunLoop, __t, kCFRunLoopDefaultMode);
    [__runLoop addPort:[NSMachPort port]forMode:NSDefaultRunLoopMode];
    
    NSTimer *_timer = [NSTimer timerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"nstimer.");
    }];
//    [__runLoop addTimer:_timer forMode:NSDefaultRunLoopMode];
    BOOL b = [__runLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:20]];
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
