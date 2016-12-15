//
//  RootTableViewController.m
//  AggregateTest
//
//  Created by 袁峥 on 16/12/15.
//  Copyright © 2016年 Yuen. All rights reserved.
//

#import "RootTableViewController.h"

@interface RootTableViewController ()

@end

@implementation RootTableViewController


#pragma mark _________________________________________ Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    //
    // Configure::TableView
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"RootTableViewCellIdentifier"];
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
    return 1;
}

#pragma mark _________________________________________ <<UITableViewDelegate>>

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *__cell = [tableView dequeueReusableCellWithIdentifier:@"RootTableViewCellIdentifier" forIndexPath:indexPath];
    __cell.textLabel.text = @"JSPatch";
    return __cell;
}

@end
