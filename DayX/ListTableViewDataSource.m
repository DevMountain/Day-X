//
//  ListTableViewDataSource.m
//  DayX
//
//  Created by Caleb Hicks on 4/10/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "ListTableViewDataSource.h"

@implementation ListTableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"entryCell"];
    cell.textLabel.text = [NSString stringWithFormat:@"Entry %ld", (long)indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

@end
