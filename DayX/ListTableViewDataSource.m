//
//  ListTableViewDataSource.m
//  DayX
//
//  Created by Caleb Hicks on 4/10/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "ListTableViewDataSource.h"
#import "EntryController.h"

@implementation ListTableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Entry *entry = [EntryController sharedInstance].entries[indexPath.row];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"entryCell"];
    cell.textLabel.text = entry.title;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [EntryController sharedInstance].entries.count;
}

@end
