//
//  MockLocationManager.swift
//  TrackerDemoTests
//
//  Created by Steven Curtis on 01/09/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import RxSwift
import RxCocoa
import GoogleMaps
@testable import TrackMyMovement

class MockLocationManager: LocationManagerProtocol{
    var initialTripLocationRelay = BehaviorRelay<CLLocation?>(value: Constants.london )
    var locationPermissionRelay = BehaviorRelay<CLAuthorizationStatus>(value: .notDetermined)
    var locationRelay = BehaviorRelay<CLLocation?>(value: Constants.miltonkeynes)
    var distanceRelay = BehaviorRelay<CLLocationDistance>(value: CLLocationDistance(exactly: 20)!)
    var speedRelay = BehaviorRelay<CLLocationSpeed?>(value: CLLocationSpeed(exactly: 40))
}
