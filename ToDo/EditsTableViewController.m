//
//  EditsTableViewController.m
//  ToDo
//
//  Created by Eric Groseclos on 2018-01-26.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

#import "EditsTableViewController.h"
#import "Model.h"

@interface EditsTableViewController ()

@property (nonatomic) UIButton *flagButton;

@property (weak, nonatomic) IBOutlet UITextField *task;

@property (weak, nonatomic) IBOutlet UITextView *taskNotes;

@property (nonatomic) BOOL isImportant;

@property (nonatomic) Model *model;

@end

@implementation EditsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _model = [[Model alloc]init];
    if (_taskToLoad != -1) {
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
    
    [self.flagButton setTitle:@"" forState:UIControlStateNormal];
    
    self.flagButton.frame = CGRectMake(300, 8, 30 , 30);
    
    if (self.isImportant) {
        [self.flagButton setBackgroundImage: [UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
    } else {
        [self.flagButton setBackgroundImage: [UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
    }
    
    [self.view addSubview:self.flagButton];
}

// Shows if the task is important or not.
// Represented by two images.
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
// via the model class. Dismisses this view
// and returns to the main menu.
- (IBAction)save:(id)sender {
    if (![self.task.text isEqualToString:@""] && ![self.taskNotes.text isEqualToString:@""]) {
        
        if (_taskToLoad != -1) {
            [_model saveInfo:self.task.text saveNotes:self.taskNotes.text important:self.isImportant];
        } else {
            [_model saveInfo:self.taskToLoad saveTask:self.task.text saveNotes:self.taskNotes.text important:self.isImportant];
        }
        
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        self.task.text = @"You must enter text!";
    }
}

// Loads the task info via the row number
// provided from ListTableViewController.
- (void)loadTask {
    
    NSLog(@"%@",@(self.taskToLoad).stringValue);
    self.task.text = [_model getSingleTask:self.taskToLoad];
    self.taskNotes.text = [_model getSingleTaskNote:self.taskToLoad];
    self.isImportant = [_model getSinglePriority:self.taskToLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
