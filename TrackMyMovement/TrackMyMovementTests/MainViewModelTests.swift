//
//  MainViewModelTests.swift
//  TrackMyMovementTests
//
//  Created by Steven Curtis on 01/09/2020.
//  Copyright © 2020 Steven Curtis. All rights reserved.
//

import GoogleMaps
import RxTest
import RxSwift
import XCTest

@testable import TrackMyMovement

class MainViewModelTests: XCTestCase {
    
    var mainViewModel: MainViewModel!
    
    var disposeBag: DisposeBag!
    var scheduler: TestScheduler!
    let locationManager = MockLocationManager()
    
    override func setUpWithError() throws {
        mainViewModel = MainViewModel(locationManager: locationManager)
        disposeBag = DisposeBag()
        self.scheduler = TestScheduler(initialClock: 0)
    }
    
    override func tearDownWithError() throws {
    }
    
    func testDuration() {
        let observeDuration = scheduler.createObserver(String.self)
        
        mainViewModel.output.durationDriver
            .drive(observeDuration)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(observeDuration.events.count, 1)
        XCTAssertEqual(observeDuration.events, [.next(0, "00:00:00")])
    }
    
    func testDistance() {
        let observeDistance = scheduler.createObserver(String.self)
        
        mainViewModel.output.distanceDriver
            .drive(observeDistance)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(observeDistance.events.count, 1)
        XCTAssertEqual(observeDistance.events, [.next(0, "Distance : 20 meters")])
    }
    
    func testAverageSpeed() {
        let observeSpeed = scheduler.createObserver(String.self)
        
        mainViewModel.output.averageSpeedDriver
            .drive(observeSpeed)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(observeSpeed.events.count, 1)
        XCTAssertEqual(observeSpeed.events, [.next(0, "2.00 km/h")])
    }
    
    func testLocations() {
        let observeLocation = scheduler.createObserver(CLLocation?.self)
        
        mainViewModel.output.locationsDriver
            .drive(observeLocation)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(observeLocation.events.count, 1)
        print (observeLocation.events)
        XCTAssertEqual(observeLocation.events, [.next(0, Constants.miltonkeynes)])
    }
}
