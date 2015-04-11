//
//  Entry.h
//  DayX
//
//  Created by Caleb Hicks on 4/11/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Entry : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *bodyText;
@property (strong, nonatomic) NSDate *timestamp;

@end
