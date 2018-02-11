//
//  Model.m
//  ToDo
//
//  Created by Eric Groseclos on 2018-01-26.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"

NSString *taskSaveKey = @"tasks";

@interface Model ()

@property (nonatomic) NSMutableArray *tasks;

@end

@implementation Model

// Loads the NSMutableArray
// that is be used, 'tasks'
// with data from NSUserDefaults.
- (instancetype)init {
    self = [super init];
    
    if (self) {
        NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
        
        NSData *data = [preferences objectForKey:taskSaveKey];
        
        self.tasks = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        if (!self.tasks) {
            self.tasks = [[NSMutableArray alloc] init];
        }
    }
    
    return self;
}

// Adds a task to the list of tasks.
- (void)addTask:(ToDoTask*)task {
    [self.tasks addObject:task];
    [self saveTask];
}

// Saves the list of tasks via serialization.
- (void)saveTask {
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.tasks];
    
    [preferences setObject:data forKey:taskSaveKey];
    
    [preferences synchronize];
}

// Gets every single task from the
// list in a NSArray.
- (NSArray*)getAllTasks {
    return self.tasks;
}

// Retrieves all tasks for a specific section.
- (NSArray*)getTasksForSection:(int)section {
    NSMutableArray *todosForSection = [[NSMutableArray alloc] init];
    
    for (ToDoTask *task in self.tasks) {
        if ((section == sectionIncompleted && !task.completed) || (section == sectionCompleted && task.completed)) {
            [todosForSection addObject:task];
        }
    }
    
    return todosForSection;
}

@end

