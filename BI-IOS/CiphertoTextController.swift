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

class CiphertoTextController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    var sampleTextField: UITextView!
    var currentLanguage = "hebrew"
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.title = "cipher -> text"
        /* locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() // nice pod for requesting permissions - https://github.com/nickoneill/PermissionScope
        
        mapView.delegate = self
        
        mapView.removeAnnotations(mapView.annotations)
        
        let locations = self.data
        // let predicate = NSPredicate(format: "date > %@ AND title == 'ahoj'", Date()) // just example
        // let filteredLocations = FavoriteLocation.mr_findAllSorted(by: "title", ascending: true, with: predicate)
        
        locations.forEach { location in
            let annotation = MKPointAnnotation()
            if let lat = location["lat"] as? Double, let lon = location["lon"] as? Double{
                annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                mapView.addAnnotation(annotation)
            }
        }*/
        let sampleTextField = UITextView(frame: CGRect(x: 20, y: 30, width: self.view.frame.width - 40, height: (self.view.frame.height/2) - 130))
        sampleTextField.font = UIFont.systemFont(ofSize: 15)
        //sampleTextField.borderStyle = UITextBorderStyle.roundedRect
        sampleTextField.autocorrectionType = UITextAutocorrectionType.no
        sampleTextField.keyboardType = UIKeyboardType.default
        sampleTextField.returnKeyType = UIReturnKeyType.done
        //sampleTextField.clearButtonMode = UITextFieldViewMode.whileEditing;
        //sampleTextField.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        view.addSubview(sampleTextField)
        
        
        /*let maleSwitch = UISwitch(frame: CGRect(x: 40, y: 170, width: 50, height: 50))
        view.addSubview(maleSwitch)
        
        let switchLabelMale = UILabel(frame: CGRect(x: 100, y: 170, width: 50, height: 50))
        switchLabelMale.text = "Male"
        view.addSubview(switchLabelMale)
        
        
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
        
        let pushButton = UIButton(frame: CGRect(x: 20, y: 300, width: 270, height: 50))
        pushButton.setTitle("Add pin", for: .normal)
        pushButton.setTitleColor(.white, for: .normal)
        pushButton.backgroundColor = .blue
        view.addSubview(pushButton)*/
        
        self.sampleTextField = sampleTextField
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
}






