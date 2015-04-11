//
//  EntryController.m
//  DayX
//
//  Created by Caleb Hicks on 4/11/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "EntryController.h"

@interface EntryController ()

#pragma mark - Read

@property (strong, nonatomic) NSArray *entries;

@end

@implementation EntryController

+ (EntryController *)sharedInstance {
    static EntryController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [EntryController new];
        
        sharedInstance.entries = [NSArray new];
    });
    return sharedInstance;
}

#pragma mark - Create

- (Entry *)createEntryWithTitle:(NSString *)title bodyText:(NSString *)bodyText {
    Entry *entry = [Entry new];
    entry.title = title;
    entry.bodyText = bodyText;
    entry.timestamp = [NSDate date];
    
    [self addEntry:entry];
    
    return entry;
}

- (void)addEntry:(Entry *)entry {
    if (!entry) {
        return;
    }
    
    NSMutableArray *mutableEntries = self.entries.mutableCopy;
    [mutableEntries addObject:entry];
    
    self.entries = mutableEntries;
}

#pragma mark - Delete

- (void)removeEntry:(Entry *)entry {
    if (!entry) {
        return;
    }
    
    NSMutableArray *mutableEntries = self.entries.mutableCopy;
    [mutableEntries removeObject:entry];
    
    self.entries = mutableEntries;
}

@end
