//
//  ViewController.swift
//  pokemon
//
//  Created by Enrique Gachuz on 07/03/18.
//  Copyright © 2018 Enrique Gachuz. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController,CLLocationManagerDelegate {

    @IBOutlet weak var mapaView: MKMapView!
    var manager=CLLocationManager()
    var updateCount=0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        manager.delegate=self
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapaView.showsUserLocation=true;
            manager.startUpdatingLocation();
        }else{
            manager.requestWhenInUseAuthorization();
                
        }
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapaView.showsUserLocation=true
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if updateCount < 3 {
            let region=MKCoordinateRegionMakeWithDistance((manager.location?.coordinate)!, 1000, 1000);
            mapaView.setRegion(region, animated: false);
            updateCount += 1;
        }else{
            manager.stopUpdatingLocation()
        }
        
    }
    
    @IBAction func centertapp(_ sender: Any) {
        if (manager.location?.coordinate) != nil {
            let region=MKCoordinateRegionMakeWithDistance((manager.location?.coordinate)!, 1000, 1000);
            mapaView.setRegion(region, animated: false);
            updateCount = 0;
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

