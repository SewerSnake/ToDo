//
//  EditsTableViewController.m
//  ToDo
//
//  Created by Eric Groseclos on 2018-01-26.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

#import "EditsTableViewController.h"
#import "Model.h"
#import "ToDoTask.h"

@interface EditsTableViewController ()

@property (nonatomic) UIButton *flagButton;

@property (weak, nonatomic) IBOutlet UITextField *task;

@property (weak, nonatomic) IBOutlet UITextView *taskNotes;

@property (nonatomic) BOOL isImportant;

@property (nonatomic) Model *model;

@end

@implementation EditsTableViewController

// Ensures that the user can
// write the title of the task immediately.
// Instantiates the Model
// class. If taskToLoad is
// -1, a new task is to be
// created. Otherwise,
// the corresponding
// task notes and priority are
// loaded for that incompleted task.
// The interactable button is also created.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.task becomeFirstResponder];
    
    self.model = [[Model alloc] init];
    
    if (self.taskToLoad != -1) {
         [self.task setUserInteractionEnabled:NO];
        [self loadTask];
    } else {
        self.isImportant = NO;
    }
    
    [self createButton];
}

// Creates a button that allows the user to
// mark the task as extra important.
- (void)createButton {
    self.flagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.flagButton addTarget:self action:@selector(flagMethod) forControlEvents:UIControlEventTouchUpInside];
    
    self.flagButton.frame = CGRectMake(300, 8, 30 , 30);
    
    if (self.isImportant) {
        [self.flagButton setBackgroundImage: [UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
    } else {
        [self.flagButton setBackgroundImage: [UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
    }
    
    [self.view addSubview:self.flagButton];
}

// Shows if the task is important or not.
// Represented by two images of a star.
- (void)flagMethod {
    if (self.isImportant) {
        [self.flagButton setBackgroundImage: [UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
        self.isImportant = NO;
    } else {
        [self.flagButton setBackgroundImage: [UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
        self.isImportant = YES;
    }
}

// Saves what the user wrote to NSUserDefaults
// via the model class. Either an entirely new
// task is saved to the list, or a current entry
// is edited.
// After saving, the app proceeds to the list of tasks.
- (IBAction)save:(id)sender {
    if (![self.task.text isEqualToString:@""] && ![self.taskNotes.text isEqualToString:@""]) {
        
        if (self.taskToLoad == -1) {
            ToDoTask *newTask = [[ToDoTask alloc]initTask:self.task.text info:self.taskNotes.text important:self.isImportant completed:NO];
            
            [self.model addTask:newTask];
        } else {
            [self.model saveEditedTask:self.task.text info:self.taskNotes.text important:self.isImportant];
        }
        
        [self performSegueWithIdentifier:@"backToListSegue" sender:self];
    } else {
        self.task.text = @"You must enter text!";
    }
}

// Loads the task info via the row number
// provided from ListTableViewController.
- (void)loadTask {
    NSArray *incompletedTasks = [self.model getTasksForSection:sectionIncompleted];
    
    ToDoTask *task = incompletedTasks[self.taskToLoad];
    
    self.task.text = task.task;
    self.taskNotes.text = task.taskNote;
    self.isImportant = task.priority;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
