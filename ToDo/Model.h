//
//  Model.h
//  ToDo
//
//  Created by Eric Groseclos on 2018-01-26.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

#import "ToDoTask.h"

static const int sectionIncompleted = 0;

static const int sectionCompleted = 1;

@interface Model : NSObject

- (instancetype)init;

- (void)addTask:(ToDoTask*)task;

- (NSArray*)getAllTasks;

- (NSMutableArray*)getTasksForSection:(int)section;

- (void)setTaskAsCompleted:(NSString*)titleOfTask;

- (void)saveEditedTask:(NSString*)titleOfTask info:(NSString*)taskNote important:(BOOL)isImportant;

@end
