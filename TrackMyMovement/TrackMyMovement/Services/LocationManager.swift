//
//  LocationManager.swift
//  TrackMyMovement
//
//  Created by Steven Curtis on 24/11/2020.
//

import RxSwift
import RxCocoa
import GoogleMaps

protocol LocationManagerProtocol {
    var locationPermissionRelay: BehaviorRelay<CLAuthorizationStatus> { get }
    var locationRelay: BehaviorRelay<CLLocation?> { get }
    var distanceRelay: BehaviorRelay<CLLocationDistance> { get }
    var speedRelay: BehaviorRelay<CLLocationSpeed?> { get }
    var initialTripLocationRelay: BehaviorRelay<CLLocation?> { get }
}

class LocationManager: NSObject, LocationManagerProtocol, CLLocationManagerDelegate {
    private lazy var locationManager = CLLocationManager()
    private let disposeBag = DisposeBag()
    lazy var locationPermissionRelay = BehaviorRelay<CLAuthorizationStatus>(
        value: locationManager.authorizationStatus)
    let locationRelay = BehaviorRelay<CLLocation?>(value: nil)
    let speedRelay = BehaviorRelay<CLLocationSpeed?>(value: CLLocationSpeed.init(exactly: 0.0))
    let distanceRelay = BehaviorRelay<CLLocationDistance>(value: 0)
    let initialTripLocationRelay = BehaviorRelay<CLLocation?>(value: nil)
    
    static let shared = LocationManager()
    
    private override init() {
        super.init()
        locationManager.delegate = self
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation

        DispatchQueue.main.async{
            self.locationManager.startUpdatingLocation()
        }
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationPermissionRelay.accept(status)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return }
        locationRelay.accept(currentLocation)
        speedRelay.accept(currentLocation.speed)
        
        if let initialTripLocation = initialTripLocationRelay.value {
            let distance = currentLocation.distance(from: initialTripLocation)
            guard distance > 0 else {return}
            distanceRelay.accept( distanceRelay.value + abs(distanceRelay.value - distance) )
        } else {
            initialTripLocationRelay.accept(currentLocation)
        }
    }
}
