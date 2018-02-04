//
//  MapViewController.swift
//  BI-IOS
//
//  Created by Jan Misar on 14.11.17.
//  Copyright © 2017 ČVUT. All rights reserved.
//

import UIKit
import MapKit
import SnapKit
import CoreLocation
import MagicalRecord
import Firebase

class TexttoCipherController: UIViewController, UITextViewDelegate, CLLocationManagerDelegate, MKMapViewDelegate {

    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .cyan
        return v
    }()

    var locationManager: CLLocationManager!
    var dataManager = DataManager()
    var data = "something"
    var ref: DatabaseReference!
    var pointAnnotation:CustomPointAnnotation!
    var lastX = 0
    var lastY = 0
    var lastLength = 1
    var activeField: UITextField?
    
    weak var sampleTextField: UITextView!

    @IBAction func doneBtnFromKeyboardClicked (sender: Any) {
        print("Done Button Clicked.")
        //Hide Keyboard by endEditing or Anything you want.
        self.view.endEditing(true)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        self.view.addSubview(scrollView)
        
        // constrain the scroll view to 8-pts on each side
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8.0).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8.0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8.0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8.0).isActive = true
        let thisText = UILabel(frame: CGRect(x: 20, y: (self.view.frame.height/2) - 10, width: self.view.frame.width - 40, height: 30))
        thisText.text = "Translation here:"
        let enterText = UILabel(frame: CGRect(x: 20, y: 100, width: self.view.frame.width - 40, height: 30))
        enterText.text = "Translation here:"
        scrollView.addSubview(enterText)
        
        let sampleTextField = UITextView(frame: CGRect(x: 20, y: (self.view.frame.height/2) + 30, width: self.view.frame.width - 40, height: (self.view.frame.height/2) - 150))
        //sampleTextField.font = UIFont.systemFont(ofSize: 15)
        //sampleTextField.borderStyle = UITextBorderStyle.roundedRect
        sampleTextField.layer.borderColor = UIColor.gray.cgColor
        sampleTextField.layer.borderWidth = 1.0
        sampleTextField.layer.cornerRadius = 5.0
        sampleTextField.textAlignment = NSTextAlignment.justified
        sampleTextField.autocorrectionType = UITextAutocorrectionType.no
        sampleTextField.returnKeyType = UIReturnKeyType.done
        self.sampleTextField = sampleTextField
        self.sampleTextField.delegate = self
        //sampleTextField.clearButtonMode = UITextFieldViewMode.whileEditing;
        //sampleTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        scrollView.addSubview(sampleTextField)
        
    }
    
    func textViewDidChange(_ textView: UITextView) { //Handle the text changes here
        var myString = textView.text! as NSString
        if (myString.length > 2 && myString.substring(from: myString.length-1) == " "){
            if CGFloat(self.lastX) >= (self.view.frame.width - 30){
                self.lastX = 0
                self.lastY += 30
            } else {
                self.lastX += 30
            }
            self.lastLength = myString.length + 1
        } else {
            if((myString.length + 1) <= self.lastLength){
                self.lastLength -= 1
                if let viewWithTag = self.view.viewWithTag(self.lastLength) {
                    print("Tag " + String(self.lastLength))
                    viewWithTag.removeFromSuperview()
                    if self.lastX == 0 {
                        self.lastX = 0
                        self.lastY -= 30
                    } else {
                        self.lastX -= 30
                    }
                }
                else {
                    print("tag not found")
                }
                
            } else {
                let newImage = UIImage(named: myString.substring(from: myString.length-1)) as UIImage!
                let imageView = UIImageView(image: newImage!)
                imageView.frame = CGRect(x: self.lastX, y: self.lastY, width: 30, height: 30)
                imageView.tag = self.lastLength
                print("Tag " + String(self.lastLength) + " " + myString.substring(from: myString.length-1))

                if CGFloat(self.lastX) >= (self.view.frame.width - 30){
                    self.lastX = 0
                    self.lastY += 30
                } else {
                    self.lastX += 30
                }
                self.lastLength = myString.length + 1
            
                scrollView.addSubview(imageView)
            }
        }
        print(textView.text) //the textView parameter is the textView where text was changed
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.title = "text -> cipher"
        self.hideKeyboard()
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        let scrollPoint : CGPoint = CGPoint.init(x:0, y:textView.frame.origin.y)
        self.scrollView.setContentOffset(scrollPoint, animated: true)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.scrollView.setContentOffset(CGPoint.zero, animated: true)
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


