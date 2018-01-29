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
    //NSLog(@"%@", @(taskAmount).stringValue);
    return taskAmount;
}

- (NSMutableArray*)getTasks {
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    NSMutableArray *tasks = [NSMutableArray array];
    NSInteger taskAmount = [preferences integerForKey:@"taskAmount"];
    
    for (int i = 1; i <= taskAmount; i++) {
        NSString *task = [preferences objectForKey:[@"task" stringByAppendingString:@(i).stringValue]];
        
        if (task != nil) {
            [tasks addObject:task];
        }
    }
    
    return tasks;
}

- (NSString*)getSingleTask:(NSInteger)rowNumber {
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    
    NSString *task = [preferences objectForKey:[@"task" stringByAppendingString:@(rowNumber).stringValue]];
    
    if (task != nil) {
        return task;
    } else {
        return @"";
    }
}

- (NSMutableArray*)getTaskNotes {
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    NSMutableArray *taskNotes = [NSMutableArray array];
    NSInteger taskAmount = [preferences integerForKey:@"taskAmount"];
    
    for (int i = 1; i <= taskAmount; i++) {
        NSString *taskNote = [preferences objectForKey:[@"taskNote" stringByAppendingString:@(i).stringValue]];
        
        if (taskNote != nil) {
            [taskNotes addObject:taskNote];
        }
    }
    
    return taskNotes;
}

- (NSString*)getSingleTaskNote:(NSInteger)rowNumber {
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    
    NSString *taskNote = [preferences objectForKey:[@"taskNote" stringByAppendingString:@(rowNumber).stringValue]];
    
    if (taskNote != nil) {
        return taskNote;
    } else {
        return @"";
    }
}

- (NSMutableArray*)getPriorities {
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    NSMutableArray *priorities = [NSMutableArray array];
    NSInteger taskAmount = [preferences integerForKey:@"taskAmount"];
    
    for (int i = 1; i <= taskAmount; i++) {
        BOOL priority = [preferences boolForKey:[@"priority" stringByAppendingString:@(i).stringValue]];
        
        if (priority != 0) {
            if (priority) {
                [priorities addObject:@"YES"];
            } else {
                [priorities addObject:@"NO"];
            }
        }
    }
    
    return priorities;
}

- (BOOL)getSinglePriority:(NSInteger)rowNumber {
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    
    if ([preferences objectForKey:[@"priority" stringByAppendingString:@(rowNumber).stringValue]] != nil) {
        
        BOOL priority = [preferences boolForKey:[@"priority" stringByAppendingString:@(rowNumber).stringValue]];
        
        return priority;
    } else {
        return NO;
    }
}

// Saves the task header, the task notes and
// the crucial 'priority' variable to
// NSUserDefaults. Used when a task
// is created for the first time.
- (void)saveInfo:(NSString*)task saveNotes:(NSString*)taskNotes important:(BOOL) isImportant {
    
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    
    NSInteger taskAmount = [preferences integerForKey:@"taskAmount"];
    NSLog(@"Task %@",@(taskAmount).stringValue);
    NSString *index1 = [@"task" stringByAppendingString:@(taskAmount).stringValue];
    NSLog(@"%@",index1);
    NSString *index2 = [@"taskNote" stringByAppendingString:@(taskAmount).stringValue];
    NSLog(@"%@",index2);
    NSString *index3 = [@"priority" stringByAppendingString:@(taskAmount).stringValue];
    NSLog(@"%@",index3);
    [preferences setObject:task forKey:index1];
    
    [preferences setObject:taskNotes forKey:index2];
    
    [preferences setBool:isImportant forKey:index3];
    
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

