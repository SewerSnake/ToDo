//
//  Model.h
//  ToDo
//
//  Created by Eric Groseclos on 2018-01-26.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

@interface Model : NSObject

@property (nonatomic) NSInteger taskIndex;

- (NSDictionary*)getData;

- (void)saveInfo:(NSString*)task saveNotes:(NSString*)taskNotes important:(BOOL)isImportant;

@end
