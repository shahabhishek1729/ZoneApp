//
//  LocationManager.swift
//  ZoneApp
//
//  Created by Abhishek on 6/6/25.
//

import CoreLocation
import UserNotifications

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    @Published var currentLocation: CLLocation?
    @Published var statusMessage: String = "Not requested"
    
    @Published var onEntry: (String) -> Void = { _ in }
    @Published var onExit: (String) -> Void = { _ in }

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        authorizationStatus = locationManager.authorizationStatus
        updateStatusMessage()
    }
    
    func requestLocationPermission() {
        print("Requesting location permission...")
        
        switch authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            locationManager.requestAlwaysAuthorization()
        case .denied, .restricted:
            statusMessage = "Go to Settings → Privacy → Location to enable"
        case .authorizedAlways:
            startLocationUpdates() // Start getting location once we have permission
        @unknown default:
            break
        }
    }
    
    private func startLocationUpdates() {
        guard authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse else {
            print("No location authorization")
            return
        }
        
        print("Starting location updates...")
        locationManager.startUpdatingLocation()
    }
    
    func startMonitoring(region: CLCircularRegion, onEntry_: @escaping (String) -> Void, onExit_: @escaping (String) -> Void) {
        self.onEntry = onEntry_
        self.onExit = onExit_
        // Check if we have location first
        guard currentLocation != nil else {
            print("No current location available - starting location updates first")
            startLocationUpdates()
            
            // Retry monitoring after getting location
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.startMonitoring(region: region, onEntry_: onEntry_, onExit_: onExit_)
            }
            return
        }
        
        guard CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) else {
            print("Region monitoring not available")
            return
        }
        
        guard authorizationStatus == .authorizedAlways else {
            print("Need always authorization for background monitoring")
            return
        }
        
        // Additional validation
        guard region.radius >= 100 else {
            print("Region radius must be at least 100 meters")
            return
        }
        
        guard locationManager.monitoredRegions.count < 20 else {
            print("Maximum of 20 regions can be monitored")
            return
        }
        
        region.notifyOnEntry = true
        region.notifyOnExit = true
        
        print("Starting monitoring for region: \(region.identifier)")
        print("Region center: \(region.center)")
        print("Region radius: \(region.radius)")
        
        locationManager.startMonitoring(for: region)
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("Authorization changed to: \(manager.authorizationStatus.rawValue)")
        
        DispatchQueue.main.async {
            self.authorizationStatus = manager.authorizationStatus
            self.updateStatusMessage()
        }
        
        // Start location updates when we get permission
        if authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse {
            startLocationUpdates()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        DispatchQueue.main.async {
            self.currentLocation = location
            self.statusMessage = "Location: \(location.coordinate.latitude), \(location.coordinate.longitude)"
        }
        
        // Stop continuous updates once we have a location (saves battery)
        // locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error)")
        
        if let clError = error as? CLError {
            switch clError.code {
            case .locationUnknown:
                print("Location is currently unknown, but Core Location will keep trying")
            case .denied:
                print("Location services are disabled")
            case .network:
                print("Network error")
            default:
                print("Other location error: \(clError.localizedDescription)")
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("✅ Entered region: \(region.identifier)")
        sendNotification(title: "Entered Zone", body: "You've entered \(region.identifier)")
        handleRegionEntry(regionId: region.identifier)
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("❌ Exited region: \(region.identifier)")
        sendNotification(title: "Exited Zone", body: "You've left \(region.identifier)")
        handleRegionExit(regionId: region.identifier)
    }
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print("❌ Monitoring failed for region: \(region?.identifier ?? "Unknown")")
        print("Error: \(error)")
        
        if let clError = error as? CLError {
            switch clError.code {
            case .locationUnknown:
                print("Can't get device location - trying to start location updates")
                startLocationUpdates()
            case .denied:
                print("Location access denied")
            case .regionMonitoringDenied:
                print("Region monitoring denied")
            case .regionMonitoringFailure:
                print("Region monitoring failure")
            case .regionMonitoringSetupDelayed:
                print("Region monitoring setup delayed")
            default:
                print("Other monitoring error: \(clError.localizedDescription)")
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        print("✅ Started monitoring region: \(region.identifier)")
        
        // Request the current state for this region
        manager.requestState(for: region)
    }
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        print("Region \(region.identifier) state: \(state.rawValue)")
        
        switch state {
        case .inside:
            print("Currently inside region")
            self.onEntry(region.identifier)
        case .outside:
            print("Currently outside region")
            self.onExit(region.identifier)
        case .unknown:
            print("Region state unknown")
        }
    }
    
    private func updateStatusMessage() {
        switch authorizationStatus {
        case .notDetermined:
            statusMessage = "Tap to request permission"
        case .denied:
            statusMessage = "Denied - Go to Settings"
        case .restricted:
            statusMessage = "Restricted by system"
        case .authorizedWhenInUse:
            statusMessage = "When in use - Tap for Always"
        case .authorizedAlways:
            statusMessage = "Always authorized ✅"
        @unknown default:
            statusMessage = "Unknown"
        }
    }
    
    private func sendNotification(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Notification error: \(error)")
            }
        }
    }
    
    private func handleRegionEntry(regionId: String) {
        self.onEntry(regionId)
    }
    
    private func handleRegionExit(regionId: String) {
        self.onExit(regionId)
    }
}
