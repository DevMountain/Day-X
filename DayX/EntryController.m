//
//  EntryController.m
//  
//
//  Created by Parker Wightman on 7/2/15.
//
//

#import "EntryController.h"

@interface EntryController ()

@property (strong) NSArray *entries;

@end

@implementation EntryController

-(instancetype)init {
    self = [super init];
    if (self) {
        self.entries = [NSArray new];
    }
    return self;
}

-(void)createEntry:(Entry *)entry {
    // Saving to hard disk? iCloud? This is where you do
    // that. For now, we'll just store them in our entries
    // array (Memory)
    self.entries = [self.entries arrayByAddingObject:entry];
}

@end
