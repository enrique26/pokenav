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
    var pokeCount=0
    var allPokemon : [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        allPokemon = getAllPokemon()
        
        manager.delegate=self
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapaView.showsUserLocation=true;
            manager.startUpdatingLocation();
            var timerTest : Timer?
            if timerTest == nil {
               timerTest = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { (Timer) in
                    //Pintar pokemon cada cierto intervalo de tiempo
                    print("@inloop")
                    let coord=self.manager.location?.coordinate
                    if (coord) != nil {
                        if (self.pokeCount < 8) {
                            print("@spawn pokemon")
                            let anot=MKPointAnnotation()
                            anot.coordinate = coord!
                            let randLat=(Double(arc4random_uniform(200))-100.0)/50000.0;
                            let randLon=(Double(arc4random_uniform(200))-100.0)/50000.0;
                            anot.coordinate.latitude += randLat;
                            anot.coordinate.longitude += randLon;
                            self.mapaView.addAnnotation(anot);
                            self.pokeCount += 1
                        }else {
                            if timerTest != nil {
                                print("@stoping timer");
                                timerTest?.invalidate();
                                timerTest = nil;
                            }
                        }
                        
                    }
                    
                    
                })
            }
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
            let region=MKCoordinateRegionMakeWithDistance((manager.location?.coordinate)!, 1200, 1200);
            mapaView.setRegion(region, animated: false);
            updateCount += 1;
        }else{
            manager.stopUpdatingLocation()
        }
        
    }
    
    @IBAction func centertapp(_ sender: Any) {
        if (manager.location?.coordinate) != nil {
            let region=MKCoordinateRegionMakeWithDistance((manager.location?.coordinate)!, 1200, 1200);
            mapaView.setRegion(region, animated: false);
            updateCount = 0;
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

