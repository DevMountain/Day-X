//
//  ListTableViewDataSource.m
//  DayX
//
//  Created by Caleb Hicks on 4/10/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "ListTableViewDataSource.h"
#import "Entry.h"

@implementation ListTableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"entryCell"];

    Entry *entry = self.entries[indexPath.row];

    cell.textLabel.text = entry.title;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.entries.count;
}

@end
