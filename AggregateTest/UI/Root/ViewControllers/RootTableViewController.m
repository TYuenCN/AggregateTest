//
//  RootTableViewController.m
//  AggregateTest
//
//  Created by 袁峥 on 16/12/15.
//  Copyright © 2016年 Yuen. All rights reserved.
//

#import "RootTableViewController.h"
#import "RootTableViewCell.h"
#import "YUENMediator.h"

@interface RootTableViewController ()
@property (nullable, nonatomic, strong) NSArray *arr4CellInfo;
@end

@implementation RootTableViewController


#pragma mark _________________________________________ Lifecycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"Test";
        self.arr4CellInfo = @[@[@"JSPatch", @"测试 JSPatch"],
                              @[@"Architecture MVP", @"测试 MVP"]];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    //
    // Configure::TableView
    [self.tableView registerClass:[RootTableViewCell class] forCellReuseIdentifier:@"RootTableViewCellIdentifier"];
    self.tableView.tableHeaderView = [UIView new];
    self.tableView.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark _________________________________________ <<UITableViewDataSource>>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.arr4CellInfo count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *__cell = [tableView dequeueReusableCellWithIdentifier:@"RootTableViewCellIdentifier" forIndexPath:indexPath];
    __cell.textLabel.text = [[self.arr4CellInfo objectAtIndex:indexPath.row] objectAtIndex:0];
    __cell.detailTextLabel.text = [[self.arr4CellInfo objectAtIndex:indexPath.row] objectAtIndex:1];
    return __cell;
}

#pragma mark _________________________________________ <<UITableViewDelegate>>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    //
    //
    // Present
    if ([[[self.arr4CellInfo objectAtIndex:indexPath.row] objectAtIndex:0] isEqualToString:@"JSPatch"]) {
        [[YUENMediator sharedInstance] presentJSPatchTestVC];
    }
    else if ([[[self.arr4CellInfo objectAtIndex:indexPath.row] objectAtIndex:0] isEqualToString:@"Architecture MVP"]) {
        [[YUENMediator sharedInstance] presentArchitectureMVP];
    }
}
@end
