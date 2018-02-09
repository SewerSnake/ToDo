//
//  Model.m
//  ToDo
//
//  Created by Eric Groseclos on 2018-01-26.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"

@implementation Model

// Loads the current index, i.e. how
// many entries the user has written.
// Ensures that a value always exists,
// regardless if it is the first time
// running the app or taskAmount reaches
// the maximum value. Increases taskAmount
// by one for the upcoming entry.
- (void) loadTaskAmount {
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    
    NSInteger taskAmount;
    
    if ([preferences integerForKey:@"taskAmount"] == 0) {
        taskAmount = 1;
    } else {
        taskAmount = [preferences integerForKey:@"taskAmount"];
        
        if (taskAmount == NSIntegerMax) {
            taskAmount = 1;
        } else {
            taskAmount++;
        }
    }
    
    [preferences setInteger:taskAmount forKey:@"taskAmount"];
    
    [preferences synchronize];
}

// Getter method for the task index.
- (NSInteger)getTaskAmount {
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    
    NSInteger taskAmount = [preferences integerForKey:@"taskAmount"];
    
    return taskAmount;
}

// Returns how many tasks that aren't finished.
// Used in consideration for the first section
// of the TableView.
- (NSInteger)getAmountOfIncompletedTasks {
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    int count = 0;
    
    for (int i = 1; i <= [self getTaskAmount]; i++) {
        BOOL completionStatus = [preferences boolForKey:[@"completed" stringByAppendingString:@(i).stringValue]];
        
        if (!completionStatus) {
            count++;
        }
    }
    
    return count;
}

// Returns how many tasks have been completed.
// Used in consideration for the second section
// of the TableView.
- (NSInteger)getAmountOfCompletedTasks {
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    int count = 0;
    
    for (int i = 1; i <= [self getTaskAmount]; i++) {
        BOOL completionStatus = [preferences boolForKey:[@"completed" stringByAppendingString:@(i).stringValue]];
        
        if (completionStatus) {
            count++;
        }
    }
    
    return count;
}

- (NSArray*)getCompletedTasks {
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    NSMutableArray *tasks = [[NSMutableArray alloc] init];
    
    for (int i = 1; i <= [self getAmountOfIncompletedTasks]; i++) {
        if ([preferences boolForKey:[@"completed" stringByAppendingString:@(i).stringValue]]) {
            NSString *task = [preferences objectForKey:[@"task" stringByAppendingString:@(i).stringValue]];
            [tasks addObject:task];
        }
    }
    return tasks;
}

- (NSArray*)getIncompletedTasks {
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    NSMutableArray *tasks = [[NSMutableArray alloc] init];
    
    for (int i = 1; i <= [self getAmountOfIncompletedTasks]; i++) {
        if (![preferences boolForKey:[@"completed" stringByAppendingString:@(i).stringValue]]) {
            NSString *task = [preferences objectForKey:[@"task" stringByAppendingString:@(i).stringValue]];
            [tasks addObject:task];
        }
    }
    return tasks;
}

- (NSArray*)getIncompletedTaskNotes {
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    NSMutableArray *taskNotes = [[NSMutableArray alloc] init];
    
    for (int i = 1; i <= [self getAmountOfIncompletedTasks]; i++) {
        if (![preferences boolForKey:[@"completed" stringByAppendingString:@(i).stringValue]]) {
            NSString *taskNote = [preferences objectForKey:[@"taskNote" stringByAppendingString:@(i).stringValue]];
            [taskNotes addObject:taskNote];
        }
    }
    return taskNotes;
}

- (NSArray*)getIncompletedPriorities {
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    NSMutableArray *priorities = [[NSMutableArray alloc] init];
    
    for (int i = 1; i <= [self getAmountOfIncompletedTasks]; i++) {
        if (![preferences boolForKey:[@"completed" stringByAppendingString:@(i).stringValue]]) {
            BOOL priority = [preferences boolForKey:[@"priority" stringByAppendingString:@(i).stringValue]];
            if (priority) {
                [priorities addObject:@"YES"];
            } else {
                [priorities addObject:@"NO"];
            }
        }
    }
    return priorities;
}

- (BOOL)getCompletionStatus:(NSInteger)rowNumber {
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    
    if ([preferences objectForKey:[@"completed" stringByAppendingString:@(rowNumber).stringValue]] != nil) {
        
        BOOL completionStatus = [preferences boolForKey:[@"completed" stringByAppendingString:@(rowNumber).stringValue]];
        
        return completionStatus;
    } else {
        return NO;
    }
}

// The task is completed by setting
// the corrsponding BOOL in NSUserDefaults
// to YES.
- (void)setTaskAsCompleted:(NSInteger)rowNumber {
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    
    NSString *index = [@"completed" stringByAppendingString:@(rowNumber).stringValue];
    
    [preferences setBool:YES forKey:index];
    
    [preferences synchronize];
}

// Saves the task header, the task notes and
// the crucial 'priority' variable to
// NSUserDefaults. Used when a task
// is created for the first time.
- (void)saveInfo:(NSString*)task saveNotes:(NSString*)taskNotes important:(BOOL)isImportant completed:(BOOL)isCompleted {
    
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    
    NSInteger taskAmount = [preferences integerForKey:@"taskAmount"];

    NSString *index1 = [@"task" stringByAppendingString:@(taskAmount).stringValue];
   
    NSString *index2 = [@"taskNote" stringByAppendingString:@(taskAmount).stringValue];
   
    NSString *index3 = [@"priority" stringByAppendingString:@(taskAmount).stringValue];
   
    NSString *index4 = [@"completed" stringByAppendingString:@(taskAmount).stringValue];
    
    [preferences setObject:task forKey:index1];
    
    [preferences setObject:taskNotes forKey:index2];
    
    [preferences setBool:isImportant forKey:index3];
    
    [preferences setBool:NO forKey:index4];
    
    [preferences synchronize];
}

// Saves the task header, the task notes and
// the crucial 'priority' variable to
// the specific row. Used while editing
// an existing task.
- (void)saveInfo:(NSInteger)rowNumber saveTask:(NSString*)task saveNotes:(NSString*)taskNotes important:(BOOL) isImportant {
    
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    
    NSString *index1 = [@"task" stringByAppendingString:@(rowNumber).stringValue];
    
    NSString *index2 = [@"taskNote" stringByAppendingString:@(rowNumber).stringValue];
    
    NSString *index3 = [@"priority" stringByAppendingString:@(rowNumber).stringValue];
    
    [preferences setObject:task forKey:index1];
    
    [preferences setObject:taskNotes forKey:index2];
    
    [preferences setBool:isImportant forKey:index3];
    
    [preferences synchronize];
}

@end

