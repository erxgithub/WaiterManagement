//
//  ViewController.m
//  StaffManagement
//
//  Created by Derek Harasen on 2015-03-14.
//  Copyright (c) 2015 Derek Harasen. All rights reserved.
//

#import "ViewController.h"
#import "Restaurant.h"
#import "RestaurantManager.h"
#import "Waiter.h"
#import "AddWaiterViewController.h"
#import "AppDelegate.h"
#import "WaiterTableViewCell.h"
#import "StaffManagement-Swift.h"

static NSString * const kCellIdentifier = @"CellIdentifier";

@interface ViewController () <WaiterProtocol>

@property IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (nonatomic, retain) NSArray *waiters;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Restaurant *currentRestaurant = [[RestaurantManager sharedManager]currentRestaurant];
    self.nameLabel.text = currentRestaurant.name;

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    [self refreshTableView];
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

- (void)addNewWaiter:(NSString *)name {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    Restaurant *currentRestaurant = [[RestaurantManager sharedManager]currentRestaurant];
    
    NSError *error = nil;
    NSEntityDescription *waiterEntity = [NSEntityDescription entityForName:@"Waiter" inManagedObjectContext:appDelegate.managedObjectContext];
    
    Waiter *newWaiter = [[Waiter alloc]initWithEntity:waiterEntity insertIntoManagedObjectContext:appDelegate.managedObjectContext];
    newWaiter.name = name;
    newWaiter.restaurant = currentRestaurant;
    [currentRestaurant addStaffObject:newWaiter];
    
    [appDelegate.managedObjectContext save:&error];
    [self refreshTableView];
}

- (void)refreshTableView {
    NSSortDescriptor *sortByName = [[NSSortDescriptor alloc]initWithKey:@"name" ascending:YES];
    self.waiters = [[[RestaurantManager sharedManager]currentRestaurant].staff sortedArrayUsingDescriptors:@[sortByName]];
    [self.tableView reloadData];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"addWaiter"]) {
        AddWaiterViewController *vc = [segue destinationViewController];
        vc.delegate = self;
        vc.restaurantName = self.nameLabel.text;
    } else if ([segue.identifier isEqualToString:@"waiterShifts"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Waiter *waiter = self.waiters[indexPath.row];
        ShiftViewController *vc = [segue destinationViewController];
        vc.waiter = waiter;
    }
}

#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.waiters.count;
}

- (BOOL)tableView: tableView canEditRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        AppDelegate *appDelegate = (AppDelegate*) [UIApplication sharedApplication].delegate;
        Restaurant *currentRestaurant = [[RestaurantManager sharedManager]currentRestaurant];
        
        NSError *error = nil;
        Waiter *waiter = self.waiters[indexPath.row];
        [appDelegate.managedObjectContext deleteObject:waiter];
        [currentRestaurant removeStaffObject:waiter];
        [appDelegate.managedObjectContext save:&error];
        [self refreshTableView];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WaiterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WaiterCell" forIndexPath:indexPath];
    
    Waiter *waiter = self.waiters[indexPath.row];
    cell.nameLabel.text = waiter.name;

    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor colorWithRed:214.0/255.0 green:214.0/255.0 blue:214.0/255.0 alpha:1.0];
    }  else {
        cell.backgroundColor = [UIColor whiteColor];
    }

    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.backgroundColor = [UIColor colorWithRed:118.0/255.0 green:214.0/255.0 blue:255.0/255.0 alpha:1.0];
    cell.selectedBackgroundView = backgroundView;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"waiterShifts" sender:self];
}

@end
