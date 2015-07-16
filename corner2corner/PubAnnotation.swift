//
// Created by Vidar Ramdal on 13.07.15.
// Copyright (c) 2015 Vidar Ramdal. All rights reserved.
//

import Foundation
import MapKit

class PubAnnotation : NSObject, MKAnnotation {

    let fulltGlass = UIImage(named: "beer.png")
    let tomtGlass = UIImage(named: "emptybeer.png")

    let pub : Pub

    init(pub : Pub, open: Bool = false) {
        self.pub = pub
    }

    var title : String {
        return pub.name
    }

    var subtitle : String {
        return pub.message
    }

    var coordinate : CLLocationCoordinate2D {
        return pub.coordinate
    }

    var image : UIImage {
        if (self.pub.name == "Asylet") {
            return fulltGlass!
        } else {
            return tomtGlass!
        }
    }

}
