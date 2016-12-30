//
//  MVPTestViewController.h
//  AggregateTest
//
//  Created by 袁峥 on 16/12/30.
//  Copyright © 2016年 Yuen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MVPTestPresenter.h"

@interface MVPTestViewController : UIViewController<MVPProtocol4TestView>
@property (nullable, nonatomic, strong) id<MVPProtocol4TestPresenter> presenter;
@end
