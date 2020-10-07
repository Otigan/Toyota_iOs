//
//  AutoRepairSelectVC.swift
//  SlideInTransition
//
//  Created by otigan on 28.09.2020.
//  Copyright © 2020 Gary Tokman. All rights reserved.
//

import UIKit


protocol DelegateAction {}

protocol ActionDelegate: class {
    func actionSender(_ sender: Any, didRecieveAction action: DelegateAction)
}

class AutoRepairSelectVC: UIViewController, UITextFieldDelegate {

    enum Action: DelegateAction{
        case clickOnAutoSelect, clickOnTimeSelect,
                entryConfirm
    }
    
    @IBOutlet weak var autoSelectField: UITextField!
    
    
    @IBOutlet weak var timeSelectField: UITextField!
    
    
    let datePicker = UIDatePicker()
    
    weak var delegate: ActionDelegate?
    
    
    @IBOutlet weak var confirmAutoRepair: UIButton!
    
    
    @IBAction func confirmEntry(_ sender: UIButton) {
        
        delegate?.actionSender(sender, didRecieveAction: Action.entryConfirm)
    }
    
    
    @IBAction func tapActionSelect(_ sender: UITextField) {
        delegate?.actionSender(sender, didRecieveAction: Action.clickOnAutoSelect)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        autoSelectField!.delegate = self
        
        timeSelectField!.delegate = self
        
        timeSelectField.inputView = datePicker
        datePicker.datePickerMode = .dateAndTime
        let localeID = Locale.preferredLanguages.first
        datePicker.locale = Locale(identifier: localeID!)
        
        let toolbar = UIToolbar()
        
        toolbar.sizeToFit()
        
        datePicker.minimumDate = Date()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneDate))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        timeSelectField.inputAccessoryView = toolbar
        
        toolbar.setItems([flexSpace, doneButton], animated: true)
        
        
    }
    
     func textField(_ textField: UITextField, shouldChangeCharactersIn shouldChangeCharactersInRange: NSRange, replacementString string: String) -> Bool {
        
        return false
    }
    
    @objc func doneDate() {
        getDateFromPicker()
        view.endEditing(true)
    }
    
    
    func getDateFromPicker() {
        let formatter = DateFormatter()
        
        //formatter.dateFormat = "dd.MM.yyyy HH:mm"
        formatter.dateFormat = "yyyy.MM.dd HH:mm"
        
        timeSelectField.text = formatter.string(from: datePicker.date)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



