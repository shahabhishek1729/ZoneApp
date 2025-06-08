////
////  HomeView.swift
////  ZoneApp
////
////  Created by Abhishek on 5/17/25.
////
//
import SwiftUI
import FamilyControls
//
//struct HomeView: View {
//    @State private var focusProgress: Double = 0.77
//
//    var body: some View {
//        NavigationStack {
//            ScrollView(.vertical, showsIndicators: true) {       // ← scrollable
//                VStack(spacing: 20) {
//                    header
//                    focusCard
//                    activeZoneCard
//                    lockedCategories
//                    myZones
//                    weeklyFocus
//                }
//                .padding()
//            }
//            .navigationTitle("")
//            .toolbar { ToolbarItem(placement: .navigationBarLeading) { Logo() } }
//            .toolbar {
//                ToolbarItemGroup(placement: .navigationBarTrailing) {
//                    Button {} label: { Image(systemName: "bell") }
//                    Button {} label: { Image(systemName: "gearshape") }
//                }
//            }
//            .background(Color.bgMain)
//            .safeAreaInset(edge: .bottom) { Spacer(minLength: 64) }
//        }
//        .overlay(fab, alignment: .bottomTrailing)
//    }
//
//    // Home sections (unchanged) … ——————————————————————————
//    private var header: some View {
//        VStack(alignment: .leading, spacing: 2) {
//            Text("Welcome back, Alex").font(.title3.bold())
//            Text(Date.now.formatted(date: .long, time: .omitted))
//                .font(.caption).foregroundColor(.textSecondary)
//        }
//        .frame(maxWidth: .infinity, alignment: .leading)
//    }
//    private var focusCard: some View {
//        Card {
//            HStack(spacing: 16) {
//                ProgressRing(progress: focusProgress)
//                VStack(alignment: .leading, spacing: 4) {
//                    Text("Today's Focus").font(.subheadline.weight(.semibold))
//                    Text("11h 37m").font(.title3.bold())
//                    Text("Focus time today").font(.caption)
//                        .foregroundColor(.textSecondary)
//                }
//                Spacer()
//                Text("Goal: 90 min").font(.caption2)
//                    .foregroundColor(.textSecondary)
//            }
//        }
//    }
//    private var activeZoneCard: some View {
//        Card {
//            VStack(alignment: .leading, spacing: 12) {
//                HStack {
//                    Text("Active Zone").font(.subheadline.weight(.semibold))
//                    Spacer()
//                    Badge(text: "Active")
//                }
//                HStack(spacing: 12) {
//                    IconBubble(system: "mappin")
//                    VStack(alignment: .leading, spacing: 2) {
//                        Text("GPS Zone: Home Office").font(.callout.weight(.semibold))
//                        Text("840 Cozy Oak Ave")
//                            .font(.caption).foregroundColor(.textSecondary)
//                    }
//                    Spacer()
//                }
//                Divider()
//                HStack {
//                    Label("697m 37s Focus Time", systemImage: "clock")
//                        .font(.caption).foregroundColor(.textSecondary)
//                    Spacer()
//                    Button("Override (1m)") {}
//                        .font(.caption).foregroundColor(.primaryPurple)
//                }
//            }
//        }
//    }
//    private var lockedCategories: some View {
//        Card {
//            VStack(alignment: .leading, spacing: 12) {
//                HStack {
//                    Text("Locked Categories")
//                        .font(.subheadline.weight(.semibold))
//                    Spacer()
//                    Button("3 Categories") {}
//                        .font(.caption).foregroundColor(.primaryPurple)
//                }
//                HStack(spacing: 24) {
//                    CategoryIcon(title: "Social",
//                                 color: Color.errorRed.opacity(0.1),
//                                 icon: "camera")
//                    CategoryIcon(title: "Games",
//                                 color: Color.blue.opacity(0.1),
//                                 icon: "gamecontroller")
//                    CategoryIcon(title: "Streaming",
//                                 color: Color.primaryPurple.opacity(0.1),
//                                 icon: "play.tv")
//                    CategoryIcon(title: "Add",
//                                 color: Color.successGreen.opacity(0.1),
//                                 icon: "plus")
//                }
//            }
//        }
//    }
//    private var myZones: some View {
//        VStack(alignment: .leading, spacing: 8) {
//            HStack {
//                Text("My Zones").font(.subheadline.weight(.semibold))
//                Spacer()
//                Button("View All") {}.font(.caption)
//                    .foregroundColor(.primaryPurple)
//            }
//            zoneRow(name: "Work Office", type: "GPS",
//                    schedule: "Mon-Fri, 9-5", appsLocked: 3, isOn: true)
//            zoneRow(name: "Study Room", type: "BLE",
//                    schedule: "Mon-Thu, 2-8", appsLocked: 5, isOn: true)
//        }
//    }
//    private func zoneRow(name: String, type: String,
//                         schedule: String, appsLocked: Int, isOn: Bool) -> some View {
//        Card(padding: 0) {
//            HStack {
//                IconBubble(system: type == "BLE" ?
//                           "dot.radiowaves.left.and.right" : "mappin")
//                VStack(alignment: .leading, spacing: 2) {
//                    Text(name).font(.callout.weight(.semibold))
//                    HStack(spacing: 6) {
//                        Text(type).font(.caption2.bold())
//                            .padding(.horizontal, 6).padding(.vertical, 2)
//                            .background(Color.primaryPurple.opacity(0.1))
//                            .cornerRadius(4).foregroundColor(.primaryPurple)
//                        Text(schedule).font(.caption)
//                            .foregroundColor(.textSecondary)
//                    }
//                    Text("\(appsLocked) Apps Locked")
//                        .font(.caption2).foregroundColor(.textSecondary)
//                }
//                Spacer()
//                Toggle("", isOn: .constant(isOn))
//                    .toggleStyle(SwitchToggleStyle(tint: .primaryPurple))
//            }
//            .padding(12)
//        }
//    }
//    private var weeklyFocus: some View {
//        Card {
//            VStack(alignment: .leading, spacing: 12) {
//                HStack {
//                    Text("Weekly Focus")
//                        .font(.subheadline.weight(.semibold))
//                    Spacer()
//                    Button("Details") {}.font(.caption)
//                        .foregroundColor(.primaryPurple)
//                }
//                FocusBarChart().frame(height: 140)
//                HStack {
//                    stat("23h", "Total")
//                    Spacer()
//                    stat("+12%", "vs Last Week", .successGreen)
//                    Spacer()
//                    stat("5.2h", "Daily Avg")
//                    Spacer()
//                    stat("4", "Active Zones")
//                }
//            }
//        }
//    }
//    private func stat(_ v: String, _ l: String,
//                      _ c: Color = .textPrimary) -> some View {
//        VStack {
//            Text(v).font(.headline.bold()).foregroundColor(c)
//            Text(l).font(.caption).foregroundColor(.textSecondary)
//        }
//    }
//    private var fab: some View {
//        Button(action: {}) {
//            Image(systemName: "plus")
//                .font(.title2.bold())
//                .foregroundColor(.white)
//                .padding(24)
//                .background(Circle().fill(Color.primaryPurple))
//                .shadow(radius: 4)
//        }
//        .padding([.bottom, .trailing], 24)
//    }
//}
// MARK:- HOME (scroll enabled)
struct HomeView: View {
    @EnvironmentObject var zoneStore: ZoneStore
    @Environment(\.colorScheme) var colorScheme
    @State private var focusProgress: Double = 0.77
    @State private var showCreateZone = false
    
    @Binding var isPresented: Bool
    @Binding var selection: FamilyActivitySelection
    let addZone: (Double, Double, Double, String) -> Void

    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: true) {       // ← scrollable
                VStack(spacing: 20) {
                    header
                    zoneGlowHeader
                    activeZoneCard
                    lockedCategories
                    weeklyFocus
                    myZones
                }
                .padding()
            }
            .navigationTitle("")
            .toolbar { ToolbarItem(placement: .navigationBarLeading) { Logo() } }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {} label: { Image(systemName: "bell") }
                    Button {} label: { Image(systemName: "gearshape") }
                }
            }
            .background(Color.bgMain)
            .safeAreaInset(edge: .bottom) { Spacer(minLength: 64) }
        }
        .overlay(fab, alignment: .bottomTrailing)
    }
    // Home sections (unchanged) … ——————————————————————————
    private var header: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("Welcome back, Alex").font(.title3.bold())
            Text(Date.now.formatted(date: .long, time: .omitted))
                .font(.caption).foregroundColor(.textSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    private var focusCard: some View {
        Card {
            HStack(spacing: 16) {
                ProgressRing(progress: focusProgress)
                VStack(alignment: .leading, spacing: 4) {
                    Text("Today's Focus").font(.subheadline.weight(.semibold))
                    Text("11h 37m").font(.title3.bold())
                    Text("Focus time today").font(.caption)
                        .foregroundColor(.textSecondary)
                }
                Spacer()
                Text("Goal: 90 min").font(.caption2)
                    .foregroundColor(.textSecondary)
            }
        }
    }
    private var activeZoneCard: some View {
        Card {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("Active Zone").font(.subheadline.weight(.semibold))
                    Spacer()
                    Badge(text: "Active")
                }
                HStack(spacing: 12) {
                    IconBubble(system: "mappin")
                    VStack(alignment: .leading, spacing: 2) {
                        Text("GPS Zone: Home Office").font(.callout.weight(.semibold))
                        Text("840 Cozy Oak Ave")
                            .font(.caption).foregroundColor(.textSecondary)
                    }
                    Spacer()
                }
                Divider()
                HStack {
                    Label("697m 37s Focus Time", systemImage: "clock")
                        .font(.caption).foregroundColor(.textSecondary)
                    Spacer()
                    Button("Override (1m)") {}
                        .font(.caption).foregroundColor(.primaryPurple)
                }
            }
        }
    }
    private var lockedCategories: some View {
        Card {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("Locked Categories")
                        .font(.subheadline.weight(.semibold))
                    Spacer()
                    Button("3 Categories") {}
                        .font(.caption).foregroundColor(.primaryPurple)
                }
                HStack(spacing: 24) {
                    CategoryIcon(title: "Social",
                        color: colorScheme == .dark
                            ? Color(red: 0.78, green: 0.33, blue: 0.40)
                            : Color(red: 0.65, green: 0.49, blue: 0.97).opacity(0.4), // soft purple with low opacity
                        icon: "camera")
                    CategoryIcon(title: "Games",
                        color: colorScheme == .dark
                            ? Color(red: 0.34, green: 0.50, blue: 0.75)
                            : Color(red: 1.00, green: 0.75, blue: 0.32).opacity(0.4), // soft orange with low opacity
                        icon: "gamecontroller")
                    CategoryIcon(title: "Streaming",
                        color: colorScheme == .dark
                            ? Color(red: 0.46, green: 0.39, blue: 0.74)
                            : Color(red: 0.38, green: 0.83, blue: 0.67).opacity(0.4), // soft green with low opacity
                        icon: "play.tv")
                    CategoryIcon(title: "Add",
                        color: colorScheme == .dark
                            ? Color(red: 0.36, green: 0.63, blue: 0.51)
                            : Color.successGreen.opacity(0.4),
                        icon: "plus")
                }
            }
        }
    }
    private var myZones: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("My Zones").font(.subheadline.weight(.semibold))
                Spacer()
                Button("View All") {}.font(.caption)
                    .foregroundColor(.primaryPurple)
            }
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 12) {
                    ForEach(zoneStore.zones) { zone in
                        zoneRow(
                            name: zone.name,
                            type: zone.type == .ble ? "BLE" : "GPS",
                            schedule: zone.type == .gps ? "Mon-Fri, 9-5" : "Mon-Thu, 2-8",
                            appsLocked: 3,
                            isOn: zone.isActive
                        )
                    }
                }
            }
            .frame(minHeight: 100, maxHeight: 300)
        }
    }
    private func zoneRow(name: String, type: String,
                         schedule: String, appsLocked: Int, isOn: Bool) -> some View {
        Card(padding: 0) {
            HStack {
                IconBubble(system: type == "BLE" ?
                           "dot.radiowaves.left.and.right" : "mappin")
                VStack(alignment: .leading, spacing: 2) {
                    Text(name).font(.callout.weight(.semibold))
                    HStack(spacing: 6) {
                        Text(type).font(.caption2.bold())
                            .padding(.horizontal, 6).padding(.vertical, 2)
                            .background(Color.primaryPurple.opacity(0.1))
                            .cornerRadius(4).foregroundColor(.primaryPurple)
                        Text(schedule).font(.caption)
                            .foregroundColor(.textSecondary)
                    }
                    Text("\(appsLocked) Apps Locked")
                        .font(.caption2).foregroundColor(.textSecondary)
                }
                Spacer()
                Toggle("", isOn: .constant(isOn))
                    .toggleStyle(SwitchToggleStyle(tint: .primaryPurple))
            }
            .padding(12)
        }
    }
    private var weeklyFocus: some View {
        Card {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("Weekly Focus")
                        .font(.subheadline.weight(.semibold))
                    Spacer()
                    Button("Details") {}.font(.caption)
                        .foregroundColor(.primaryPurple)
                }
                FocusBarChart().frame(height: 140)
                HStack {
                    stat("23h", "Total")
                    Spacer()
                    stat("+12%", "vs Last Week", .successGreen)
                    Spacer()
                    stat("5.2h", "Daily Avg")
                    Spacer()
                    stat("4", "Active Zones")
                }
            }
        }
    }
    private func stat(_ v: String, _ l: String,
                      _ c: Color = .textPrimary) -> some View {
        VStack {
            Text(v).font(.headline.bold()).foregroundColor(c)
            Text(l).font(.caption).foregroundColor(.textSecondary)
        }
    }
    private var fab: some View {
        Button(action: { showCreateZone = true }) {
            Image(systemName: "plus")
                .font(.title2.bold())
                .foregroundColor(.white)
                .padding(24)
                .background(Circle().fill(Color.primaryPurple))
                .shadow(radius: 4)
        }
        .padding([.bottom, .trailing], 24)
        .sheet(isPresented: $showCreateZone) {
            CreateZoneView(isPresented: $isPresented, selection: $selection, addZone: addZone)
        }
    }
}

private var zoneGlowHeader: some View {
    VStack(spacing: 6) {
        ZStack {
            // Blurred glowing background with subtle blue streaks
            Circle()
                .stroke(Color(hex: "#cae8ff").opacity(0.5), lineWidth: 40)
                .frame(width: 220, height: 220)
                .blur(radius: 60)
            ForEach(0..<3) { i in
                Circle()
                    .stroke(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.clear, Color(hex: "#3d85ee").opacity(0.6)]),
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        lineWidth: CGFloat(12 + i * 4)
                    )
                    .frame(width: CGFloat(180 + i * 20), height: CGFloat(180 + i * 20))
                    .rotationEffect(.degrees(Double(i) * 30))
                    .blur(radius: 20)
            }
            Image("zone glow")
                .resizable()
                .scaledToFit()
                .frame(width: 220, height: 220)
                .shadow(color: .white.opacity(0.6), radius: 40)
                .shadow(color: Color(hex: "#cae8ff").opacity(0.5), radius: 60)
        }
        Text("2h 36m")
            .font(.largeTitle.bold())
            .foregroundColor(.textPrimary)
        Text("Screen Time Today")
            .font(.caption)
            .foregroundColor(.textSecondary)
    }
    .frame(maxWidth: .infinity)
}
