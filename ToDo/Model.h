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

- (NSMutableArray*)getTasks;

- (NSString*)getSingleTask:(NSInteger)rowNumber;

- (NSMutableArray*)getTaskNotes;

- (NSString*)getSingleTaskNote:(NSInteger)rowNumber;

- (NSMutableArray*)getPriorities;

- (void)saveInfo:(NSString*)task saveNotes:(NSString*)taskNotes important:(BOOL)isImportant;

- (void)saveInfo:(NSInteger)rowNumber saveTask:(NSString*)task saveNotes:(NSString*)taskNotes important:(BOOL) isImportant;

@end
