//
//  Entry.h
//  DayX
//
//  Created by Caleb Hicks on 4/25/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Entry : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * bodyText;
@property (nonatomic, retain) NSDate * timestamp;

@end
