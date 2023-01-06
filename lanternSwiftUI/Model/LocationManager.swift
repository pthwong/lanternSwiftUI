//
//  LocationManager.swift
//  lanternSwiftUI
//
//  Created by WONG TSZ HIM on 5/1/2023.
//

import Foundation
import CoreLocation
import MapKit

class LocationManager: NSObject, ObservableObject {
    
    let locationManager = CLLocationManager()
    //@Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 22.361925, longitude: 114.151315), span: MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25))
    @Published var region = MKCoordinateRegion()
//    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25))
    
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch locationManager.authorizationStatus {
            case .notDetermined:
                print("nil coor")
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                print("Your location is restricted.")
            case .denied:
                print("Your have denied app to access location services.")
            case .authorizedAlways, .authorizedWhenInUse:
                guard let location = locationManager.location else { return }
            print("Location: \n\(location.coordinate)")
            region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25))
            @unknown default:
                print("error getting location")
        }
        print("Region:\n \(region)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
        
        DispatchQueue.main.async { [weak self] in
            self?.region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
}
