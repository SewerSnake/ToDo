//
//  Model.h
//  ToDo
//
//  Created by Eric Groseclos on 2018-01-26.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

@interface Model : NSObject

- (void)loadTaskAmount;

- (NSInteger)getTaskAmount;

- (NSInteger)getAmountOfIncompletedTasks;

- (NSInteger)getAmountOfCompletedTasks;

- (NSArray*)getCompletedTasks;

- (NSArray*)getIncompletedTasks;

- (NSArray*)getIncompletedTaskNotes;

- (NSArray*)getIncompletedPriorities;

- (BOOL)getCompletionStatus:(NSInteger)rowNumber;

- (void)setTaskAsCompleted:(NSInteger)rowNumber;

- (void)saveInfo:(NSString*)task saveNotes:(NSString*)taskNotes important:(BOOL)isImportant completed:(BOOL)isCompleted;

- (void)saveInfo:(NSInteger)rowNumber saveTask:(NSString*)task saveNotes:(NSString*)taskNotes important:(BOOL)isImportant;

@end
