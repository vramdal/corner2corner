//
// Created by Vidar Ramdal on 13.07.15.
// Copyright (c) 2015 Vidar Ramdal. All rights reserved.
//

import Foundation
import MapKit

class Pub : NSObject {

    let id: Int
    let name: String
    let coordinate: CLLocationCoordinate2D
    let message: String

    init(id: Int, name: String, coordinate: CLLocationCoordinate2D, message: String) {
        self.id = id
        self.name = name
        self.coordinate = coordinate
        self.message = message

        super.init()
    }
}
