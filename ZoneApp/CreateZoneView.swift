//
//  CreateZoneView.swift
//  ZoneApp
//
//  Created by Abhishek on 6/7/25.
//

import SwiftUI
import CoreLocation
import FamilyControls
import MapKit


struct FamilyActivityPickerWrapper: View {
    @Binding var isPresented: Bool
    @Binding var selection: FamilyActivitySelection
    
    var body: some View {
        Color.clear
            .familyActivityPicker(isPresented: $isPresented, selection: $selection)
    }
}

struct CreateZoneView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var zoneStore: ZoneStore
    @State private var zoneName: String = ""
    @State private var zoneType: ZoneType = .gps
    
    @State private var address = ""
    @State private var lat: Double?
    @State private var long: Double?
    @State private var isLoading = false
    @State private var errorMessage = ""
    
    private let geocoder = CLGeocoder()
    
    @State private var radius: Double = 100
    @State private var scheduleDays: [String: Bool] = [
        "Mon": false, "Tue": false, "Wed": false, "Thu": false,
        "Fri": false, "Sat": false, "Sun": false
    ]
    @State private var selectedCategories: Set<String> = []
    @State private var showPairPopup = false
    // --- Day/time selection state
    @State private var selectedDayForTime: IdentifiableDay? = nil
    @State private var showEndTimePicker: Bool = false
    @State private var startTime: Date = Date()
    @State private var endTime: Date = Calendar.current.date(byAdding: .hour, value: 1, to: Date())!
    @State private var selectedDayLabel: String = ""
    
    @Binding var isPresented: Bool
    @Binding var selection: FamilyActivitySelection
    
    let addZone: (Double, Double, Double, String) -> Void

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    Picker("Zone Type", selection: $zoneType) {
                        ForEach(ZoneType.allCases) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    .pickerStyle(.segmented)
                    if zoneType == .ble {
                        blePairingSection
                    } else {
                        gpsZoneFormSection
                    }
                    Button(action: {
                        // Create a new Zone and add to the shared store
                        let newZone = Zone(
                            name: zoneName.isEmpty ? "New Zone" : zoneName,
                            type: zoneType == .ble ? .ble : .gps,
                            lastActive: "Just now",
                            successRate: 1.0,
                            radiusDescription: zoneType == .gps ? "\(Int(radius)) m radius" : "Beacon ID BL-NEW",
                            isActive: true
                        )
                        zoneStore.zones.append(newZone)
                        dismiss()
                        
                        addZone(lat!, long!, radius, zoneName.isEmpty ? "New Zone" : zoneName)
                    }) {
                        Text("Create Zone")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.primaryPurple)
                            .cornerRadius(10)
                    }
                    .disabled(lat == nil && long == nil)
                }
                .padding()
            }
            .navigationTitle("New Zone")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
            }
            // Sheet for start time picker per day
            .sheet(item: $selectedDayForTime) { wrapper in
                let day = wrapper.day
                VStack(spacing: 16) {
                    Text("Set a start time for \(selectedDayLabel)")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .padding(.top)
                    DatePicker("Start Time", selection: $startTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                        .frame(maxWidth: .infinity)
                    Button("Next") {
                        selectedDayForTime = nil
                        showEndTimePicker = true
                    }
                    .padding(.bottom)
                }
                .padding(.horizontal)
                .presentationDetents([.fraction(0.4)])
            }
            // Sheet for end time picker
            .sheet(isPresented: $showEndTimePicker) {
                VStack(spacing: 12) {
                    Text("Set an end time for \(selectedDayLabel)")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .padding(.top)
                    DatePicker("End", selection: $endTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                        .frame(maxWidth: .infinity)
                    Button("All Day") {
                        startTime = Calendar.current.startOfDay(for: Date())
                        endTime = Calendar.current.date(bySettingHour: 23, minute: 59, second: 0, of: Date())!
                    }
                    .font(.caption)
                    .padding(6)
                    .background(Color.primaryPurple.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    Button("Done") {
                        showEndTimePicker = false
                    }
                    .padding(.bottom)
                }
                .padding(.horizontal)
                .presentationDetents([.fraction(0.4)])
            }
        }
    }
    // MARK: - BLE Pairing Section
    private var blePairingSection: some View {
        Button("Pair Beacon Device") {
            showPairPopup = true
        }
        .padding()
        .sheet(isPresented: $showPairPopup) {
            VStack {
                Text("Searching for Beacons...")
                    .font(.headline)
                ProgressView()
                Button("Close") { showPairPopup = false }
                    .padding(.top)
            }
            .padding()
        }
    }
    // MARK: - GPS Zone Form Section
    private var gpsZoneFormSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            TextField("Zone Name", text: $zoneName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            AddressSearchMapView(lat: $lat, long: $long, radiusInMeters: $radius)
            
            HStack {
                Text("Radius: \(Int(radius)) m")
                Slider(value: $radius, in: 50...500)
            }
            Text("Schedule")
                .font(.headline)
            HStack {
                ForEach(scheduleDays.keys.sorted(), id: \.self) { day in
                    Button(day) {
                        scheduleDays[day]?.toggle()
                        if scheduleDays[day]! {
                            selectedDayLabel = day
                            selectedDayForTime = IdentifiableDay(day: day)
                        }
                    }
                    .padding(6)
                    .background(scheduleDays[day]! ? Color.primaryPurple : Color.gray.opacity(0.3))
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                }
            }
            Text("App Categories")
                .font(.headline)
            // Chip-style toggle buttons
            Button("Select Apps to Block") {
                isPresented = true
            }
//            .background(
//                FamilyActivityPickerWrapper(isPresented: $isPresented, selection: $selection)
//            )
            .familyActivityPicker(isPresented: $isPresented, selection: $selection)
//            .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
//                // Force dismiss if app becomes active again (user might have backgrounded to escape)
//                if isPresented {
//                    isPresented = false
//                }
//            }
            .onChange(of: selection) { selection_ in
                selection = selection_
                addZone(lat!, long!, radius, zoneName.isEmpty ? "New Zone" : zoneName)
                let newZone = Zone(
                    name: zoneName.isEmpty ? "New Zone" : zoneName,
                    type: zoneType == .ble ? .ble : .gps,
                    lastActive: "Just now",
                    successRate: 1.0,
                    radiusDescription: zoneType == .gps ? "\(Int(radius)) m radius" : "Beacon ID BL-NEW",
                    isActive: true
                )
                zoneStore.zones.append(newZone)
            }
        }
    }
    
    private func geocodeAddress() {
        isLoading = true
        errorMessage = ""
        lat = nil
        long = nil
        
        geocoder.geocodeAddressString(address) { placemarks, error in
            DispatchQueue.main.async {
                isLoading = false
                
                if let error = error {
                    errorMessage = "Error: \(error.localizedDescription)"
                    return
                }
                
                guard let placemark = placemarks?.first,
                      let location = placemark.location else {
                    errorMessage = "No coordinates found for this address"
                    return
                }
                
                lat = location.coordinate.latitude
                long = location.coordinate.longitude
            }
        }
    }
}
