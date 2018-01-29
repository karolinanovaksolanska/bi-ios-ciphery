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

    weak var mapView: MKMapView!
    var locationManager: CLLocationManager!
    var dataManager = DataManager()
    var data = [AnyObject]()
    var ref: DatabaseReference!
    var pointAnnotation:CustomPointAnnotation!
    var sampleTextField: UITextView!
    var currentLanguage = "hebrew"
    
    //weak var textField1: UITextView!
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        
        /*ref = Database.database().reference()
        let mapView = MKMapView()
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.mapView = mapView*/
        
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
        /*self.pushButton = pushButton
        self.maleSwitch = maleSwitch
        self.femaleSwitch = femaleSwitch
        self.unknownSwitch = unknownSwitch
        
        
        
        unknownSwitch.addTarget(self, action: #selector(unknownChanged), for: UIControlEvents.valueChanged)
        femaleSwitch.addTarget(self, action: #selector(femaleChanged), for: UIControlEvents.valueChanged)
        maleSwitch.addTarget(self, action: #selector(maleChanged), for: UIControlEvents.valueChanged)
        maleSwitch.setOn(true, animated: true)*/
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    let reuseIdentifier = "reuseIdentifier"
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) ?? MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
    
        let customPointAnnotation = annotation as! CustomPointAnnotation
        
        if customPointAnnotation.gender == "male" {
            
        } else if customPointAnnotation.gender == "female" {
            
        } else {
            annotationView.image = #imageLiteral(resourceName: "unknown")
        }
        annotationView.canShowCallout = true
        
        let button = UIButton(type: .detailDisclosure)
        annotationView.rightCalloutAccessoryView = button
        
        //annotationView.detailCalloutAccessoryView = UIImageView(image: #imageLiteral(resourceName: "pin"))
        
        annotationView.isDraggable = true // that's nonsense here of course 😏 - just for example
        
        return annotationView
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .follow
            
            locationManager.startUpdatingLocation() // we should also stop it somewhere!
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! // we are sure we have at least one location there
        print(location)
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            guard let placemark = placemarks?.last, let street = placemark.thoroughfare, let city = placemark.locality else {
                self?.navigationItem.title = "Address not found"
                return
            }
            
            self?.navigationItem.title = "\(city), \(street)"
        }
        
    }
    
}






