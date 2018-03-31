//
//  ShiftViewController.m
//  StaffManagement
//
//  Created by Eric Gregor on 2018-03-30.
//  Copyright © 2018 Derek Harasen. All rights reserved.
//

#import "ShiftViewController.h"

@interface ShiftViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ShiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)editButtonPressed:(id)sender {
    if (self.tableView.isEditing) {
        [sender setTitle:@"Edit"];
        [self.tableView setEditing:NO animated:YES];
    } else {
        [sender setTitle:@"Done"];
        [self.tableView setEditing:YES animated:YES];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - TableView Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (BOOL)tableView: tableView canEditRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        AppDelegate *appDelegate = (AppDelegate*) [UIApplication sharedApplication].delegate;
//        Restaurant *currentRestaurant = [[RestaurantManager sharedManager]currentRestaurant];
//
//        NSError *error = nil;
//        Waiter *waiter = self.waiters[indexPath.row];
//        [appDelegate.managedObjectContext deleteObject:waiter];
//        [currentRestaurant removeStaffObject:waiter];
//        [appDelegate.managedObjectContext save:&error];
//        [self refreshTableView];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShiftCell" forIndexPath:indexPath];
//    Waiter *waiter = self.waiters[indexPath.row];
//    cell.textLabel.text = waiter.name;
    return cell;
}

@end
