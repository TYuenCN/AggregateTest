//
//  Thread.m
//  ___Test
//
//  Created by Yuen on 16/5/9.
//  Copyright © 2016年 xfnetwork. All rights reserved.
//

#import "Thread.h"

@interface Thread ()
@property (nonatomic, assign) CFRunLoopSourceRef source;
@end

@implementation Thread
{
    NSThread *_thread;
    NSCondition *_condition;
}

- (instancetype)init
{
    if ((self = [super init])) {
        _condition = [[NSCondition alloc] init];
        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self stop];
//        });
    }
    
    return self;
}

- (void)dealloc
{
    [self stop];
}

- (void)start
{
    if (_thread) {
        return;
    }
    _thread = [[NSThread alloc] initWithTarget:self
                                      selector:@selector(threadProc:)
                                        object:nil];
    
    [_condition lock];
    [_thread start];
    [_condition wait];
    [_condition unlock];
    
    NSLog(@"thread should have started");
}

- (void)stop
{
    if (!_thread) {
        return;
    }
    
    [_condition lock];
    [self performSelector:@selector(_stop)
                 onThread:_thread
               withObject:nil
            waitUntilDone:NO];
    [_condition wait];
    [_condition unlock];
    _thread = nil;
    
    NSLog(@"thread should have stopped");
}

#pragma mark Private Helpers

static void DoNothingRunLoopCallback(void *info)
{
    NSLog(@"%s",  __FUNCTION__);
}


- (void)threadProc:(id)object
{
    @autoreleasepool {
        CFRunLoopSourceContext context = {0};
        context.perform = DoNothingRunLoopCallback;
        
        CFRunLoopSourceRef source = CFRunLoopSourceCreate(NULL, 0, &context);
        self.source = source;
        CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopCommonModes);
        [_condition lock];
        [_condition signal];
        NSLog(@"thread has started");
        [_condition unlock];
        
        //
        // Keep processing events until the runloop is stopped.
        //
        // CFRunLoopStop:
        //
        // This function forces rl to stop running and return control to the function that called CFRunLoopRun or CFRunLoopRunInMode for the current run loop activation. If the run loop is nested with a callout from one activation starting another activation running, only the innermost activation is exited.
        //
        // 此方法的后续步骤不会执行, 控制权交由 CPU, 根据 RunLoop 唤醒, 执行 Source/Timer 的注册方法;
        //
        // CFRunLoopStop 之后,控制权再交回调用 CFRunLoopRun 的方法的位置, 继续执行;
        //
        // !!!过程中, 此对象没有在 ARC 下释放.
        CFRunLoopRun();
        
        //
        //
        // 一般结合 while 使用,此方法调用后, 会继续执行下面的语句;
        //[[NSRunLoop currentRunLoop] runMode:NSRunLoopCommonModes beforeDate:[NSDate distantFuture]];
        
        //
        //
        // Source-0, 手动唤醒 RunLoop
        CFRunLoopSourceSignal(source);
        
        
        
        CFRunLoopRemoveSource(CFRunLoopGetCurrent(), source, kCFRunLoopCommonModes);
        CFRelease(source);
        
        [_condition lock];
        [_condition signal];
        NSLog(@"thread has stopped");
        [_condition unlock];
    }
}

- (void)_stop
{
    CFRunLoopStop(CFRunLoopGetCurrent());
}
@end
