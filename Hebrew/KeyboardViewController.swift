//
//  KeyboardViewController.swift
//  Hebrew
//
//  Created by Karolina Solanska on 29/01/2018.
//  Copyright © 2018 ČVUT. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    var hebrewView: UIView!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttons1Titles = ["A", "B", "C", "D", "E", "F", "G"]
        let buttons1 = createButtons(titles: buttons1Titles)
        let topRow = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        
        for button in buttons1 {
            topRow.addSubview(button)
        }
        
        let buttons2Titles = ["H", "CH", "I", "J", "K", "L", "M"]
        let buttons2 = createButtons(titles: buttons2Titles)
        let secondRow = UIView(frame: CGRect(x: 0, y: 40, width: 320, height: 40))
        
        for button in buttons2 {
            secondRow.addSubview(button)
        }
        
        let buttons3Titles = ["N", "O", "P", "Q", "R", "S", "T"]
        let buttons3 = createButtons(titles: buttons3Titles)
        let thirdRow = UIView(frame: CGRect(x: 0, y: 80, width: 320, height: 40))
        
        for button in buttons3 {
            thirdRow.addSubview(button)
        }
        
        let buttons4Titles = ["U", "V", "W", "X", "Y", "Z"]
        let buttons4 = createButtons(titles: buttons4Titles)
        let fourthRow = UIView(frame: CGRect(x: 0, y: 120, width: 320, height: 40))
        
        for button in buttons4 {
            fourthRow.addSubview(button)
        }
        
        self.view.addSubview(topRow)
        self.view.addSubview(secondRow)
        self.view.addSubview(thirdRow)
        self.view.addSubview(fourthRow)
        
        addConstraints(buttons: buttons1, containingView: topRow)
        addConstraints(buttons: buttons2, containingView: secondRow)
        addConstraints(buttons: buttons3, containingView: thirdRow)
        addConstraints(buttons: buttons4, containingView: fourthRow)
    }
    
    func createButtons(titles: [String]) -> [UIButton] {
        
        var buttons = [UIButton]()
        
        for title in titles {
            let button = UIButton(type: .custom) as UIButton
            button.setTitle(title, for: .normal)
            let image1 = UIImage(named: title) as UIImage!
            button.setImage(image1, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
            button.setTitleColor(UIColor.darkGray, for: [])
            button.addTarget(self, action:#selector(self.keyPressed), for: .touchUpInside)
            //button.addTarget(self, action: Selector(("keyPressed:")), for: .touchUpInside)
            //button.addTarget(self, action: Selector(("keyPressed:")), for: .touchUpInside)
            buttons.append(button)
        }
        
        return buttons
    }
    
    @objc func keyPressed(sender: AnyObject?) {
        let button = sender as! UIButton
        let title = button.title(for: .normal)
        (textDocumentProxy as UIKeyInput).insertText(title!)
    }
    
    func addConstraints(buttons: [UIButton], containingView: UIView){
        
        for (index, button) in buttons.enumerated() {
            
            let topConstraint = NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: containingView, attribute: .top, multiplier: 1.0, constant: 1)
            
            let bottomConstraint = NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: containingView, attribute: .bottom, multiplier: 1.0, constant: -1)
            
            var leftConstraint : NSLayoutConstraint!
            
            if index == 0 {
                
                leftConstraint = NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: containingView, attribute: .left, multiplier: 1.0, constant: 1)
                
            }else{
                
                leftConstraint = NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: buttons[index-1], attribute: .right, multiplier: 1.0, constant: 1)
                
                let widthConstraint = NSLayoutConstraint(item: buttons[0], attribute: .width, relatedBy: .equal, toItem: button, attribute: .width, multiplier: 1.0, constant: 0)
                
                containingView.addConstraint(widthConstraint)
            }
            
            var rightConstraint : NSLayoutConstraint!
            
            if index == buttons.count - 1 {
                
                rightConstraint = NSLayoutConstraint(item: button, attribute: .right, relatedBy: .equal, toItem: containingView, attribute: .right, multiplier: 1.0, constant: -1)
                
            }else{
                
                rightConstraint = NSLayoutConstraint(item: button, attribute: .right, relatedBy: .equal, toItem: buttons[index+1], attribute: .left, multiplier: 1.0, constant: -1)
            }
            
            containingView.addConstraints([topConstraint, bottomConstraint, rightConstraint, leftConstraint])
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
       /* var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])*/
    }

}
