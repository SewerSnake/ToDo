//
//  ListTableViewController.m
//  ToDo
//
//  Created by Eric Groseclos on 2018-01-26.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

#import "ListTableViewController.h"
#import "EditsTableViewController.h"
#import "Model.h"
#import "ToDoTableViewCell.h"

@interface ListTableViewController ()

@property (nonatomic) NSMutableArray *tasks;

@property (nonatomic) NSMutableArray *taskNotes;

@property (strong, nonatomic) IBOutlet UITableView *theTableView;

@property (nonatomic) Model *model;

@end

@implementation ListTableViewController

// Creates an object of the Model
// class.
- (void)viewDidLoad {
    [super viewDidLoad];
    self.model = [[Model alloc] init];
}

// Reloads the TableView.
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.theTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

// There are two sections; One for
// incompleted tasks and one for completed
// tasks.
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
    return 2;
}

// The number of rows is adjusted, depending
// on which section it is.
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *todosForSection = [self.model getTasksForSection:(int)section];
    
    return todosForSection.count;
}

// Fills the Label taskName via
// the corresponding row. If it an incompleted
// task, it is added to the first section.
// If it is a completed task, it is added to
// the second section.
// If a task is important,
// the image 'important.png' is shown to
// represent that. If a completed task is loaded,
// its buttons are disabled, and its text changed
// to the color green. The image is not shown.
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
   
    ToDoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"taskCell" forIndexPath:indexPath];
    
    UILabel *taskName = cell.taskName;
    
    UIImageView *importantTask = cell.todoImageView;
    
    NSArray *filteredTasks = nil;
    
    ToDoTask *task = nil;
    
    if ([self.model getTasksForSection:(int)indexPath.section] != nil) {
        filteredTasks = [self.model getTasksForSection:(int)indexPath.section];
        
        task = filteredTasks[indexPath.row];
    }
    
    if (task != nil && !task.completed && indexPath.section == 0) {
        
        taskName.text = task.task;
        
        if (task.priority) {
            importantTask.image = [UIImage imageNamed:@"important.png"];
            importantTask.contentMode = UIViewContentModeScaleAspectFit;
        }
    }
    
    if (task != nil && task.completed && indexPath.section == 1) {
       
        taskName.text = task.task;
        
        taskName.textColor = [UIColor greenColor];
        
        cell.editButton.enabled = NO;
        
        cell.completeButton.enabled = NO;
    }
    
    return cell;
}

#pragma mark - IBActions

// Sets the selected task as completed. Reloads
// the TableView, to update the application.
- (IBAction)completeTask:(id)sender {
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.theTableView];
    
    NSIndexPath *indexPath = [self.theTableView indexPathForRowAtPoint:buttonPosition];
    
    if (indexPath != nil) {
        [self.model setTaskAsCompleted:indexPath.row];
        
        [self.theTableView reloadData];
    }
}

#pragma mark - Navigation

// Provides the row number of the clicked cell to
// EditsTableViewController, in case 'editTaskSegue'.
// taskToLoad is set to -1 in 'taskSegue':s case, as a task is
// to be created for the first time.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"taskSegue"]) {
        
        EditsTableViewController *editTask = [segue destinationViewController];
        
        editTask.taskToLoad = -1;
    } else if ([segue.identifier isEqualToString:@"editTaskSegue"]) {
        
        EditsTableViewController *editTask = [segue destinationViewController];
        
        CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.theTableView];
        
        NSIndexPath *indexPath = [self.theTableView indexPathForRowAtPoint:buttonPosition];
        
        if (indexPath != nil) {
            editTask.taskToLoad = indexPath.row;
        } else {
            editTask.taskToLoad = -1;
        }
    }
}

@end
