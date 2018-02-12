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
- (NSMutableArray*)getTasksForSection:(int)section {
    NSMutableArray *todosForSection = [[NSMutableArray alloc] init];
    
    for (ToDoTask *task in self.tasks) {
        if ((section == sectionIncompleted && !task.completed) || (section == sectionCompleted && task.completed)) {
            [todosForSection addObject:task];
        }
    }
    
    return todosForSection;
}

// Searches among the tasks until
// the desired task is found. Saves to memory.
// The task is now considered to be finished.
- (void)setTaskAsCompleted:(NSString*)titleOfTask {
    
    for (int i = 0; i < self.tasks.count; i++) {
        ToDoTask *task = self.tasks[i];
        
        if (task != nil && [task.task isEqualToString:titleOfTask]) {
            task.completed = YES;
            [self saveTask];
            break;
        }
    }
}

// Updates the list entry which shares the
// same task title as the edited task.
- (void)saveEditedTask:(NSString*)titleOfTask info:(NSString*)taskNote important:(BOOL)isImportant {
    
    for (int i = 0; i < self.tasks.count; i++) {
        ToDoTask *task = self.tasks[i];
        
        if (task != nil && [task.task isEqualToString:titleOfTask]) {
            task.taskNote = taskNote;
            task.priority = isImportant;
            [self saveTask];
            break;
        }
    }
}

@end

