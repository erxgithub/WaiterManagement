//
//  ShiftViewController.swift
//  StaffManagement
//
//  Created by Eric Gregor on 2018-03-30.
//  Copyright © 2018 Derek Harasen. All rights reserved.
//

import UIKit

@objc class ShiftViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var waiter: Waiter?
    var shifts: [Shift] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = waiter?.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        if tableView.isEditing {
            sender.title = "Edit"
            tableView.setEditing(false, animated: true)
        } else {
            sender.title = "Done"
            tableView.setEditing(true, animated: false)
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "addShift" {
            guard let addShiftViewController = segue.destination as? AddShiftViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            addShiftViewController.waiterName = waiter!.name

        }

    }
    
}

extension ShiftViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shifts.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShiftCell", for: indexPath) as? ShiftTableViewCell
        else {
            fatalError("The dequeued cell is not an instance of UITableViewCell.")
        }
        
        let shift = shifts[indexPath.row]

        //    Waiter *waiter = self.waiters[indexPath.row];
        //    cell.textLabel.text = waiter.name;

//        //***
//        let workout = workouts[indexPath.row]
//
//        var duration = 0.0
//        let count = workout.sets?.count ?? 0
//        for workoutSet in workout.sets! {
//            let ws = workoutSet as! Set
//            duration += ws.seconds
//        }
//
//        cell.workoutTitleLabel.text = workout.title?.uppercased()
//        cell.setCountLabel.text = "SETS - \(count)"
//        cell.totalDurationLabel.text = timeString(interval: duration, format: "")
//
//        //***
//        //        let workout = workouts![indexPath.row]
//        //
//        //        let duration = workout.sets?.reduce(0) { $0 + $1.seconds }
//        //
//        //        cell.workoutTitleLabel.text = workout.title
//        //        cell.setCountLabel.text = "\(workout.sets?.count ?? 0)"
//        //        cell.totalDurationLabel.text = "\(duration ?? 0.0)"
//        //***
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //        AppDelegate *appDelegate = (AppDelegate*) [UIApplication sharedApplication].delegate;
            //        Restaurant *currentRestaurant = [[RestaurantManager sharedManager]currentRestaurant];
            //
            //        NSError *error = nil;
            //        Waiter *waiter = self.waiters[indexPath.row];
            //        [appDelegate.managedObjectContext deleteObject:waiter];
            //        [currentRestaurant removeStaffObject:waiter];
            //        [appDelegate.managedObjectContext save:&error];
            //        [self refreshTableView];

            //            context.delete(workouts[indexPath.row])
//
//            do {
//                try context.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//
//            fetchWorkout()
        }
        
    }
    
}
