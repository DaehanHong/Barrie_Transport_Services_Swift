//
//  ViewController.swift
//  Daehan_Hong_Barrie_Transport_Services
//
//  Created by Daehan Hong on 2019-11-20.
//  Copyright © 2019 Daehan Hong. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    //MARK:- Outlets
    
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK:- Class Variables
    var model = DH_BTS_Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        // barrie GPS
        let barrieLatitude = 44.389355
        let barrieLongitude = -79.690331
        
        let barrieLocation = CLLocationCoordinate2D(latitude: barrieLatitude, longitude: barrieLongitude)
        
        let barrieRegion = MKCoordinateRegion(center: barrieLocation, latitudinalMeters: 10000, longitudinalMeters: 10000)
        
        mapView.setRegion(barrieRegion, animated: true)
        
        for driver in model.drivers {
            
            let random1 = Double.random(in: -0.05...0.05)
            let random2 = Double.random(in: -0.05...0.05)
            
            let randomLocation = CLLocationCoordinate2D(latitude: barrieLatitude + random1, longitude: barrieLongitude + random2)
            
            let annotation = MKPointAnnotation()
            
            annotation.coordinate = randomLocation
            annotation.title = driver.key
            annotation.subtitle = driver.value
            
            mapView.addAnnotation(annotation)
        }
        
        mapView.register(CustomAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    }


}


class CustomAnnotationView : MKMarkerAnnotationView {
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        self.canShowCallout = true
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
        button.setTitle("Call", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        
        button.addTarget(self, action: #selector(CustomAnnotationView.makeTheCall(sender:)), for: .touchUpInside)
        
        self.rightCalloutAccessoryView = button
        
    }
    
    @objc func makeTheCall(sender: UIButton) {
        print("Calling driver...")
        
        let phoneNumber = annotation!.subtitle
        
        let urlString = "tel://" + phoneNumber!!
        
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
