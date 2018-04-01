//
//  AddShiftViewController.swift
//  StaffManagement
//
//  Created by Eric Gregor on 2018-03-30.
//  Copyright © 2018 Derek Harasen. All rights reserved.
//

import UIKit

protocol WaiterShiftDelegate {
    func addWaiterShift(startTime: Date, finishTime: Date)
}

@objc class AddShiftViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var startTimePicker: UIDatePicker!
    @IBOutlet weak var finishTimePicker: UIDatePicker!
    
    var delegate: WaiterShiftDelegate?
    var waiterName: String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        nameLabel.text = waiterName
        
        let dateFormatter = DateFormatter()
        
        startTimePicker.date = dateFormatter.calendar.date(bySetting: .minute, value: 0, of: Date())!
        
        finishTimePicker.date = dateFormatter.calendar.date(bySetting: .minute, value: 0, of: Date())!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        if delegate != nil {
            let startTime = startTimePicker.date
            let finishTime = finishTimePicker.date
            
            delegate?.addWaiterShift(startTime: startTime, finishTime: finishTime)
            
            navigationController?.popViewController(animated: true)
        }
    }

}
