//
//  EntryController.h
//  
//
//  Created by Parker Wightman on 7/2/15.
//
//

#import <Foundation/Foundation.h>
#import "Entry.h"

// The job of the EntryController is to hide the complexity
// of where our Entry objects are actually stored
// (e.g. Memory, Hard Drive, "Cloud", etc.)
// Specifically, it allows us to perform the CRUD actions
//
// C - Create
// R - Read
// U - Update
// D - Destroy
@interface EntryController : NSObject

- (void)createEntry:(Entry *)entry;

@property (strong, readonly) NSArray *entries;

@end
