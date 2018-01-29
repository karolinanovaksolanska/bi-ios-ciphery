//
//  TableViewController.swift
//  BI-IOS
//
//  Created by Dominik Vesely on 30/10/2017.
//  Copyright © 2017 ČVUT. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class MenuViewController : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    weak var ciphertotextButton: UIButton!
    weak var sampleTextField: UITextField!
    
    weak var cipTextSwitch: UISwitch!
    weak var femaleSwitch: UISwitch!
    weak var unknownSwitch: UISwitch!
    
    weak var textField1: UITextField!
    
    
    var dataManager = DataManager()
    weak var makeReferralScroll: UIScrollView!
    weak var userTitleUITextView: UITextField!
    let locationManager = CLLocationManager()
    var userLatitude:CLLocationDegrees! = 0
    var userLongitude:CLLocationDegrees! = 0
    
    weak var picker = UIPickerView()
    
    var pickerData: [String] = ["Morse code", "Caesar", "Snail", "Spider web", "Hebrew"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Connect data:
        self.picker?.delegate = self
        self.picker?.dataSource = self
        
        // Input data into the Array:
       // pickerData = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6"]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
    }
    
    override func loadView() {
        super.loadView();
        
        view.backgroundColor = .white
    
        self.title = "menu"

        /*let sampleTextField = UITextField(frame: CGRect(x: 40, y: 30, width: self.view.frame.width - 80, height: 100))
        sampleTextField.placeholder = "Enter Username here"
        sampleTextField.font = UIFont.systemFont(ofSize: 15)
        sampleTextField.borderStyle = UITextBorderStyle.roundedRect
        sampleTextField.autocorrectionType = UITextAutocorrectionType.no
        sampleTextField.keyboardType = UIKeyboardType.default
        sampleTextField.returnKeyType = UIReturnKeyType.done
        sampleTextField.clearButtonMode = UITextFieldViewMode.whileEditing;
        sampleTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        view.addSubview(sampleTextField)*/
        
        let cipTextSwitch = UISwitch(frame: CGRect(x: (self.view.frame.width - 40)/2, y: 170, width: 20, height: 50))
        view.addSubview(cipTextSwitch)
        
        let switchLabelDecrypt = UILabel(frame: CGRect(x: ((self.view.frame.width - 40)/2) - 95, y: 160, width: 150, height: 50))
        switchLabelDecrypt.text = "decrypt"
        view.addSubview(switchLabelDecrypt)

        let switchLabelEncrypt = UILabel(frame: CGRect(x: ((self.view.frame.width - 40)/2) + 80, y: 160, width: 150, height: 50))
        switchLabelEncrypt.text = "encrypt"
        view.addSubview(switchLabelEncrypt)
        
        /*
        let femaleSwitch = UISwitch(frame: CGRect(x: 40, y: 210, width: 50, height: 50))
        view.addSubview(femaleSwitch)
        
        let switchLabelFemale = UILabel(frame: CGRect(x: 100, y: 210, width: 100, height: 50))
        switchLabelFemale.text = "Female"
        view.addSubview(switchLabelFemale)

        
        let unknownSwitch = UISwitch(frame: CGRect(x: 40, y: 250, width: 50, height: 50))
        view.addSubview(unknownSwitch)
        
        let switchLabelUnknown = UILabel(frame: CGRect(x: 100, y: 250, width: 100, height: 50))
        switchLabelUnknown.text = "Unknown"
        view.addSubview(switchLabelUnknown)
        */
        
        let cipherLabel = UILabel(frame: CGRect(x: 10, y: 5, width: self.view.frame.width - 20, height: 50))
        cipherLabel.text = "Cipher type:"
        view.addSubview(cipherLabel)
        /*let ciphertotextButton = UIButton(frame: CGRect(x: 0, y: 10, width: self.view.frame.width, height: 50))
        ciphertotextButton.setTitle("Choose cipher", for: .normal)
        ciphertotextButton.setTitleColor(.white, for: .normal)
        ciphertotextButton.backgroundColor = UIColor(rgb: 0x06BEE1)
        view.addSubview(ciphertotextButton)*/
        
        let cipherPicker = UIPickerView(frame: CGRect(x: 0, y: 10, width: self.view.frame.width, height: 150))
        view.addSubview(cipherPicker)
        
       // self.sampleTextField = sampleTextField
        //self.ciphertotextButton = ciphertotextButton
        self.picker = cipherPicker
        self.cipTextSwitch = cipTextSwitch
        /*self.femaleSwitch = femaleSwitch
        self.unknownSwitch = unknownSwitch
        
        
        
        unknownSwitch.addTarget(self, action: #selector(unknownChanged), for: UIControlEvents.valueChanged)
        femaleSwitch.addTarget(self, action: #selector(femaleChanged), for: UIControlEvents.valueChanged)
        maleSwitch.addTarget(self, action: #selector(maleChanged), for: UIControlEvents.valueChanged)
        maleSwitch.setOn(true, animated: true)*/
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    @objc func maleChanged(maleSwitch: UISwitch) {
        if maleSwitch.isOn {
            femaleSwitch.setOn(false, animated: true)
            unknownSwitch.setOn(false, animated: true)
        } else {
            femaleSwitch.setOn(true, animated: true)
            
        }
    }
    
    @objc func femaleChanged(femaleSwitch: UISwitch) {
        if femaleSwitch.isOn {
            //maleSwitch.setOn(false, animated: true)
            unknownSwitch.setOn(false, animated: true)
           
        } else {
            unknownSwitch.setOn(true, animated: true)
            
        }
    }
    
    @objc func unknownChanged(unknownSwitch: UISwitch) {
        if unknownSwitch.isOn {
            //maleSwitch.setOn(false, animated: true)
            femaleSwitch.setOn(false, animated: true)
            
        } else {
            //maleSwitch.setOn(true, animated: true)
            
        }
    }
    
    @objc func pushButtonTapped(_ sender: UIButton) {
        
        let username: String = sampleTextField.text!
        if username != "" {
           /* dataManager.addPin(username: username, gender: self.gender, lat: self.userLatitude, lon: self.userLongitude) { [weak self] pin in
                print(pin)
                navigationController?.pushViewController(TableViewController(), animated: true)
            }*/
        } else {
            let alert = UIAlertController(title: "Missing username", message: "Please fill in username before sending.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}


