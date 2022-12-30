//
//  MainViewModel.swift
//  TrackMyMovement
//
//  Created by Steven Curtis on 24/11/2020.
//

import RxSwift
import RxCocoa
import GoogleMaps

class MainViewModel {
    var locationManager: LocationManagerProtocol!
    struct Input {}
    struct Output {
        var authorizedDriver: Driver<Bool>
        var locationsDriver: Driver<CLLocation?>
        var initialTripLocation: Single<CLLocation??>
        
        var distanceDriver: Driver<String>
        var averageSpeedDriver: Driver<String>
        var durationDriver: Driver<(String)>
    }
    let output: Output
    
    init(locationManager: LocationManagerProtocol) {
        self.locationManager = locationManager
        output = Output(
            authorizedDriver:
                locationManager.locationPermissionRelay
                .map({ $0 == .authorizedAlways || $0 == .authorizedWhenInUse })
                .asDriver(onErrorJustReturn: false),
            locationsDriver:
                locationManager.locationRelay
                .asDriver(onErrorJustReturn: nil),
            initialTripLocation: locationManager.locationRelay.first()
            ,
            distanceDriver: locationManager.distanceRelay
                .map({ meters in
                    if meters < 1000 {
                        return String(format: "Distance : %.f meters", meters)
                    }
                    return String(format: "Distance : %.2f km", meters / 1000)
                })
                .asDriver(onErrorJustReturn: ""),
            averageSpeedDriver: Observable
                .combineLatest(
                    locationManager.distanceRelay,
                    locationManager.speedRelay,
                    resultSelector: { (speed, distance) -> (String) in
                        guard let distance = distance else {return ""}
                        let kmh = abs(distance / speed)
                        return String(format: "%.2f km/h", kmh)
                    }
                ).asDriver(onErrorJustReturn: (""))
            ,
            durationDriver: Observable
                .combineLatest(
                    locationManager.initialTripLocationRelay,
                    locationManager.locationRelay,
                    resultSelector: { (initial, current) -> (String) in
                        guard let initial = initial, let current = current else {return ""}
                        let userCalendar = Calendar.current
                        let components = userCalendar.dateComponents([.hour,.minute,.second], from: initial.timestamp, to: current.timestamp)
                        return components.formattedTime
                    }
                ).asDriver(onErrorJustReturn: (""))
        )
    }
}
