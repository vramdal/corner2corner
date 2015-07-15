//
// Created by Vidar Ramdal on 13.07.15.
// Copyright (c) 2015 Vidar Ramdal. All rights reserved.
//

import Foundation
import MapKit

class Pub : NSObject {

    let name: String
    let coordinate: CLLocationCoordinate2D
    let message: String

    init(name: String, coordinate: CLLocationCoordinate2D, message: String) {
        self.name = name
        self.coordinate = coordinate
        self.message = message

        super.init()
    }
}
