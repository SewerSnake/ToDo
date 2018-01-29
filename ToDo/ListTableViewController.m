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

@interface ListTableViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) NSMutableArray *tasks;

@property (nonatomic) NSMutableArray *taskNotes;

@property (nonatomic) NSMutableArray *prioritizer;

@property (nonatomic) Model *model;

@end

@implementation ListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.model = [[Model alloc] init];
}

// Loads data from NSUserDefaults into
// the data dictionary via the model class.
- (void) loadData {
    if ([_model getTasks].count != 0 && [_model getTasks] != nil) {
        self.tasks = [_model getTasks];
    }
    if ([_model getTaskNotes].count != 0 && [_model getTaskNotes] != nil) {
        self.taskNotes = [_model getTaskNotes];
    }
    if ([_model getPriorities].count != 0 && [_model getPriorities] != nil) {
        self.prioritizer = [_model getPriorities];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([_model getTaskAmount] == 0) {
        return 0;
    } else {
        return [_model getTaskAmount];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self loadData];
    }
    
    NSLog(@"Cell row number: %@",@(indexPath.row).stringValue);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"taskCell" forIndexPath:indexPath];
    
    UILabel *taskName = cell.textLabel;
    UIImageView *importantTask = cell.imageView;
    NSLog(@"%@",self.tasks[indexPath.row]);
    if (self.tasks[indexPath.row] != nil) {
        
        taskName.text = self.tasks[indexPath.row];
        
        if ([_model getSinglePriority:indexPath.row]) {
            importantTask.image = [UIImage imageNamed:@"important.png"];
            importantTask.contentMode = UIViewContentModeScaleAspectFit;
        }
    }
    
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

#pragma mark - Navigation

//
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"taskSegue"]) {
        [_model loadTaskAmount];
        EditsTableViewController *editTask = [segue destinationViewController];
        editTask.taskToLoad = -1;
    } else if ([segue.identifier isEqualToString:@"editTaskSegue"]) {
        
        //UITableViewCell *cell = sender;
        
        EditsTableViewController *editTask = [segue destinationViewController];
        
        NSIndexPath *task = self.tableView.indexPathForSelectedRow;
        
        editTask.taskToLoad = task.row;
    }
}

@end
