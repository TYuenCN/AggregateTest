//
//  AggregateTestTests.m
//  AggregateTestTests
//
//  Created by 袁峥 on 16/12/14.
//  Copyright © 2016年 Yuen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <objc/runtime.h>
#import "TestMemoryBaseClass.h"
#import "TestMemoryConcreteClass.h"

@interface AggregateTestTests : XCTestCase

@end

@implementation AggregateTestTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testMemory{
    NSLog(@"⭕️%lu", class_getInstanceSize([TestMemoryBaseClass class]));
    NSLog(@"⭕️%lu", class_getInstanceSize([TestMemoryConcreteClass class]));
}

@end
