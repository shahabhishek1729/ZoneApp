////
////  Components.swift
////  ZoneApp
////
////  Created by Abhishek on 5/17/25.
////
//
//import SwiftUI
//
//// MARK:- Theme
//extension Color {
//    // Brand
//    static let primaryPurple = Color(hex: "#5c33f6")
//    static let successGreen  = Color(hex: "#16a34a")
//    static let errorRed      = Color(hex: "#ef4444")
//    static let warningAmber  = Color(hex: "#f59e0b")
//    // Greys
//    static let bgMain        = Color(hex: "#f5f5f7")
//    static let bgCard        = Color.white          // ← `.white` fixed
//    static let bgSecondary   = Color(hex: "#e5e7eb")
//    static let textPrimary   = Color(hex: "#1f2937")
//    static let textSecondary = Color(hex: "#6b7280")
//    static let textTertiary  = Color(hex: "#9ca3af")
//
//    /// `#RRGGBB` or `#RRGGBBAA`
//    init(hex: String) {
//        var str = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
//        if str.count == 6 { str += "FF" }
//        var v: UInt64 = 0; Scanner(string: str).scanHexInt64(&v)
//        self.init(.sRGB,
//                  red:   Double((v>>24)&0xFF)/255,
//                  green: Double((v>>16)&0xFF)/255,
//                  blue:  Double((v>>8)&0xFF)/255,
//                  opacity: Double(v&0xFF)/255)
//    }
//}
//
//// MARK:- Reusable UI
//struct Card<Content: View>: View {
//    let padding: CGFloat; let content: Content
//    init(padding: CGFloat = 16, @ViewBuilder _ content: () -> Content) {
//        self.padding = padding; self.content = content()
//    }
//    var body: some View {
//        VStack { content }
//            .padding(padding)
//            .frame(maxWidth: .infinity, alignment: .leading)
//            .background(Color.bgCard)
//            .cornerRadius(12)
//            .shadow(color: .black.opacity(0.03), radius: 4, y: 2)
//    }
//}
//struct IconBubble: View {
//    var system: String
//    var body: some View {
//        Image(systemName: system)
//            .foregroundColor(.primaryPurple)
//            .padding(12)
//            .background(Color.primaryPurple.opacity(0.1))
//            .clipShape(RoundedRectangle(cornerRadius: 12))
//    }
//}
//struct HorizontalBar: View {
//    var progress: Double; var tint: Color = .primaryPurple
//    var body: some View {
//        GeometryReader { geo in
//            ZStack(alignment: .leading) {
//                Capsule().fill(Color.bgSecondary)
//                Capsule().fill(tint)
//                    .frame(width: geo.size.width * progress)
//            }
//        }
//        .frame(height: 6)
//    }
//}
//struct Badge: View {
//    enum Style { case active, inactive, neutral }
//    var text: String; var style: Style = .active
//    private var fg: Color {
//        switch style { case .active: .successGreen
//                       case .inactive: .textSecondary
//                       case .neutral: .primaryPurple }
//    }
//    private var bg: Color {
//        switch style { case .active:   Color(hex:"#dcfce7")
//                       case .inactive: Color(hex:"#e6e6e6")
//                       case .neutral:  Color.primaryPurple.opacity(0.15) }
//    }
//    var body: some View {
//        Text(text)
//            .font(.caption2.weight(.semibold))
//            .foregroundColor(fg)
//            .padding(.horizontal, 8).padding(.vertical, 2)
//            .background(RoundedRectangle(cornerRadius: 6).fill(bg))
//    }
//}
//struct Logo: View {
//    var body: some View {
//        Text("logo").font(.headline.weight(.black))
//            .foregroundColor(.primaryPurple)
//    }
//}
//
