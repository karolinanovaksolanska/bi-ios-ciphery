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

    weak var makeReferralScroll: UIScrollView!
    weak var userTitleUITextView: UITextField!
    
    weak var picker = UIPickerView()
    weak var ciphertotextButton = UIButton()
    weak var textToCipherButton = UIButton()
    
    var pickerData: [String] = ["Morse code", "Caesar", "Hebrew"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker?.delegate = self
        self.picker?.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){}
    
    override func loadView() {
        super.loadView();
        
        view.backgroundColor = .white
    
        self.title = "menu"
        
        let cipherLabel = UILabel(frame: CGRect(x: 10, y: 5, width: self.view.frame.width - 20, height: 50))
        cipherLabel.text = "Cipher type:"
        view.addSubview(cipherLabel)
        
        let cipherPicker = UIPickerView(frame: CGRect(x: 0, y: 10, width: self.view.frame.width, height: 150))
        view.addSubview(cipherPicker)
        
        let ciphertotextButton = UIButton(frame: CGRect(x: 0, y: 200, width: self.view.frame.width, height: 50))
        ciphertotextButton.setTitle("Encrypt", for: .normal)
        ciphertotextButton.setTitleColor(.white, for: .normal)
        ciphertotextButton.backgroundColor = UIColor(rgb: 0x06BEE1)
        ciphertotextButton.addTarget(self, action:#selector(self.ciphertotextKeyPressed), for: .touchUpInside)
        view.addSubview(ciphertotextButton)
        
        let textToCipherButton = UIButton(frame: CGRect(x: 0, y: 270, width: self.view.frame.width, height: 50))
        textToCipherButton.setTitle("Decrypt", for: .normal)
        textToCipherButton.setTitleColor(.white, for: .normal)
        textToCipherButton.backgroundColor = UIColor(rgb: 0x06BEE1)
        textToCipherButton.addTarget(self, action:#selector(self.textToCipherKeyPressed), for: .touchUpInside)
        view.addSubview(textToCipherButton)
        
        self.picker = cipherPicker
        self.ciphertotextButton = ciphertotextButton
        self.textToCipherButton = textToCipherButton

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @objc func ciphertotextKeyPressed(sender: AnyObject?) {
        let selected = (self.picker?.selectedRow(inComponent: 0))!
        switch selected {
        case 0:
            let morseCodeController = UINavigationController(rootViewController: MorseCodeEncryptController())
            self.present(morseCodeController, animated: true, completion: nil)
        case 1:
            let caesarController = UINavigationController(rootViewController: CaesarEncryptController())
            self.present(caesarController, animated: true, completion: nil)
        case 2:
            let hebrewController = UINavigationController(rootViewController: HebrewEcryptController())
            self.present(hebrewController, animated: true, completion: nil)
        default:
            let morseCodeController = UINavigationController(rootViewController: MorseCodeEncryptController())
            self.present(morseCodeController, animated: true, completion: nil)
        }
    }
    
    @objc func textToCipherKeyPressed(sender: AnyObject?) {
        let selected = (self.picker?.selectedRow(inComponent: 0))!
        switch selected {
        case 0:
            let morseCodeController = UINavigationController(rootViewController: MorseCodeDecryptController())
            self.present(morseCodeController, animated: true, completion: nil)
        case 1:
            let caesarController = UINavigationController(rootViewController: CaesarDecryptController())
            self.present(caesarController, animated: true, completion: nil)
        case 2:
            let hebrewController = UINavigationController(rootViewController: HebrewDeryptController())
            self.present(hebrewController, animated: true, completion: nil)
        default:
            let morseCodeController = UINavigationController(rootViewController: MorseCodeDecryptController())
            self.present(morseCodeController, animated: true, completion: nil)
        }
    }
    
}

extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}


