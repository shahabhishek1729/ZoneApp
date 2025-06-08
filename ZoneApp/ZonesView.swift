////
////  ZonesView.swift
////  ZoneApp
////
////  Created by Abhishek on 5/17/25.
////
//
//import SwiftUI
//
//// MARK:- ZONES (scroll enabled)
//struct ZonesView: View {
//    var body: some View {
//        NavigationStack {
//            ScrollView(.vertical, showsIndicators: true) {         // ← scrollable
//                VStack(spacing: 16) {
//                    filters
//                    ForEach(sampleZones) { ZoneCard(zone: $0) }
//                }
//                .padding()
//            }
//            .navigationTitle("Focus Zones")
//            .toolbar { ToolbarItem(placement: .navigationBarLeading) { Logo() } }
//            .toolbar {
//                ToolbarItemGroup(placement: .navigationBarTrailing) {
//                    Button {} label: { Image(systemName: "bell") }
//                    Button {} label: { Image(systemName: "gearshape") }
//                }
//            }
//            .background(Color.bgMain)
//        }
//        .overlay(fabPlus, alignment: .bottomTrailing)
//    }
//
//    // Filters + FAB (unchanged) … ——————————————————————————
//    private var filters: some View {
//        HStack(spacing: 12) { filter("All Types"); filter("All Status") }
//    }
//    private func filter(_ label: String) -> some View {
//        Menu { Button("Placeholder") {} } label: {
//            HStack { Text(label); Image(systemName: "chevron.down") }
//                .font(.caption)
//                .padding(.horizontal, 12).padding(.vertical, 6)
//                .background(RoundedRectangle(cornerRadius: 8).fill(Color.bgCard))
//                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.bgSecondary))
//        }
//    }
//    private var fabPlus: some View {
//        Button {} label: {
//            Image(systemName: "plus")
//                .font(.title2.bold()).foregroundColor(.white)
//                .padding(24).background(Circle().fill(Color.primaryPurple))
//                .shadow(radius: 4)
//        }
//        .padding([.bottom, .trailing], 24)
//    }
//}
//struct ZoneCard: View {
//    let zone: Zone
//    var body: some View {
//        Card {
//            HStack(alignment: .top, spacing: 12) {
//                IconBubble(system: zone.type == .ble
//                                        ? "dot.radiowaves.left.and.right" : "mappin")
//                VStack(alignment: .leading, spacing: 4) {
//                    HStack {
//                        Text(zone.name).font(.callout.weight(.semibold))
//                        Spacer()
//                        Badge(text: zone.isActive ? "Active" : "Inactive",
//                              style: zone.isActive ? .active : .inactive)
//                    }
//                    HStack(spacing: 6) {
//                        Text(zone.type.rawValue.uppercased())
//                            .font(.caption2.bold())
//                            .padding(.horizontal, 6).padding(.vertical, 2)
//                            .background(Color.primaryPurple.opacity(0.1))
//                            .cornerRadius(4).foregroundColor(.primaryPurple)
//                        Label(zone.lastActive, systemImage: "clock")
//                            .font(.caption).foregroundColor(.textSecondary)
//                    }
//                    HStack(spacing: 6) {
//                        Text("\(Int(zone.successRate*100))% success rate")
//                        Text(zone.radiusDescription)
//                    }
//                    .font(.caption2).foregroundColor(.textSecondary)
//                }
//                Spacer()
//                VStack(spacing: 8) {
//                    Button {} label: { Image(systemName: "pencil") }
//                    Button {} label: { Image(systemName: "ellipsis") }
//                }
//                .foregroundColor(.textSecondary)
//            }
//        }
//    }
//}
