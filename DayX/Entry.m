//
//  Entry.m
//  DayX
//
//  Created by Caleb Hicks on 4/11/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "Entry.h"

@implementation Entry

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.title = dictionary[TitleKey];
        self.bodyText = dictionary[BodyTextKey];
        self.timestamp = dictionary[TimeStampKey];
    }
    return self;
}

- (NSDictionary *)dictionaryRepresentation {
    NSDictionary *dictionary = @{
                                 TitleKey : self.title,
                                 BodyTextKey : self.bodyText,
                                 TimeStampKey : self.timestamp,
                                 };
    
    return dictionary;
}

@end
