//
//  MVPTestViewController.m
//  AggregateTest
//
//  Created by 袁峥 on 16/12/30.
//  Copyright © 2016年 Yuen. All rights reserved.
//

#import "MVPTestViewController.h"

@interface MVPTestViewController ()
@property (nullable, nonatomic, strong) UILabel *p_lbl;
@property (nullable, nonatomic, strong) UIButton *p_btn;
@end

@implementation MVPTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.p_lbl = [[UILabel alloc] init];
    [self.view addSubview:self.p_lbl];
    self.p_lbl.translatesAutoresizingMaskIntoConstraints = false;
    self.p_lbl.text = @"Label";
    [self.p_lbl addConstraint:[NSLayoutConstraint constraintWithItem:self.p_lbl attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.p_lbl attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.p_lbl attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.p_lbl attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0]];
    
    
    self.p_btn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.p_btn.backgroundColor = [UIColor blackColor];
    [self.p_btn setTitle:@"Button" forState:UIControlStateNormal];
    [self.p_btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.p_btn];
    self.p_btn.translatesAutoresizingMaskIntoConstraints = false;
    [self.p_btn addConstraint:[NSLayoutConstraint constraintWithItem:self.p_btn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.p_btn attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.p_btn attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.p_btn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.p_lbl attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
    
    
    //
    //
    //
    NSString *searchText = @"1小时25分1小时25分1小时25分1小时25分1小时25分1小时25分1小时25分1小时25分1小时25分1小时25分1小时25分1小时25分1小时25分1小时25分1小时25分1小时25分1小时25分1小时25分1小时25分1小时25分1小时25分1小时25分1小时25分1小时25分1小时25分1小时25分1小时25分1小时25分1小时25分1小时25分1小时25分1小时25分1小时25分1小时25分";
    NSDictionary *__default = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    NSMutableAttributedString *__attrStr = [[NSMutableAttributedString alloc] initWithString:searchText attributes:__default];
    
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[0-9]+" options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *__arr = [regex matchesInString:searchText options:NSMatchingReportProgress range:NSMakeRange(0, searchText.length)];
    for (int i = 0; i < __arr.count; i++) {
        NSTextCheckingResult *__rslt = [__arr objectAtIndex:i];
        NSLog(@"%@", NSStringFromRange(__rslt.range));
        [__attrStr addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:26], NSForegroundColorAttributeName:[UIColor redColor]} range:__rslt.range];
    }
    
    UILabel *__lbl = [[UILabel alloc] initWithFrame:CGRectZero];
    __lbl.attributedText = __attrStr;
    [self.view addSubview:__lbl];
    __lbl.translatesAutoresizingMaskIntoConstraints = false;
    [__lbl addConstraint:[NSLayoutConstraint constraintWithItem:__lbl attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:__lbl attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:__lbl attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:__lbl attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.p_btn attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)btnClicked:(UIButton *)btn
{
    [self.presenter showTestData];
}


#pragma mark ____________________________ <<MVPProtocol4TestView>>
- (void)changeLabelText:(NSString *_Nonnull)text
{
    self.p_lbl.text = text;
}

@end
