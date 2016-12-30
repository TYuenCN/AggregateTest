//
//  MVPTestPresenter.m
//  AggregateTest
//
//  Created by 袁峥 on 16/12/30.
//  Copyright © 2016年 Yuen. All rights reserved.
//

#import "MVPTestPresenter.h"

@implementation MVPTestPresenter
- (instancetype)init
{
    NSAssert(true, @"Use initWithView:model:");
    return nil;
}

- (instancetype _Nonnull)initWithView:(id<MVPProtocol4TestView> _Nonnull)view
                                model:(MVPTestDataModel *_Nonnull)model
{
    self = [super init];
    if (self) {
        self.view = view;
        self.model = model;
    }
    
    return self;
}


#pragma mark ____________________________ <<MVPProtocol4TestPresenter>>
- (void)showTestData
{
    [self.view changeLabelText:self.model.strVal];
}
@end
