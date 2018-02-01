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

// There is a single section in the used TableView.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// The number of rows is equal to the number of tasks.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([self.model getTaskAmount] == 0) {
        return 0;
    } else {
        return [self.model getTaskAmount];
    }
}

// As the row count starts from zero,
// the row number must be increased by
// one. Fills the Label taskName via
// the corresponding row in NSUserDefaults.
// In the same fashion, if a task is important,
// the image 'important.png' is shown to
// represent that. If a completed task is loaded,
// its buttons are disabled, and its text changed
// to the color green.
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    NSInteger rowNumber = indexPath.row + 1;
    
    BOOL isCompleted = NO;
    
    ToDoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"taskCell" forIndexPath:indexPath];
    
    if ([self.model getCompletionStatus:rowNumber]) {
        isCompleted = YES;
    }
    
    UILabel *taskName = cell.taskName;
    UIImageView *importantTask = cell.todoImageView;
    
    if ([self.model getSingleTask:indexPath.row] != nil) {
        
        taskName.text = [self.model getSingleTask:rowNumber];
        
        if (isCompleted) {
            taskName.textColor = [UIColor greenColor];
            cell.editButton.enabled = NO;
            cell.completeButton.enabled = NO;
        }
        
        if ([self.model getSinglePriority:rowNumber]) {
            importantTask.image = [UIImage imageNamed:@"important.png"];
            importantTask.contentMode = UIViewContentModeScaleAspectFit;
        }
    }
    
    /*if (isCompleted) {
        NSLog(@"Entered reordering");
        //Reorder the table so that completed tasks appear at the beginning of the list.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        NSIndexPath *rowZero = [NSIndexPath indexPathForRow:0 inSection:0];
        
        [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:rowZero] withRowAnimation:UITableViewRowAnimationFade];
    }*/
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - IBActions

// Sets the selected task as completed. Reloads
// the TableView, to update the application.
- (IBAction)completeTask:(id)sender {
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.theTableView];
    
    NSIndexPath *indexPath = [self.theTableView indexPathForRowAtPoint:buttonPosition];
    
    NSInteger rowNumber = indexPath.row + 1;
    
    if (indexPath != nil) {
        [self.model setTaskAsCompleted:rowNumber];
        
        [self.theTableView reloadData];
    }
}

#pragma mark - Navigation

// Provides the row number of the clicked cell to
// EditsTableViewController, in case 'editTaskSegue'.
// As the cell index starts from zero, the row number
// must be increased by one.
// taskToLoad is set to -1 in 'taskSegue':s case, as a task is
// to be created for the first time.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"taskSegue"]) {
        [self.model loadTaskAmount];
        
        EditsTableViewController *editTask = [segue destinationViewController];
        
        editTask.taskToLoad = -1;
    } else if ([segue.identifier isEqualToString:@"editTaskSegue"]) {
        
        EditsTableViewController *editTask = [segue destinationViewController];
        
        CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.theTableView];
        
        NSIndexPath *indexPath = [self.theTableView indexPathForRowAtPoint:buttonPosition];
        
        if (indexPath != nil) {
            editTask.taskToLoad = indexPath.row + 1;
        } else {
            [self.model loadTaskAmount];
            editTask.taskToLoad = -1;
        }
    }
}

@end
