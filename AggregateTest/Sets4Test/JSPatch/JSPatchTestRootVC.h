//
//  JSPatchTestRootVC.h
//  AggregateTest
//
//  Created by 袁峥 on 16/12/14.
//  Copyright © 2016年 Yuen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSPatchTestRootVC : UIViewController
@property (nullable, nonatomic, strong) NSString *property;

- (void)callWithArg1:(NSString *_Nullable)arg1 arg2:(NSString *_Nullable)arg2;
- (void)callFromSelectorWithObject:(id _Nullable)obj;
- (void)testNull:(NSNull *_Nullable)null;
- (NSArray *_Nullable)data;
- (NSMutableDictionary *_Nullable)dict;
- (void)request:(void(^_Nullable)(NSString *_Nullable content, BOOL success))callback;
- (void(^_Nullable)(NSDictionary *_Nullable arg))genBlock;
@end
