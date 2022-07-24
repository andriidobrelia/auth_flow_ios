//
//  LocationManager.swift
//  TestProject
//
//  Created by Andrew Dobrelya on 03.07.2022.
//

import CoreLocation

final class LocationManager : NSObject, CLLocationManagerDelegate {
    private lazy var manager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        return locationManager
    } ()
    
    private var authorizationCallback: (() -> Void)?
    
    func requestAuthorization(completion: @escaping () -> Void ) {
        manager.requestWhenInUseAuthorization()
    }
    
    func startLacationUdpates() {
        manager.startUpdatingLocation()
    }
    func stopLacationUdpates() {
        manager.stopUpdatingLocation()
    }
    var lastUserLocation : CLLocation? {
        manager.location
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            break
        case .denied, .restricted:
            authorizationCallback?()
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        @unknown default:
            break
        }
    }
}
