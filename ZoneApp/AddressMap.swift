//
//  AddressMap.swift
//  ZoneApp
//
//  Created by Abhishek on 6/8/25.
//

//import SwiftUI
//import MapKit
//
//// Model for search results
//struct SearchResult: Identifiable, Hashable {
//    let id = UUID()
//    let title: String
//    let subtitle: String
//    let coordinate: CLLocationCoordinate2D
//    
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
//    
//    static func == (lhs: SearchResult, rhs: SearchResult) -> Bool {
//        lhs.id == rhs.id
//    }
//}
//
//// Search manager for handling address autocomplete
//class LocationSearchManager: NSObject, ObservableObject {
//    @Published var searchResults: [SearchResult] = []
//    @Published var isSearching = false
//    
//    private let searchCompleter = MKLocalSearchCompleter()
//    private var currentTask: Task<Void, Never>?
//    
//    override init() {
//        super.init()
//        searchCompleter.delegate = self
//        searchCompleter.resultTypes = [.address, .pointOfInterest]
//    }
//    
//    func search(for query: String) {
//        guard !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
//            searchResults = []
//            return
//        }
//        
//        isSearching = true
//        searchCompleter.queryFragment = query
//    }
//    
//    func selectLocation(_ result: SearchResult, completion: @escaping (CLLocationCoordinate2D) -> Void) {
//        currentTask?.cancel()
//        
//        currentTask = Task {
//            let request = MKLocalSearch.Request()
//            request.naturalLanguageQuery = "\(result.title) \(result.subtitle)"
//            
//            let search = MKLocalSearch(request: request)
//            
//            do {
//                let response = try await search.start()
//                if let coordinate = response.mapItems.first?.placemark.coordinate {
//                    await MainActor.run {
//                        completion(coordinate)
//                    }
//                }
//            } catch {
//                print("Search error: \(error)")
//            }
//        }
//    }
//}
//
//// Extension for MKLocalSearchCompleter delegate
//extension LocationSearchManager: MKLocalSearchCompleterDelegate {
//    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
//        DispatchQueue.main.async {
//            self.searchResults = completer.results.map { completion in
//                SearchResult(
//                    title: completion.title,
//                    subtitle: completion.subtitle,
//                    coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0) // Placeholder
//                )
//            }
//            self.isSearching = false
//        }
//    }
//    
//    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
//        DispatchQueue.main.async {
//            self.isSearching = false
//            print("Autocomplete error: \(error)")
//        }
//    }
//}
//
//// Custom annotation for map
//struct LocationAnnotation: Identifiable {
//    let id = UUID()
//    let coordinate: CLLocationCoordinate2D
//    let title: String
//}
//
//// Main view
//struct AddressSearchMapView: View {
//    @Binding var lat: Double?
//    @Binding var long: Double?
//
//    @StateObject private var locationManager = LocationSearchManager()
//    @State private var searchText = ""
//    @State private var showingResults = false
//    @State private var selectedCoordinate: CLLocationCoordinate2D?
//    @State private var selectedAddress = ""
//    @State private var mapRegion = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
//        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
//    )
//    
//    var annotation: LocationAnnotation? {
//        guard let coordinate = selectedCoordinate else { return nil }
//        return LocationAnnotation(coordinate: coordinate, title: selectedAddress)
//    }
//    
//    var body: some View {
//        NavigationView {
//            ZStack {
//                // Map background
//                Map(coordinateRegion: $mapRegion,
//                    annotationItems: annotation.map { [$0] } ?? []) { location in
//                    MapPin(coordinate: location.coordinate, tint: .red)
//                }
//                .ignoresSafeArea()
//                
//                VStack {
//                    // Search interface
//                    VStack(spacing: 0) {
//                        // Search bar
//                        HStack {
//                            Image(systemName: "magnifyingglass")
//                                .foregroundColor(.gray)
//                            
//                            TextField("Search for an address...", text: $searchText)
//                                .textFieldStyle(PlainTextFieldStyle())
//                                .onChange(of: searchText) { query in
//                                    locationManager.search(for: query)
//                                    showingResults = !query.isEmpty
//                                }
//                                .onTapGesture {
//                                    showingResults = !searchText.isEmpty
//                                }
//                            
//                            if !searchText.isEmpty {
//                                Button("Clear") {
//                                    searchText = ""
//                                    showingResults = false
//                                    locationManager.searchResults = []
//                                }
//                                .foregroundColor(.blue)
//                                .font(.caption)
//                            }
//                        }
//                        .padding()
//                        .background(Color(.systemBackground))
//                        .cornerRadius(12)
//                        .shadow(radius: 2)
//                        
//                        // Search results
//                        if showingResults && !locationManager.searchResults.isEmpty {
//                            ScrollView {
//                                LazyVStack(alignment: .leading, spacing: 0) {
//                                    ForEach(locationManager.searchResults) { result in
//                                        Button(action: {
//                                            selectAddress(result)
//                                        }) {
//                                            VStack(alignment: .leading, spacing: 4) {
//                                                Text(result.title)
//                                                    .font(.headline)
//                                                    .foregroundColor(.primary)
//                                                    .multilineTextAlignment(.leading)
//                                                
//                                                if !result.subtitle.isEmpty {
//                                                    Text(result.subtitle)
//                                                        .font(.caption)
//                                                        .foregroundColor(.secondary)
//                                                        .multilineTextAlignment(.leading)
//                                                }
//                                            }
//                                            .frame(maxWidth: .infinity, alignment: .leading)
//                                            .padding(.vertical, 12)
//                                            .padding(.horizontal, 16)
//                                        }
//                                        .buttonStyle(PlainButtonStyle())
//                                        
//                                        if result != locationManager.searchResults.last {
//                                            Divider()
//                                        }
//                                    }
//                                }
//                            }
//                            .frame(maxHeight: 300)
//                            .background(Color(.systemBackground))
//                            .cornerRadius(12)
//                            .shadow(radius: 2)
//                        }
//                        
//                        if locationManager.isSearching {
//                            HStack {
//                                ProgressView()
//                                    .scaleEffect(0.8)
//                                Text("Searching...")
//                                    .font(.caption)
//                                    .foregroundColor(.secondary)
//                            }
//                            .padding()
//                            .background(Color(.systemBackground))
//                            .cornerRadius(8)
//                            .shadow(radius: 1)
//                        }
//                    }
//                    .padding(.horizontal)
//                    .padding(.top)
//                    
//                    Spacer()
//                    
//                    // Results display
//                    if let coordinate = selectedCoordinate {
//                        VStack(alignment: .leading, spacing: 12) {
//                            HStack {
//                                Text("Selected Location")
//                                    .font(.headline)
//                                Spacer()
//                                Button("Copy") {
//                                    let coordString = "\(coordinate.latitude),\(coordinate.longitude)"
//                                    UIPasteboard.general.string = coordString
//                                }
//                                .font(.caption)
//                                .buttonStyle(.bordered)
//                            }
//                            
//                            Text(selectedAddress)
//                                .font(.subheadline)
//                                .foregroundColor(.secondary)
//                            
//                            HStack {
//                                VStack(alignment: .leading) {
//                                    Text("Latitude")
//                                        .font(.caption)
//                                        .foregroundColor(.secondary)
//                                    Text("\(coordinate.latitude, specifier: "%.6f")")
//                                        .font(.system(.body, design: .monospaced))
//                                }
//                                
//                                Spacer()
//                                
//                                VStack(alignment: .trailing) {
//                                    Text("Longitude")
//                                        .font(.caption)
//                                        .foregroundColor(.secondary)
//                                    Text("\(coordinate.longitude, specifier: "%.6f")")
//                                        .font(.system(.body, design: .monospaced))
//                                }
//                            }
//                        }
//                        .padding()
//                        .background(Color(.systemBackground))
//                        .cornerRadius(12)
//                        .shadow(radius: 2)
//                        .padding(.horizontal)
//                        .padding(.bottom)
//                    }
//                }
//            }
//            .navigationTitle("Address Search")
//            .navigationBarTitleDisplayMode(.inline)
//        }
//        .onTapGesture {
//            // Hide search results when tapping outside
//            if showingResults {
//                showingResults = false
//            }
//        }
//    }
//    
//    private func selectAddress(_ result: SearchResult) {
//        searchText = result.title
//        selectedAddress = "\(result.title), \(result.subtitle)"
//        showingResults = false
//        
//        locationManager.selectLocation(result) { coordinate in
//            selectedCoordinate = coordinate
//            
//            withAnimation {
//                mapRegion = MKCoordinateRegion(
//                    center: coordinate,
//                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//                )
//            }
//            
//            lat = coordinate.latitude
//            long = coordinate.longitude
//        }
//    }
//}

import SwiftUI
import MapKit

// Model for search results
struct SearchResult: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let subtitle: String
    let coordinate: CLLocationCoordinate2D
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: SearchResult, rhs: SearchResult) -> Bool {
        lhs.id == rhs.id
    }
}

// Search manager for handling address autocomplete
class LocationSearchManager: NSObject, ObservableObject {
    @Published var searchResults: [SearchResult] = []
    @Published var isSearching = false
    
    private let searchCompleter = MKLocalSearchCompleter()
    private var currentTask: Task<Void, Never>?
    
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.resultTypes = [.address, .pointOfInterest]
    }
    
    func search(for query: String) {
        guard !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            searchResults = []
            return
        }
        
        isSearching = true
        searchCompleter.queryFragment = query
    }
    
    func selectLocation(_ result: SearchResult, completion: @escaping (CLLocationCoordinate2D) -> Void) {
        currentTask?.cancel()
        
        currentTask = Task {
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = "\(result.title) \(result.subtitle)"
            
            let search = MKLocalSearch(request: request)
            
            do {
                let response = try await search.start()
                if let coordinate = response.mapItems.first?.placemark.coordinate {
                    await MainActor.run {
                        completion(coordinate)
                    }
                }
            } catch {
                print("Search error: \(error)")
            }
        }
    }
}

// Extension for MKLocalSearchCompleter delegate
extension LocationSearchManager: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        DispatchQueue.main.async {
            self.searchResults = completer.results.map { completion in
                SearchResult(
                    title: completion.title,
                    subtitle: completion.subtitle,
                    coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0) // Placeholder
                )
            }
            self.isSearching = false
        }
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        DispatchQueue.main.async {
            self.isSearching = false
            print("Autocomplete error: \(error)")
        }
    }
}

// Custom annotation for map
struct LocationAnnotation: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let title: String
}

// Circle overlay for the map
struct CircleOverlay: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let radius: CLLocationDistance // in meters
}

// Main view
struct AddressSearchMapView: View {
    @Binding var lat: Double?
    @Binding var long: Double?
    @Binding var radiusInMeters: Double // Add this binding for radius

    @StateObject private var locationManager = LocationSearchManager()
    @State private var searchText = ""
    @State private var showingResults = false
    @State private var selectedCoordinate: CLLocationCoordinate2D?
    @State private var selectedAddress = ""
    @State private var mapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    var annotation: LocationAnnotation? {
        guard let coordinate = selectedCoordinate else { return nil }
        return LocationAnnotation(coordinate: coordinate, title: selectedAddress)
    }
    
    var circleOverlay: CircleOverlay? {
        guard let coordinate = selectedCoordinate else { return nil }
        return CircleOverlay(coordinate: coordinate, radius: radiusInMeters)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                // Map background with circle overlay
                Map(coordinateRegion: $mapRegion,
                    annotationItems: annotation.map { [$0] } ?? []) { location in
                    MapPin(coordinate: location.coordinate, tint: .red)
                }
                .overlay(
                    // Circle overlay
                    circleOverlay.map { overlay in
                        MapCircleOverlay(center: overlay.coordinate, radius: overlay.radius)
                    }
                )
                .ignoresSafeArea()
                
                VStack {
                    // Search interface
                    VStack(spacing: 0) {
                        // Search bar
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            
                            TextField("Search for an address...", text: $searchText)
                                .textFieldStyle(PlainTextFieldStyle())
                                .onChange(of: searchText) { query in
                                    locationManager.search(for: query)
                                    showingResults = !query.isEmpty
                                }
                                .onTapGesture {
                                    showingResults = !searchText.isEmpty
                                }
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .shadow(radius: 2)
                        
                        // Search results
                        if showingResults && !locationManager.searchResults.isEmpty {
                            ScrollView {
                                LazyVStack(alignment: .leading, spacing: 0) {
                                    ForEach(locationManager.searchResults) { result in
                                        Button(action: {
                                            print("Clicked!")
                                            selectAddress(result)
                                        }) {
                                            VStack(alignment: .leading, spacing: 4) {
                                                Text(result.title)
                                                    .font(.headline)
                                                    .foregroundColor(.primary)
                                                    .multilineTextAlignment(.leading)
                                                
                                                if !result.subtitle.isEmpty {
                                                    Text(result.subtitle)
                                                        .font(.caption)
                                                        .foregroundColor(.secondary)
                                                        .multilineTextAlignment(.leading)
                                                }
                                            }
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.vertical, 12)
                                            .padding(.horizontal, 16)
                                            .background(Color(hex: "#FFFFFF"))
                                            .onTapGesture {
                                                selectAddress(result)
                                            }
                                        }
                                        .contentShape(Rectangle())
                                        .buttonStyle(PlainButtonStyle())
                                        .background(Color(hex: "#FFFFFF"))

                                        if result != locationManager.searchResults.last {
                                            Divider()
                                        }
                                    }
                                }
                            }
                            .frame(maxHeight: 300)
                            .background(Color(.systemBackground))
                            .cornerRadius(12)
                            .shadow(radius: 2)
                        }
                        
                        if locationManager.isSearching {
                            HStack {
                                ProgressView()
                                    .scaleEffect(0.8)
                                Text("Searching...")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .cornerRadius(8)
                            .shadow(radius: 1)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    Spacer()
                    
                    // Results display
                    if let coordinate = selectedCoordinate {
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text("Selected Location")
                                    .font(.headline)
                                Spacer()
                                Button("Copy") {
                                    let coordString = "\(coordinate.latitude),\(coordinate.longitude)"
                                    UIPasteboard.general.string = coordString
                                }
                                .font(.caption)
                                .buttonStyle(.bordered)
                            }
                            
                            Text(selectedAddress)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Latitude")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    Text("\(coordinate.latitude, specifier: "%.6f")")
                                        .font(.system(.body, design: .monospaced))
                                }
                                
                                Spacer()
                                
                                VStack(alignment: .trailing) {
                                    Text("Longitude")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    Text("\(coordinate.longitude, specifier: "%.6f")")
                                        .font(.system(.body, design: .monospaced))
                                }
                            }
                            
                            // Radius display
                            HStack {
                                Text("Radius")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text("\(radiusInMeters, specifier: "%.0f") meters")
                                    .font(.system(.body, design: .monospaced))
                            }
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .shadow(radius: 2)
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                }
            }
            .navigationTitle("Address Search")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func selectAddress(_ result: SearchResult) {
        searchText = result.title
        selectedAddress = "\(result.title), \(result.subtitle)"
        showingResults = false
        
        locationManager.selectLocation(result) { coordinate in
            selectedCoordinate = coordinate
            
            let radiusInDegrees = radiusInMeters / 111111
        
            // Calculate appropriate zoom level based on radius
            withAnimation {
                mapRegion = MKCoordinateRegion(
                    center: coordinate,
                    span: MKCoordinateSpan(
                        latitudeDelta: radiusInDegrees * 4,
                        longitudeDelta: radiusInDegrees * 4
                    )
                )
            }
            
            lat = coordinate.latitude
            long = coordinate.longitude
        }
    }
}

// Custom Map Circle Overlay View
struct MapCircleOverlay: UIViewRepresentable {
    let center: CLLocationCoordinate2D
    let radius: CLLocationDistance
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.isUserInteractionEnabled = false
        
        let radiusInDegrees = radius / 111111
    
        mapView.region = MKCoordinateRegion(
            center: center,
            span: MKCoordinateSpan(
                latitudeDelta: radiusInDegrees * 4,
                longitudeDelta: radiusInDegrees * 4
            )
        )
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        // Remove existing overlays
        mapView.removeOverlays(mapView.overlays)
        
        // Add circle overlay
        let circle = MKCircle(center: center, radius: radius)
        mapView.addOverlay(circle)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let circle = overlay as? MKCircle {
                let renderer = MKCircleRenderer(circle: circle)
                renderer.strokeColor = .systemBlue
                renderer.fillColor = .systemBlue.withAlphaComponent(0.2)
                renderer.lineWidth = 2
                return renderer
            }
            return MKOverlayRenderer(overlay: overlay)
        }
    }
}
