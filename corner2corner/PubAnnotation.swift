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
    var title : String = ""
    var subtitle : String = ""
    let coordinate : CLLocationCoordinate2D
    var image : UIImage = UIImage(named: "beer.png")!

    init(pub : Pub, open: Bool = false) {
        self.pub = pub
        self.title = ""
        self.coordinate = pub.coordinate
        super.init()
        update()
    }

    func update() {
        self.title = pub.name
        self.subtitle = pub.message
        if (pub.name == "Asylet") {
            self.image = fulltGlass!
        } else {
            self.image = tomtGlass!
        }
    }
}
