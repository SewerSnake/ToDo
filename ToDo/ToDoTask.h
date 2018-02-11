//
//  ToDoTask.h
//  ToDo
//
//  Created by Eric Groseclos on 2018-02-11.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoTask : NSObject <NSCoding>

@property (nonatomic) NSString *task;

@property (nonatomic) NSString *taskNote;

@property (nonatomic) BOOL priority;

@property (nonatomic) BOOL completed;

- (instancetype) initTask:(NSString*)task info:(NSString*)taskNote important:(BOOL)isImportant completed:(BOOL)isCompleted;

@end
