//  BI-IOS
//
//  Copyright © 2017 ČVUT. All rights reserved.
//

import UIKit
import MapKit
import SnapKit
import CoreLocation
import MagicalRecord
import FacebookShare

class CaesarDecryptController: UIViewController, UITextViewDelegate {
    
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var lastLetter = ""
    var lastLength = 1
    var activeField: UITextField?
    var moveBy = 0

    let alfabet: [String] = [ "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" ]
    
    weak var sampleTextField0: UITextView!
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
        
        let numberText = UILabel(frame: CGRect(x: 10, y: 20, width: self.view.frame.width - 40, height: 30))
        numberText.text = "Enter number of movements:"
        scrollView.addSubview(numberText)
        
        let sampleTextField0 = UITextView(frame: CGRect(x: 10, y: 60, width: self.view.frame.width - 40, height: 30))
        sampleTextField0.layer.borderColor = UIColor.gray.cgColor
        sampleTextField0.layer.borderWidth = 1.0
        sampleTextField0.layer.cornerRadius = 5.0
        sampleTextField0.textAlignment = NSTextAlignment.justified
        sampleTextField0.autocorrectionType = UITextAutocorrectionType.no
        sampleTextField0.returnKeyType = UIReturnKeyType.done
        sampleTextField0.keyboardType = .numberPad
        self.sampleTextField0 = sampleTextField0
        scrollView.addSubview(sampleTextField0)

        
        let enterText = UILabel(frame: CGRect(x: 10, y: 100, width: self.view.frame.width - 40, height: 30))
        enterText.text = "Enter text here:"
        scrollView.addSubview(enterText)
        
        let sampleTextField = UITextView(frame: CGRect(x: 10, y: 140, width: self.view.frame.width - 40, height: (self.view.frame.height/2) - 150))
        sampleTextField.layer.borderColor = UIColor.gray.cgColor
        sampleTextField.layer.borderWidth = 1.0
        sampleTextField.layer.cornerRadius = 5.0
        sampleTextField.textAlignment = NSTextAlignment.justified
        sampleTextField.autocorrectionType = UITextAutocorrectionType.no
        sampleTextField.returnKeyType = UIReturnKeyType.done
        self.sampleTextField = sampleTextField
        self.sampleTextField.delegate = self
        scrollView.addSubview(sampleTextField)
        
        let thisText = UILabel(frame: CGRect(x: 10, y: (self.view.frame.height/2), width: self.view.frame.width - 40, height: 30))
        thisText.text = "Translation here:"
        scrollView.addSubview(thisText)
        
        let sampleTextField2 = UITextView(frame: CGRect(x: 10, y: (self.view.frame.height/2) + 40, width: self.view.frame.width - 40, height: (self.view.frame.height/2) - 150))
        sampleTextField2.layer.borderColor = UIColor.gray.cgColor
        sampleTextField2.layer.borderWidth = 1.0
        sampleTextField2.layer.cornerRadius = 5.0
        sampleTextField2.textAlignment = NSTextAlignment.justified
        sampleTextField2.autocorrectionType = UITextAutocorrectionType.no
        sampleTextField2.returnKeyType = UIReturnKeyType.done
        sampleTextField2.isUserInteractionEnabled = false
        self.sampleTextField2 = sampleTextField2
        scrollView.addSubview(sampleTextField2)
        
        let menuButton = UIButton(frame: CGRect(x: -0.8, y:  self.view.frame.height - 115, width: self.view.frame.width/2, height: 50))
        menuButton.setTitle("Menu", for: .normal)
        let image1 = #imageLiteral(resourceName: "settings")
        menuButton.setImage(image1, for: .normal)
        menuButton.setTitleColor(.white, for: .normal)
        menuButton.tintColor = UIColor.white
        menuButton.backgroundColor = UIColor(rgb: 0x1768AC)
        menuButton.imageView?.tintColor = UIColor.white
        menuButton.addTarget(self, action:#selector(self.menuPressed), for: .touchUpInside)
        view.addSubview(menuButton)
        
        let shareButton = UIButton(frame: CGRect(x: (self.view.frame.width/2)-0.8, y:  self.view.frame.height - 115, width: self.view.frame.width/2, height: 50))
        let image2 = #imageLiteral(resourceName: "facebook")
        shareButton.setImage(image2, for: .normal)
        shareButton.setTitleColor(.white, for: .normal)
        shareButton.tintColor = UIColor.white
        shareButton.backgroundColor = UIColor(rgb: 0x1768AC)
        shareButton.imageView?.tintColor = UIColor.white
        shareButton.addTarget(self, action:#selector(self.shareIt), for: .touchUpInside)
        view.addSubview(shareButton)

        
    }
    
    func textViewDidChange(_ textView: UITextView) { //Handle the text changes here
        let myString = textView.text.uppercased() as NSString
        
        if let intVal = Int(sampleTextField0.text) {
            if (intVal > 26){
                self.moveBy = intVal%26
            } else {
                self.moveBy = intVal
            }
        } else {
            self.moveBy = 0
        }
        
        if((myString.length + 1) <= self.lastLength){
            self.lastLength -= 1
            let txt = self.sampleTextField2.text as NSString
            self.sampleTextField2.text! = txt.substring(to: txt.length - 1)
        } else {
            if (myString.substring(from: myString.length-1) == " "){
                self.sampleTextField2.text! += " "
                self.lastLength = myString.length + 1
            } else if (myString.substring(from: myString.length-1) == "\n"){
                self.sampleTextField2.text! += "\n"
                self.lastLength = myString.length + 1
                
            } else if let i = alfabet.index(of: myString.substring(from: myString.length-1)) {
                self.sampleTextField2.text! += alfabet[i + 26 - self.moveBy]
                self.lastLength = myString.length + 1
            }
        }
        print(textView.text)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Caesar Decrypt"
        self.hideKeyboard()
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
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
    
    @objc func shareIt() -> Void {
        let url = URL.init(string: "https://developers.facebook.com")
        let smthing = sampleTextField2.text
        let content = LinkShareContent(url: url!, title: smthing)
        let shareDialog = ShareDialog(content: content)
        shareDialog.mode = .native
        shareDialog.failsOnInvalidData = true
        shareDialog.completion = { result in
            print(result)
        }
        
        do {
            try shareDialog.show()
        } catch {
            
        }
    }
}

