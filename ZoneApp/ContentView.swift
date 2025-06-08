////
////  ContentView.swift
////  ZoneApp
////
////  Created by Abhishek on 5/17/25.
////

//import SwiftUI
import FamilyControls
import ManagedSettings
import CoreLocation
//
//// MARK:- Tab Root
//struct ContentView: View {
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

//
//  ZoneSwiftUI – high-fidelity prototype (iOS 17 / Swift 5.9 / Xcode 15)
//  Tabs: Home • Zones • Analytics • Profile
//
import SwiftUI
import Charts
import MapKit
// MARK:- Splash View
struct SplashView: View {
    @Binding var isActive: Bool
    @State private var scale: CGFloat = 1.0
    var body: some View {
        ZStack {
            Color(red: 0.02, green: 0.04, blue: 0.19).ignoresSafeArea() // Updated dark blue background
            Image("Zone App Icon")
                .resizable()
                .scaledToFit()
                .frame(width: 280, height: 280)
                .scaleEffect(scale)
        }
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 3.5).repeatCount(1, autoreverses: true)) {
                scale = 1.4
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 7.0) {
                withAnimation(.easeOut(duration: 0.5)) {
                    isActive = false
                }
            }
        }
    }
}
// MARK:- App Entry
class ZoneStore: ObservableObject {
    @Published var zones: [Zone] = sampleZones
}
struct ZoneRootView: View {
    @AppStorage("isDarkMode") private var storedDarkMode = false
    @EnvironmentObject var zoneStore: ZoneStore
    @State private var showSplash = true
    var body: some View {
        ZStack {
            ContentView()
            if showSplash {
                SplashView(isActive: $showSplash)
                    .transition(.opacity)
                    .zIndex(1)
            }
        }
        .preferredColorScheme(storedDarkMode ? .dark : .light)
    }
}
//@main
//struct ZoneApp: App {
//}
// MARK:- Theme
extension Color {
    // Brand
    static let primaryPurple = Color(UIColor { trait in
        trait.userInterfaceStyle == .dark
            ? UIColor(red: 0.24, green: 0.52, blue: 0.93, alpha: 1.0)  // #3d85ee
            : UIColor(red: 0.36, green: 0.20, blue: 0.96, alpha: 1.0) // original #5c33f6
    })
    static let successGreen  = Color(hex: "#16a34a")
    static let errorRed      = Color(hex: "#ef4444")
    static let warningAmber  = Color(hex: "#f59e0b")
    // Dynamic Greys
    static var bgMain: Color {
        Color(UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor(red: 0.02, green: 0.04, blue: 0.19, alpha: 1.0)
                : UIColor(red: 0.96, green: 0.96, blue: 0.97, alpha: 1.0)
        })
    }
    static var bgCard: Color {
        Color(UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor(red: 0.13, green: 0.22, blue: 0.38, alpha: 1.0)  // #21385f
                : UIColor.white
        })
    }
    static var bgSecondary: Color {
        Color(UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor(red: 0.20, green: 0.27, blue: 0.42, alpha: 1.0)  // #334568
                : UIColor(red: 0.90, green: 0.91, blue: 0.92, alpha: 1.0)
        })
    }
    static var textPrimary: Color {
        Color(UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor.white
                : UIColor(red: 0.12, green: 0.16, blue: 0.22, alpha: 1.0)
        })
    }
    static var textSecondary: Color {
        Color(UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor.lightGray
                : UIColor(red: 0.42, green: 0.44, blue: 0.50, alpha: 1.0)
        })
    }
    static var textTertiary: Color {
        Color(UIColor { trait in
            trait.userInterfaceStyle == .dark
                ? UIColor.gray
                : UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1.0)
        })
    }
    /// `#RRGGBB` or `#RRGGBBAA`
    init(hex: String) {
        var str = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        if str.count == 6 { str += "FF" }
        var v: UInt64 = 0; Scanner(string: str).scanHexInt64(&v)
        self.init(.sRGB,
                  red:   Double((v>>24)&0xFF)/255,
                  green: Double((v>>16)&0xFF)/255,
                  blue:  Double((v>>8)&0xFF)/255,
                  opacity: Double(v&0xFF)/255)
    }
}
// MARK:- Reusable UI
struct Card<Content: View>: View {
    let padding: CGFloat; let content: Content
    init(padding: CGFloat = 16, @ViewBuilder _ content: () -> Content) {
        self.padding = padding; self.content = content()
    }
    var body: some View {
        VStack { content }
            .padding(padding)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.bgCard)
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.03), radius: 4, y: 2)
    }
}
struct IconBubble: View {
    var system: String
    var body: some View {
        Image(systemName: system)
            .foregroundColor(.primaryPurple)
            .padding(12)
            .background(Color.primaryPurple.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
struct HorizontalBar: View {
    var progress: Double; var tint: Color = .primaryPurple
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Capsule().fill(Color.bgSecondary)
                Capsule().fill(tint)
                    .frame(width: geo.size.width * progress)
            }
        }
        .frame(height: 6)
    }
}
struct Badge: View {
    enum Style { case active, inactive, neutral }
    var text: String; var style: Style = .active
    private var fg: Color {
        switch style { case .active: .successGreen
                       case .inactive: .textSecondary
                       case .neutral: .primaryPurple }
    }
    private var bg: Color {
        switch style { case .active:   Color(hex:"#dcfce7")
                       case .inactive: Color(hex:"#e6e6e6")
                       case .neutral:  Color.primaryPurple.opacity(0.15) }
    }
    var body: some View {
        Text(text)
            .font(.caption2.weight(.semibold))
            .foregroundColor(fg)
            .padding(.horizontal, 8).padding(.vertical, 2)
            .background(RoundedRectangle(cornerRadius: 6).fill(bg))
    }
}
struct Logo: View {
    var body: some View {
        Image("Zone App Icon")
            .resizable()
            .scaledToFit()
            .frame(height: 28)
    }
}
// Category icon
struct CategoryIcon: View {
    var title: String; var color: Color; var icon: String
    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(color.darken())
                .padding(18)
                .background(color)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            Text(title).font(.caption)
        }
    }
}
private extension Color {
    func darken(_ amount: Double = 0.6) -> Color {
        let ui = UIColor(self)
        var h: CGFloat=0,s:CGFloat=0,b:CGFloat=0,a:CGFloat=0
        ui.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return Color(hue: Double(h), saturation: Double(s),
                     brightness: Double(b)*amount, opacity: Double(a))
    }
}
// ProgressRing
struct ProgressRing: View {
    var progress: Double; var lineWidth: CGFloat = 8; var size: CGFloat = 70
    var body: some View {
        ZStack {
            Circle().stroke(Color.bgSecondary, lineWidth: lineWidth)
            Circle().trim(from:0,to:progress)
                .stroke(Color.primaryPurple,
                        style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
            Text(String(format:"%0.0f%%",progress*100))
                .font(.caption.bold())
        }
        .frame(width: size, height: size)
    }
}
// MARK:- Create ZoneView & ZoneType (global scope)
enum ZoneType: String, CaseIterable, Identifiable {
    case gps = "GPS"
    case ble = "BLE"
    var id: String { rawValue }
}
struct IdentifiableDay: Identifiable {
    var id: String { day }
    let day: String
}
// MARK:- Tab Root
struct ContentView: View {
    let center = AuthorizationCenter.shared
    @State private var selection = FamilyActivitySelection()
    @State private var isPresented = false
    let store = ManagedSettingsStore()
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        TabView {
            HomeView()      .tabItem { Label("Home",      systemImage: "house") }
            ZonesView(isPresented: $isPresented, selection: $selection, addZone: addZone)     .tabItem { Label("Zones",     systemImage: "mappin.and.ellipse") }
            AnalyticsView() .tabItem { Label("Analytics", systemImage: "chart.bar.xaxis") }
            ProfileView()   .tabItem { Label("Profile",   systemImage: "person") }
        }
        .background(Color.bgMain)
        .onAppear {
            Task {
                do {
                    try await center.requestAuthorization(for: .individual)
                } catch {
                    print("Failed to register Screen Time because: \(error)")
                }
                
                locationManager.requestLocationPermission()
            }
        }
    }
    
    private func blockSelectedApps(selection: FamilyActivitySelection) {
//        store.application.blockedApplications = Set(selection.applicationTokens.map { token in
//            Application(token: token)
//        })
        store.shield.applications = Set(selection.applicationTokens)
    }

    private func unblockAll() {
        store.shield.applications = Set()
    }
    
    private func addZone(lat: Double, long: Double, radius: Double, name: String) {
        // Example: Home location
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let region = CLCircularRegion(
            center: coordinate,
            radius: radius, // meters
            identifier: name
        )

        locationManager.startMonitoring(region: region, onEntry_: { regionId in
            blockSelectedApps(selection: selection)
        }, onExit_: { _ in unblockAll() })
    }
}
// MARK:- ZONES (scroll enabled)
struct ZonesView: View {
    @Binding var isPresented: Bool
    @Binding var selection: FamilyActivitySelection
    let addZone: (Double, Double, Double, String) -> Void
    
    @EnvironmentObject var zoneStore: ZoneStore
    @State private var showCreateZone = false
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: true) {         // ← scrollable
                VStack(spacing: 16) {
                    filters
                    ForEach(zoneStore.zones) { ZoneCard(zone: $0) }
                }
                .padding()
            }
            .navigationTitle("Focus Zones")
            .toolbar { ToolbarItem(placement: .navigationBarLeading) { Logo() } }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {} label: { Image(systemName: "bell") }
                    Button {} label: { Image(systemName: "gearshape") }
                }
            }
            .background(Color.bgMain)
        }
        .overlay(fabPlus, alignment: .bottomTrailing)
    }
    // Filters + FAB (unchanged) … ——————————————————————————
    private var filters: some View {
        HStack(spacing: 12) { filter("All Types"); filter("All Status") }
    }
    private func filter(_ label: String) -> some View {
        Menu { Button("Placeholder") {} } label: {
            HStack { Text(label); Image(systemName: "chevron.down") }
                .font(.caption)
                .padding(.horizontal, 12).padding(.vertical, 6)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.bgCard))
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.bgSecondary))
        }
    }
    private var fabPlus: some View {
        Button(action: { showCreateZone = true }) {
            Image(systemName: "plus")
                .font(.title2.bold()).foregroundColor(.white)
                .padding(24).background(Circle().fill(Color.primaryPurple))
                .shadow(radius: 4)
        }
        .padding([.bottom, .trailing], 24)
        .fullScreenCover(isPresented: $showCreateZone) {
            CreateZoneView(isPresented: $isPresented, selection: $selection, addZone: addZone)
        }
    }
}
struct ZoneCard: View {
    let zone: Zone
    var body: some View {
        Card {
            HStack(alignment: .top, spacing: 12) {
                IconBubble(system: zone.type == .ble
                                        ? "dot.radiowaves.left.and.right" : "mappin")
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(zone.name).font(.callout.weight(.semibold))
                        Spacer()
                        Badge(text: zone.isActive ? "Active" : "Inactive",
                              style: zone.isActive ? .active : .inactive)
                    }
                    HStack(spacing: 6) {
                        Text(zone.type.rawValue.uppercased())
                            .font(.caption2.bold())
                            .padding(.horizontal, 6).padding(.vertical, 2)
                            .background(Color.primaryPurple.opacity(0.1))
                            .cornerRadius(4).foregroundColor(.primaryPurple)
                        Label(zone.lastActive, systemImage: "clock")
                            .font(.caption).foregroundColor(.textSecondary)
                    }
                    HStack(spacing: 6) {
                        Text("\(Int(zone.successRate*100))% success rate")
                        Text(zone.radiusDescription)
                    }
                    .font(.caption2).foregroundColor(.textSecondary)
                }
                Spacer()
                VStack(spacing: 8) {
                    Button {} label: { Image(systemName: "pencil") }
                    Button {} label: { Image(systemName: "ellipsis") }
                }
                .foregroundColor(.textSecondary)
            }
        }
    }
}
// MARK:- Preview
#Preview("Zone Demo – iPhone 16 Pro") {
    ContentView()
        .environmentObject(ZoneStore())
}

