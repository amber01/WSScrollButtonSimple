//
//  ThreeTableViewController.m
//  CustomNavignonSimple
//
//  Created by shlity on 15/8/6.
//  Copyright (c) 2015年 shlity. All rights reserved.
//

#import "ThreeTableViewController.h"

@interface ThreeTableViewController ()

@end

@implementation ThreeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identityCell = @"cell";
    UITableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:identityCell];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identityCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = @"three";
    
    return cell;
}

@end
