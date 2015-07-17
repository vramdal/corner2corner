//
// Created by Vidar Ramdal on 17.07.15.
// Copyright (c) 2015 Vidar Ramdal. All rights reserved.
//

import Foundation
import MapKit

class FetchService {

    func fetch(listProcessor: ([Pub]) -> Void, sync: Bool) {

        var pubs: [Pub] = [];

        //var pubs: [String: Pub]

        let pubListUrl = NSURL(string: "http://pub.til.pub/presence.php")

        var semaphor: dispatch_semaphore_t?;
        if (sync) {
            semaphor = dispatch_semaphore_create(0);
        }
        let fetchPubsTask = NSURLSession.sharedSession().dataTaskWithURL(pubListUrl!) {(data, response, error) in
            var parseError: NSError?
            var pubsDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(data,
                    options: NSJSONReadingOptions.MutableContainers,
                    error: &parseError) as! NSDictionary
            for (pubIdx, pubDictionary) in pubsDictionary {
                let lat: Double = pubDictionary["lat"] as! Double;
                let lng: Double = pubDictionary["lng"] as! Double;
                let location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                let id : Int! = (pubIdx as! String).toInt()
                let pub = Pub(id: id, name: pubDictionary["pubName"] as! String, coordinate: location, message: pubDictionary["message"] as! String);
                pubs.append(pub)
            }
            listProcessor(pubs)
            if (sync) {
                dispatch_semaphore_signal(semaphor!)
            }

        }

        fetchPubsTask.resume();
        if (sync) {
            dispatch_semaphore_wait(semaphor!, DISPATCH_TIME_FOREVER)
        }
    }

}
