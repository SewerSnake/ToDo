//
//  Model.m
//  ToDo
//
//  Created by Eric Groseclos on 2018-01-26.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"

NSString *todoSaveKey = @"todos";

@interface Model ()
@property (nonatomic) NSMutableArray *todos;
@end

@implementation Model

// Loads the NSMutableArray
// that is be used, 'todos'
// with data from NSUserDefaults.
- (instancetype)init {
    self = [super init];
    
    if (self) {
        NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
        
        self.todos = [preferences objectForKey:todoSaveKey];
        
        if (!self.todos) {
            self.todos = [[NSMutableArray alloc] init];
        }
    }
    
    return self;
}

// Adds a ToDoTask to the list.
- (void)addToDo:(ToDoTask*)todo {
    [self.todos addObject:todo];
    [self saveTask];
}

// Saves the list to NSUserDefaults.
- (void)saveTask {
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    [preferences setObject:self.todos forKey:todoSaveKey];
    [preferences synchronize];
}

// Gets every single task from the
// list in a NSArray.
- (NSArray*)getAllToDos {
    return self.todos;
}

@end

