//
//  ViewController.swift
//  corner2corner
//
//  Created by Vidar Ramdal on 13.07.15.
//  Copyright (c) 2015 Vidar Ramdal. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var map: MKMapView!
    var pubs: [Pub] = []

    var locationManager = CLLocationManager()
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            map.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationAuthorizationStatus()

        let pubListUrl = NSURL(string: "http://pub.til.pub/presence.php")

        let fetchPubsTask = NSURLSession.sharedSession().dataTaskWithURL(pubListUrl!) {(data, response, error) in
            var parseError: NSError?
            var pubsDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(data,
                    options: NSJSONReadingOptions.MutableContainers,
                    error: &parseError) as! NSDictionary
            for (pubIdx, pubDictionary) in pubsDictionary {
                let lat: Double = pubDictionary["lat"] as! Double;
                let lng: Double = pubDictionary["lng"] as! Double;
                var location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                let pub = Pub(name: pubDictionary["pubName"] as! String, coordinate: location, message: pubDictionary["message"] as! String);
                self.pubs.append(pub)
            }
            for pub in self.pubs {
                let pubAnnotation = PubAnnotation(pub: pub)
                self.map.addAnnotation(pubAnnotation)
            }
        }

        fetchPubsTask.resume();

        let initialLocation = CLLocation(latitude: 59.907205, longitude: 10.780368)
        let regionRadius: CLLocationDistance = 500
        func centerOnMapLocation(location: CLLocation) {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(initialLocation.coordinate, regionRadius * 2.0, regionRadius * 2.0)
            map.setRegion(coordinateRegion, animated: true)
        }
        centerOnMapLocation(initialLocation)
        //let galgebergCorner = PubAnnotation(pub: Pub(name: "Galgeberg Corner", coordinate: CLLocationCoordinate2D(latitude: 59.9071893, longitude: 10.7803348)))
        //map.addAnnotation(galgebergCorner)
    }


}

