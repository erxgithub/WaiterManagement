//
//  ShiftViewController.swift
//  StaffManagement
//
//  Created by Eric Gregor on 2018-03-30.
//  Copyright © 2018 Derek Harasen. All rights reserved.
//

import UIKit

@objc class ShiftViewController: UIViewController, WaiterShiftDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var waiter: Waiter?
    var shifts: [Any]? = []

    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = waiter?.name
        
        shifts = Array(waiter!.shifts).sorted(by: {($0 as AnyObject).startTime < ($1 as AnyObject).startTime})
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
    
    // MARK: - Delegates
    
    func addWaiterShift(startTime: Date, finishTime: Date) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let shiftEntity = NSEntityDescription.entity(forEntityName: "Shift", in: appDelegate?.managedObjectContext ?? NSManagedObjectContext())
        let newShift = Shift(entity: shiftEntity!, insertInto: appDelegate?.managedObjectContext)
        
        newShift.startTime = startTime
        newShift.finishTime = finishTime
        newShift.waiter = waiter
        
        waiter?.addShiftObject(newShift)
        
        do {
            try appDelegate?.managedObjectContext.save()
        }
        catch let error as NSError {
            fatalError("Error: \(error.localizedDescription)")
        }
        
        shifts?.append(newShift)
        tableView.reloadData()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "addShift" {
            guard let addShiftViewController = segue.destination as? AddShiftViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            addShiftViewController.delegate = self
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
        return shifts!.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShiftCell", for: indexPath) as? ShiftTableViewCell
        else {
            fatalError("The dequeued cell is not an instance of UITableViewCell.")
        }
        
        let shift = shifts![indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
        
        let startTime = dateFormatter.string(from: (shift as AnyObject).startTime)
        let finishTime = dateFormatter.string(from: (shift as AnyObject).finishTime)

        cell.startTime.text = startTime
        cell.startTime.sizeToFit()
        
        cell.finishTime.text = finishTime
        cell.finishTime.sizeToFit()
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor(red: 214.0/255.0, green: 214.0/255.0, blue: 214.0/255.0, alpha: 1.0)
        }  else {
            cell.backgroundColor = UIColor.white
        }

        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(red: 118.0/255.0, green: 214.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            let shift = shifts![indexPath.row]
            appDelegate?.managedObjectContext.delete(shift as! NSManagedObject)
            waiter?.removeShiftObject(shift as! NSManagedObject)
            
            do {
                try appDelegate?.managedObjectContext.save()
            } catch let error as NSError {
                fatalError("Error: \(error.localizedDescription)")
            }
            
            shifts?.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
}
