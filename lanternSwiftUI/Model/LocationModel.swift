//
//  LocationModel.swift
//  lanternSwiftUI
//
//  Created by WONG TSZ HIM on 4/1/2023.
//

import Foundation
import CoreLocation
import MapKit

class LocationModel : NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var authorizationStatus : CLAuthorizationStatus
    
    @Published var lastLocation : CLLocation?
    
    @Published var coordinateRegion : MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
    
    private let locationManager : CLLocationManager
    
    override init() {
        locationManager = CLLocationManager()
        authorizationStatus = locationManager.authorizationStatus
        
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    //call back of Location Manager
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
    
    //call bacl of Location Manager
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        DispatchQueue.main.async {
            self.lastLocation = locations.last
            if let lastLocation = self.lastLocation {
                self.coordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lastLocation.coordinate.latitude, longitude: lastLocation.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
            }
            
            
        }
    }
    
    
}
