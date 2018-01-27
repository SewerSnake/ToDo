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

- (NSMutableArray*)getTaskNotes;

- (NSMutableArray*)getPriorities;

- (void)saveInfo:(NSString*)task saveNotes:(NSString*)taskNotes important:(BOOL)isImportant;

@end
