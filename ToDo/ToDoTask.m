//
//  ToDoTask.m
//  ToDo
//
//  Created by Eric Groseclos on 2018-02-11.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

#import "ToDoTask.h"

NSString *keyTask = @"task";
NSString *keyTaskNote = @"taskNote";
NSString *keyPriority = @"priority";
NSString *keyCompleted = @"completed";

@implementation ToDoTask

// Instantiates all four properties.
- (instancetype) initTask:(NSString*)task info:(NSString*)taskNote important:(BOOL)isImportant completed:(BOOL)isCompleted {
    self = [super init];
    
    if (self) {
        self.task = task;
        self.taskNote = taskNote;
        self.priority = isImportant;
        self.completed = isCompleted;
    }
    
    return self;
}

// Deserializes from memory.
- (instancetype)initWithCoder:(NSCoder*)aDecoder {
    
    self = [super init];
    
    if (self) {
        self.task = [aDecoder decodeObjectForKey:keyTask];
        
        self.taskNote = [aDecoder decodeObjectForKey:keyTaskNote];
        
        self.priority = [aDecoder decodeIntegerForKey:keyPriority];
        
        self.completed = [aDecoder decodeIntegerForKey:keyCompleted];
    }
    
    return self;
}

// Uses serialization to save to memory.
- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    [aCoder encodeObject:self.task forKey:keyTask];
    
    [aCoder encodeObject:self.taskNote forKey:keyTaskNote];
    
    [aCoder encodeInteger:self.priority forKey:keyPriority];
    
    [aCoder encodeInteger:self.completed forKey:keyCompleted];
}

@end
