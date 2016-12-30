//
//  MVPTestPresenter.h
//  AggregateTest
//
//  Created by 袁峥 on 16/12/30.
//  Copyright © 2016年 Yuen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MVPTestDataModel.h"

@protocol MVPProtocol4TestView <NSObject>
- (void)changeLabelText:(NSString *_Nonnull)text;
@end

@protocol MVPProtocol4TestPresenter <NSObject>
- (void)showTestData;
@end

@interface MVPTestPresenter : NSObject<MVPProtocol4TestPresenter>
@property (nullable, nonatomic, weak) id<MVPProtocol4TestView> view;
@property (nullable, nonatomic, strong) MVPTestDataModel *model;

- (instancetype _Nonnull)initWithView:(id<MVPProtocol4TestView> _Nonnull)view
                                model:(MVPTestDataModel *_Nonnull)model;
@end
