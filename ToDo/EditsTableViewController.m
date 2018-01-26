//
//  EditsTableViewController.m
//  ToDo
//
//  Created by Eric Groseclos on 2018-01-26.
//  Copyright © 2018 Eric Groseclos. All rights reserved.
//

#import "EditsTableViewController.h"

@interface EditsTableViewController ()

@property (nonatomic) UIButton *flagButton;

@property (nonatomic) BOOL isImportant;

@end

@implementation EditsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isImportant = NO;
    [self createButton];

}

// Creates a button that allows the user to
// mark the task as extra important.
- (void)createButton {
    self.flagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.flagButton addTarget:self action:@selector(flagMethod) forControlEvents:UIControlEventTouchUpInside];
    
    [self.flagButton setTitle:@"" forState:UIControlStateNormal];
    
    self.flagButton.frame = CGRectMake(300, 8, 30 , 30);
    
    [self.flagButton setBackgroundImage: [UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
    
    [self.view addSubview:self.flagButton];
}

// Shows if the task is important or not.
// Represented by two images.
- (void)flagMethod {
    if (self.isImportant) {
        [self.flagButton setBackgroundImage: [UIImage imageNamed:@"star.png"] forState:UIControlStateNormal];
        self.isImportant = NO;
        NSLog(@"Not important!");
    } else {
        [self.flagButton setBackgroundImage: [UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
        self.isImportant = YES;
        NSLog(@"Important Task!");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}


@end
