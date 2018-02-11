//
//  ToDoTask.m
//  ToDo
//
//  Created by Eric Groseclos on 2018-02-11.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

#import "ToDoTask.h"

NSString *task = @"task";
NSString *taskNote = @"taskNote";
NSString *priority = @"priority";
NSString *completed = @"completed";

@implementation ToDoTask

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

- (instancetype)initWithCoder:(NSCoder*)aDecoder {
    
    self = [super init];
    
    if (self) {
        self.task = [aDecoder decodeObjectForKey:task];
    }
    
    return self;
}

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    <#code#>
}

@end
