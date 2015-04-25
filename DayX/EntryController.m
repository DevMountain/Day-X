//
//  EntryController.m
//  DayX
//
//  Created by Caleb Hicks on 4/11/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "EntryController.h"
#import "Stack.h"

static NSString * const AllEntriesKey = @"allEntries";

@interface EntryController ()

@end

@implementation EntryController

+ (EntryController *)sharedInstance {
    static EntryController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [EntryController new];
    });
    return sharedInstance;
}

#pragma mark - Create

- (Entry *)createEntryWithTitle:(NSString *)title bodyText:(NSString *)bodyText {
    Entry *entry = [NSEntityDescription insertNewObjectForEntityForName:@"Entry" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    entry.title = title;
    entry.bodyText = bodyText;
    entry.timestamp = [NSDate date];
    
    [self saveToPersistentStorage];
    
    return entry;
}

#pragma mark - Read

- (NSArray *)entries {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Entry"];
    
    NSArray *fetchedObjects = [[Stack sharedInstance].managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    return fetchedObjects;
}

#pragma mark - Update

- (void)save {
    [self saveToPersistentStorage];
}

- (void)saveToPersistentStorage {
    [[Stack sharedInstance].managedObjectContext save:nil];
}

#pragma mark - Delete

- (void)removeEntry:(Entry *)entry {
    [entry.managedObjectContext deleteObject:entry];
}

@end
