//
//  ListTableViewDataSource.h
//  DayX
//
//  Created by Caleb Hicks on 4/10/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface ListTableViewDataSource : NSObject <UITableViewDataSource>

@property (strong) NSArray *entries;

@end
