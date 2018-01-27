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

- (NSDictionary*)getData {
    return nil;
}

// Saves the task header, the task notes and
// the crucial 'important' variable to
// NSUserDefaults.
- (void)saveInfo:(NSString*)task saveNotes:(NSString*)taskNotes important:(BOOL) isImportant {
    
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    
    if ([preferences objectForKey:@"taskIndex"] == nil || self.taskIndex == NSIntegerMax) {
        self.taskIndex = 1;
    } else {
        self.taskIndex = [preferences integerForKey:@"taskIndex"];
        self.taskIndex++;
    }
    
    NSString *index1 = [task stringByAppendingString:@(self.taskIndex).stringValue];
    //NSLog(task);
    NSString *index2 = [taskNotes stringByAppendingString:@(self.taskIndex).stringValue];
    //NSLog(taskNotes);
    NSString *index3 = [@"important" stringByAppendingString:@(self.taskIndex).stringValue];
    //NSLog(@(isImportant).stringValue);
    [preferences setObject:task forKey:index1];
    
    [preferences setObject:taskNotes forKey:index2];
    
    [preferences setBool:isImportant forKey:index3];
    
    [preferences synchronize];
    
}

@end

