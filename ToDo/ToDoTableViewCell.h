//
//  ToDoTableViewCell.h
//  ToDo
//
//  Created by Eric Groseclos on 2018-01-31.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToDoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *todoImageView;
@property (weak, nonatomic) IBOutlet UILabel *taskName;
@property (weak, nonatomic) IBOutlet UIButton *completeButton;
@property (weak, nonatomic) IBOutlet UIButton *editButton;

@end
