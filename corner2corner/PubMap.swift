//
// Created by Vidar Ramdal on 16.07.15.
// Copyright (c) 2015 Vidar Ramdal. All rights reserved.
//

import Foundation
import UIKit
import MapKit

public class PubMap : MKMapView, MKMapViewDelegate {

    let person = UIImage(named: "smiley.png")

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self
    }

    public required init(coder decoder: NSCoder) {
        super.init(coder: decoder)
        self.delegate = self
    }

    public func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if !(annotation is PubAnnotation) {
            return nil;
        }
        let reuseId = "pubAnnotation";

        var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId);
        if (anView == nil) {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView.canShowCallout = true
        } else {
            anView.annotation = annotation
        }

        if (annotation is PubAnnotation) {
            let pubAnnotation = annotation as! PubAnnotation
            anView.image = pubAnnotation.image
        } else {
            anView.image = person!;
        }

        return anView
    }


}
