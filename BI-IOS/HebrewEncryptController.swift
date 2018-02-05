//  BI-IOS
//
//  Copyright © 2017 ČVUT. All rights reserved.
//

import UIKit
import MapKit
import SnapKit
import CoreLocation
import MagicalRecord
import Firebase

class HebrewEcryptController: UIViewController, UITextViewDelegate {
    
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var lastLetter = ""
    var lastLength = 1
    var lastX = 0
    var lastY = 0
    var activeField: UITextField?
    
    let alfabet: [String] = [ "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" ]
    
    weak var sampleTextField: UITextView!
    weak var sampleTextField2: UITextView!
    
    @IBAction func doneBtnFromKeyboardClicked (sender: Any) {
        print("Done Button Clicked.")
        //Hide Keyboard by endEditing or Anything you want.
        self.view.endEditing(true)
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
        
        let enterText = UILabel(frame: CGRect(x: 10, y: 20, width: self.view.frame.width - 40, height: 30))
        enterText.text = "Enter text here:"
        scrollView.addSubview(enterText)
        
        let sampleTextField = UITextView(frame: CGRect(x: 10, y: 60, width: self.view.frame.width - 40, height: (self.view.frame.height/2) - 150))
        sampleTextField.layer.borderColor = UIColor.gray.cgColor
        sampleTextField.layer.borderWidth = 1.0
        sampleTextField.layer.cornerRadius = 5.0
        sampleTextField.textAlignment = NSTextAlignment.justified
        sampleTextField.autocorrectionType = UITextAutocorrectionType.no
        sampleTextField.returnKeyType = UIReturnKeyType.done
        self.sampleTextField = sampleTextField
        self.sampleTextField.delegate = self
        scrollView.addSubview(sampleTextField)
        
        let thisText = UILabel(frame: CGRect(x: 10, y: (self.view.frame.height/2) - 80, width: self.view.frame.width - 40, height: 30))
        thisText.text = "Translation here:"
        scrollView.addSubview(thisText)
        
        let sampleTextField2 = UITextView(frame: CGRect(x: 10, y: (self.view.frame.height/2) - 40, width: self.view.frame.width - 40, height: (self.view.frame.height/2) - 150))
        sampleTextField2.layer.borderColor = UIColor.gray.cgColor
        sampleTextField2.layer.borderWidth = 1.0
        sampleTextField2.layer.cornerRadius = 5.0
        sampleTextField2.textAlignment = NSTextAlignment.justified
        sampleTextField2.autocorrectionType = UITextAutocorrectionType.no
        sampleTextField2.returnKeyType = UIReturnKeyType.done
        sampleTextField2.isUserInteractionEnabled = false
        self.sampleTextField2 = sampleTextField2
        scrollView.addSubview(sampleTextField2)
        
        let menuButton = UIButton(frame: CGRect(x: -0.8, y:  self.view.frame.height - 115, width: self.view.frame.width + 1.6, height: 50))
        menuButton.setTitle("Menu", for: .normal)
        let image1 = #imageLiteral(resourceName: "settings")
        menuButton.setImage(image1, for: .normal)
        menuButton.setTitleColor(.white, for: .normal)
        menuButton.tintColor = UIColor.white
        menuButton.backgroundColor = UIColor(rgb: 0x1768AC)
        menuButton.imageView?.tintColor = UIColor.white
        menuButton.addTarget(self, action:#selector(self.menuPressed), for: .touchUpInside)
        view.addSubview(menuButton)
        
        self.lastY = Int((self.view.frame.height/2) - 40)
        
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
                let newImage = UIImage(named: (myString.substring(from: myString.length-1)).uppercased()) as UIImage!
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
        print(textView.text)
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
        let scrollPoint : CGPoint = CGPoint.init(x: 0, y: textView.frame.origin.y - 40)
        self.scrollView.setContentOffset(scrollPoint, animated: true)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.scrollView.setContentOffset(CGPoint.zero, animated: true)
    }
    
    @objc func menuPressed(sender: AnyObject?) {
        let menuController = UINavigationController(rootViewController: MenuViewController())
        self.present(menuController, animated: true, completion: nil)
    }
}




