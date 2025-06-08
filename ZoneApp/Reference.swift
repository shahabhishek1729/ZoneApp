////
////  Reference.swift
////  ZoneApp
////
////  Created by Abhishek on 6/7/25.
////
//import SwiftUI
//
//struct ContentView_: View {
//    var body: some View {
////        TabView {
////            HomeView()      .tabItem { Label("Home",      systemImage: "house") }
////            ZonesView()     .tabItem { Label("Zones",     systemImage: "mappin.and.ellipse") }
////            AnalyticsView() .tabItem { Label("Analytics", systemImage: "chart.bar.xaxis") }
////            ProfileView()   .tabItem { Label("Profile",   systemImage: "person") }
////        }
//        VStack {
//            Button("Select Apps to Block") {
//                isPresented = true
//            }
//            .familyActivityPicker(isPresented: $isPresented, selection: $selection)
//            .onChange(of: selection) { presented in
//                selection = presented
//            }
//            .preferredColorScheme(.light)
//            .onAppear {
//                Task {
//                    do {
//                        try await center.requestAuthorization(for: .individual)
//                    } catch {
//                        print("Failed to register Screen Time because: \(error)")
//                    }
//                }
//            }
//
//            Text("Location Status: \(statusText)")
//
//            Button("Request Location Permission") {
//                locationManager.requestLocationPermission()
//            }
//
//            Button("Add Home Zone") {
//                addHomeZone { regionId in
//                    blockSelectedApps(selection: selection)
//                } onExit: { regionId in
//                    unblockAll()
//                }
//
//            }
//            .disabled(locationManager.authorizationStatus != .authorizedAlways)
//
//            Button("Add Work Zone") {
//                addWorkZone { regionId in
//                    blockSelectedApps(selection: selection)
//                } onExit: { regionId in
//                    unblockAll()
//                }
//
//            }
//            .disabled(locationManager.authorizationStatus != .authorizedAlways)
//        }
//    }
//
//    private func blockSelectedApps(selection: FamilyActivitySelection) {
//        store.application.blockedApplications = Set(selection.applicationTokens.map { token in
//            Application(token: token)
//        })
//    }
//
//    private func unblockAll() {
//        store.application.blockedApplications = Set()
//    }
//
//    private var statusText: String {
//            switch locationManager.authorizationStatus {
//            case .authorizedAlways: return "Always Authorized ✅"
//            case .authorizedWhenInUse: return "When In Use Only ⚠️"
//            case .denied: return "Denied ❌"
//            case .restricted: return "Restricted"
//            case .notDetermined: return "Not Determined"
//            @unknown default: return "Unknown"
//            }
//        }
//
//        private func addHomeZone(onEntry: @escaping (String) -> Void, onExit: @escaping (String) -> Void) {
//            // Example: Home location
//            let homeCoordinate = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
//            let homeRegion = CLCircularRegion(
//                center: homeCoordinate,
//                radius: 100, // meters
//                identifier: "Home"
//            )
//
//            locationManager.startMonitoring(region: homeRegion, onEntry_: onEntry, onExit_: onExit)
//        }
//
//        private func addWorkZone(onEntry: @escaping (String) -> Void, onExit: @escaping (String) -> Void) {
//            // Example: Work location
//            let workCoordinate = CLLocationCoordinate2D(latitude: 35.7779, longitude: -78.9055)
//            let workRegion = CLCircularRegion(
//                center: workCoordinate,
//                radius: 2000, // meters
//                identifier: "Work"
//            )
//
//            locationManager.startMonitoring(region: workRegion, onEntry_: onEntry, onExit_: onExit)
//        }
//}
