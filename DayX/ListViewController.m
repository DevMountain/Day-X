//
//  ViewController.m
//  DayX
//
//  Created by Caleb Hicks on 4/10/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "ListViewController.h"
#import "DetailViewController.h"
#import "EntryController.h"

@interface ListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"viewEntry"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        DetailViewController *viewController = segue.destinationViewController;
        
        Entry *entry = [EntryController sharedInstance].entries[indexPath.row];
        
        viewController.entry = entry;
    }
}

@end
