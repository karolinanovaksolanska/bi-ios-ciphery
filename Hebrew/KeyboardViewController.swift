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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttons1Titles = ["A", "B", "C", "D", "E", "F", "G"]
        let buttons1 = createButtons(titles: buttons1Titles)
        let topRow = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 45))
        
        for button in buttons1 {
            topRow.addSubview(button)
        }
        
        let buttons2Titles = ["H", "CH", "I", "J", "K", "L", "M"]
        let buttons2 = createButtons(titles: buttons2Titles)
        let secondRow = UIView(frame: CGRect(x: 0, y: 45, width: 320, height: 45))
        
        for button in buttons2 {
            secondRow.addSubview(button)
        }
        
        let buttons3Titles = ["N", "O", "P", "Q", "R", "S", "T"]
        let buttons3 = createButtons(titles: buttons3Titles)
        let thirdRow = UIView(frame: CGRect(x: 0, y: 90, width: 320, height: 45))
        
        for button in buttons3 {
            thirdRow.addSubview(button)
        }
        
        let buttons4Titles = ["U", "V", "W", "X", "Y", "Z"]
        let buttons4 = createButtons(titles: buttons4Titles)
        let fourthRow = UIView(frame: CGRect(x: 0, y: 135, width: 320, height: 45))
        
        for button in buttons4 {
            fourthRow.addSubview(button)
        }
        
        let buttons5Titles = ["----", "< Delete"]
        let buttons5 = createButtonSpaceAndDelete(titles: buttons5Titles)
        let fifthRow = UIView(frame: CGRect(x: 0, y: 180, width: 320, height: 40))
        
        for button in buttons5 {
            fifthRow.addSubview(button)
        }
        
        self.view.addSubview(topRow)
        self.view.addSubview(secondRow)
        self.view.addSubview(thirdRow)
        self.view.addSubview(fourthRow)
        self.view.addSubview(fifthRow)
        
        addConstraints(buttons: buttons1, containingView: topRow)
        addConstraints(buttons: buttons2, containingView: secondRow)
        addConstraints(buttons: buttons3, containingView: thirdRow)
        addConstraints(buttons: buttons4, containingView: fourthRow)
        addConstraints(buttons: buttons5, containingView: fifthRow)
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
            buttons.append(button)
        }
        
        return buttons
    }
    
    func createButtonSpaceAndDelete(titles: [String]) -> [UIButton] {
        
         var buttons = [UIButton]()
        
        let button1 = UIButton(type: .custom) as UIButton
        let image1 = UIImage(named: "world") as UIImage!
        button1.setImage(image1, for: .normal)
        button1.translatesAutoresizingMaskIntoConstraints = false
        button1.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        button1.setTitleColor(UIColor.darkGray, for: [])
        button1.addTarget(self, action:#selector(self.nextKeyboardPressed), for: .touchUpInside)
        button1.contentMode = .scaleAspectFit
        buttons.append(button1)
        
        let button3 = UIButton(type: .custom) as UIButton
        button3.setTitle("Done", for: .normal)
        button3.translatesAutoresizingMaskIntoConstraints = false
        button3.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        button3.setTitleColor(UIColor.darkGray, for: [])
        button3.addTarget(self, action:#selector(self.doneButtonAction), for: .touchUpInside)
        buttons.append(button3)
        
        let button2 = UIButton(type: .custom) as UIButton
        button2.setTitle(titles.last, for: .normal)
        button2.translatesAutoresizingMaskIntoConstraints = false
        button2.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        button2.setTitleColor(UIColor.darkGray, for: [])
        button2.addTarget(self, action:#selector(self.deletePressed), for: .touchUpInside)
        buttons.append(button2)
        
        return buttons
    }
    
    @objc func keyPressed(sender: AnyObject?) {
        let button = sender as! UIButton
        let title = button.title(for: .normal)
        (textDocumentProxy as UIKeyInput).insertText(title!)
    }
    
    @objc func doneButtonAction(sender: AnyObject?)
    {
        self.dismissKeyboard()
    }
    
    @objc func nextKeyboardPressed(sender: AnyObject?)
    {
        self.advanceToNextInputMode()
    }
    
    @objc func deletePressed(sender: AnyObject?) {
        (textDocumentProxy as UIKeyInput).deleteBackward()
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
    
}
