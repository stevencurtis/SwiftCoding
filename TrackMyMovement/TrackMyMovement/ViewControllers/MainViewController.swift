//
//  MainViewController.swift
//  TrackMyMovement
//
//  Created by Steven Curtis on 24/11/2020.
//

import UIKit
import GoogleMaps
import RxSwift

class MainViewController: UIViewController  {
    private var mainViewModel: MainViewModel!
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var averageSpeedLabel: UILabel!
    
    var disposeBag = DisposeBag()
    
    var path = GMSMutablePath()
    var trackingPolyline = GMSPolyline()
    
    init?(coder: NSCoder, locationManager: LocationManagerProtocol) {
        mainViewModel = MainViewModel(locationManager: locationManager)
        super.init(coder: coder)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView?.isMyLocationEnabled = true
        setupBindings()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func setupBindings() {
        mainViewModel.output.authorizedDriver
            .skip(1)
            .drive(onNext: {result in
                if result == false
                {
                    let normalalert = UIAlertController(
                        title: "Location Access Required",
                        message: "Please open settings and set location access to ‘While Using the App’",
                        preferredStyle: .alert)
                    let okay = UIAlertAction(title: "Retry", style: .default, handler: { _ in  })
                    normalalert.addAction(okay)
                    self.present(normalalert, animated: true)
                }
            })
            .disposed(by: disposeBag)
        
        mainViewModel.output.locationsDriver
            .drive(onNext: {[weak self] result in
                guard let latitude = result?.coordinate.latitude, let longitude = result?.coordinate.longitude else {return}
                let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 17.0)
                self?.mapView.animate(to: camera)
                self?.mapView.camera = GMSCameraPosition(target: result!.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
                self?.path.add(CLLocationCoordinate2D(latitude: (result?.coordinate.latitude)!,
                                                      longitude: (result?.coordinate.longitude)!))
                let polyline = GMSPolyline(path: self?.path)
                polyline.strokeColor = UIColor.blue
                polyline.strokeWidth = 3
                polyline.map = self!.mapView
            })
            .disposed(by: disposeBag)
        
        mainViewModel.output.distanceDriver
            .drive(distanceLabel.rx.text)
            .disposed(by: disposeBag)
        
        mainViewModel.output.averageSpeedDriver
            .drive(averageSpeedLabel.rx.text)
            .disposed(by: disposeBag)
        
        mainViewModel.output.durationDriver
            .drive(durationLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
