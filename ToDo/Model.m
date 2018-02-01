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

- (NSString*)getSingleTask:(NSInteger)rowNumber {
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    
    NSString *task = [preferences objectForKey:[@"task" stringByAppendingString:@(rowNumber).stringValue]];
    
    if (task != nil) {
        return task;
    } else {
        return @"Cannot find";
    }
}

- (NSString*)getSingleTaskNote:(NSInteger)rowNumber {
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    
    NSString *taskNote = [preferences objectForKey:[@"taskNote" stringByAppendingString:@(rowNumber).stringValue]];
    
    if (taskNote != nil) {
        return taskNote;
    } else {
        return @"Cannot find";
    }
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

- (BOOL)getCompletionStatus:(NSInteger)rowNumber {
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    
    if ([preferences objectForKey:[@"completed" stringByAppendingString:@(rowNumber).stringValue]] != nil) {
        
        BOOL completionStatus = [preferences boolForKey:[@"completed" stringByAppendingString:@(rowNumber).stringValue]];
        
        return completionStatus;
    } else {
        return NO;
    }
}

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

// Swaps the data in the TableView, so that
// completed tasks appear at the top of the
// table. Does not work correctly...
- (void)reorderData:(NSInteger)rowNumber {
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    
    for (int i = 1; i <= [self getTaskAmount]; i++) {
        
        if (!([self getCompletionStatus:i])) {
            
            NSString *tempTask = [preferences objectForKey:[@"task" stringByAppendingString:@(i).stringValue]];
            NSString *tempTaskNote = [preferences objectForKey:[@"taskNote" stringByAppendingString:@(i).stringValue]];
            BOOL tempPriority = [preferences boolForKey:[@"priority" stringByAppendingString:@(i).stringValue]];
            
            NSString *index1 = [@"task" stringByAppendingString:@(i).stringValue];
            
            [preferences setObject:[self getSingleTask:rowNumber] forKey:index1];
            
            NSString *index2 = [@"taskNote" stringByAppendingString:@(i).stringValue];
            
            [preferences setObject:[self getSingleTaskNote:rowNumber] forKey:index2];
            
            NSString *index3 = [@"priority" stringByAppendingString:@(i).stringValue];
            
            [preferences setBool:[self getSinglePriority:rowNumber] forKey:index3];
            
            NSString *index4 = [@"completed" stringByAppendingString:@(i).stringValue];
            
            [preferences setBool:YES forKey:index4];
            
            NSString *index5 = [@"task" stringByAppendingString:@(rowNumber).stringValue];
            
            [preferences setObject:tempTask forKey:index5];
            
            NSString *index6 = [@"taskNote" stringByAppendingString:@(rowNumber).stringValue];
            
            [preferences setObject:tempTaskNote forKey:index6];
            
            NSString *index7 = [@"priority" stringByAppendingString:@(rowNumber).stringValue];
            
            [preferences setBool:tempPriority forKey:index7];
            
            NSString *index8 = [@"completed" stringByAppendingString:@(rowNumber).stringValue];
            
            [preferences setBool:NO forKey:index8];
            
            [preferences synchronize];
            
            break;
        }
    }
}

@end

