//
//  EntryController.h
//  DayX
//
//  Created by Caleb Hicks on 4/11/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entry.h"

@interface EntryController : NSObject

@property (strong, nonatomic, readonly) NSArray *entries;

+ (EntryController *)sharedInstance;

- (Entry *)createEntryWithTitle:(NSString *)title bodyText:(NSString *)bodyText;

- (void)removeEntry:(Entry *)entry;

- (void)save;

@end
