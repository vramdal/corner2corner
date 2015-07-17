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

    @IBOutlet weak var map: PubMap!

    var locationManager = CLLocationManager()
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            map.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }

    func firstFetch() {
/*
        return FetchService.fetch({ (pubs: [Pub]) -> Void in
            for pub in pubs {
                let pubAnnotation = PubAnnotation(pub: pub)
                self.map.addAnnotation(pubAnnotation)
            }
        })
*/
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationAuthorizationStatus()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let pubsMap = appDelegate.pubsMap
        for (id, pub) in pubsMap {
            self.map.addAnnotation(PubAnnotation(pub: pub))
        }
        //firstFetch()
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

