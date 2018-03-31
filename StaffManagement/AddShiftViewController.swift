//
//  AddShiftViewController.swift
//  StaffManagement
//
//  Created by Eric Gregor on 2018-03-30.
//  Copyright © 2018 Derek Harasen. All rights reserved.
//

import UIKit

@objc class AddShiftViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var startTimePicker: UIDatePicker!
    @IBOutlet weak var finishTimePicker: UIDatePicker!
    
    var waiterName: String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        nameLabel.text = waiterName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
