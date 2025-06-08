//
//  ZoneAppApp.swift
//  ZoneApp
//
//  Created by Abhishek on 5/17/25.
//

//import SwiftUI
//
//@main
//struct ZoneAppApp: App {
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}

import SwiftUI
import Charts

// MARK:- App Entry
@main
struct ZoneAppApp: App {
    @StateObject private var zoneStore = ZoneStore()
    var body: some Scene {
        WindowGroup {
            ZoneRootView()
                .environmentObject(zoneStore)
        }
    }
}

//// Category icon
//struct CategoryIcon: View {
//    var title: String; var color: Color; var icon: String
//    var body: some View {
//        VStack(spacing: 6) {
//            Image(systemName: icon)
//                .font(.title3)
//                .foregroundColor(color.darken())
//                .padding(18)
//                .background(color)
//                .clipShape(RoundedRectangle(cornerRadius: 16))
//            Text(title).font(.caption)
//        }
//    }
//}
//
//private extension Color {
//    func darken(_ amount: Double = 0.6) -> Color {
//        let ui = UIColor(self)
//        var h: CGFloat=0,s:CGFloat=0,b:CGFloat=0,a:CGFloat=0
//        ui.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
//        return Color(hue: Double(h), saturation: Double(s),
//                     brightness: Double(b)*amount, opacity: Double(a))
//    }
//}
//
//// ProgressRing
//struct ProgressRing: View {
//    var progress: Double; var lineWidth: CGFloat = 8; var size: CGFloat = 70
//    var body: some View {
//        ZStack {
//            Circle().stroke(Color.bgSecondary, lineWidth: lineWidth)
//            Circle().trim(from:0,to:progress)
//                .stroke(Color.primaryPurple,
//                        style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
//                .rotationEffect(.degrees(-90))
//            Text(String(format:"%0.0f%%",progress*100))
//                .font(.caption.bold())
//        }
//        .frame(width: size, height: size)
//    }
//}
//
//
//// MARK:- Charts (unchanged, scroll-safe)
//struct TimeDistributionChart: View {
//    let data:[[Double]] = [ [1,0.6,0.4],[1.1,0.5,0.4],[1.2,0.4,0.5],
//                            [1.3,0.4,0.4],[1,0.3,0.3],[0.4,0.1,0.2],
//                            [0.3,0.1,0.1] ]
//    var body: some View {
//        Chart {
//            ForEach(Array(data.enumerated()), id:\.offset) { d,segs in
//                ForEach(0..<segs.count,id:\.self) { i in
//                    BarMark(x:.value("Day",d),
//                            y:.value("Min",segs[i]),
//                            stacking:.normalized)
//                        .foregroundStyle(i==0 ? Color.primaryPurple
//                                      : i==1 ? Color.blue
//                                             : Color.warningAmber)
//                }
//            }
//        }.chartXAxis(.hidden).chartYAxis(.hidden)
//    }
//}
//struct ProductivityChart: View {
//    let pts:[Double] = [0.65,0.7,0.75,0.82]
//    var body: some View {
//        Chart {
//            ForEach(Array(pts.enumerated()), id:\.offset) { w,v in
//                LineMark(x:.value("Week",w),y:.value("Score",v))
//                    .lineStyle(.init(lineWidth:2))
//                    .interpolationMethod(.catmullRom)
//                    .foregroundStyle(Color.primaryPurple)
//                AreaMark(x:.value("Week",w),y:.value("Score",v))
//                    .foregroundStyle(Color.primaryPurple.opacity(0.15))
//            }
//        }.chartXAxis(.hidden).chartYAxis(.hidden)
//    }
//}
//struct DonutChart: View {
//    let data:[(name:String,percent:Double,color:Color)]
//    var body: some View {
//        Chart {
//            ForEach(Array(data.enumerated()),id:\.offset) { _,e in
//                SectorMark(angle:.value("v",e.percent))
//                    .foregroundStyle(e.color)
//            }
//        }.chartLegend(.hidden)
//    }
//}
//struct FocusBarChart: View {
//    let data:[Double] = [10,20,30,40,55,35,15]
//    var body: some View {
//        Chart {
//            ForEach(Array(data.enumerated()),id:\.offset) { d,v in
//                BarMark(x:.value("Day",d),y:.value("Min",v))
//                    .foregroundStyle(Color.primaryPurple)
//            }
//        }.chartXAxis(.hidden).chartYAxis(.hidden)
//    }
//}
//
//let sampleZones:[Zone] = [
//    .init(name:"Home Office", type:.gps,
//          lastActive:"Today 10:45 AM", successRate:0.92,
//          radiusDescription:"250 m radius", isActive:true),
//    .init(name:"Study Room", type:.ble,
//          lastActive:"Today 8:30 AM", successRate:0.85,
//          radiusDescription:"Beacon ID BL-45X", isActive:true),
//    .init(name:"Work Office", type:.gps,
//          lastActive:"Yesterday", successRate:0.78,
//          radiusDescription:"300 m radius", isActive:false)
//]
//let appStats:[(name:String,percent:Double,color:Color)] = [
//    ("Instagram",0.32,.primaryPurple),
//    ("Twitter",  0.24,.blue),
//    ("TikTok",   0.18,.successGreen),
//    ("Reddit",   0.14,.errorRed),
//    ("Other",    0.12,.warningAmber)
//]
//
//let sampleGoals:[Goal] = [
//    .init(title:"40 hours focus time weekly",progress:0.8,
//          current:32,target:40,daysLeft:2,status:.onTrack),
//    .init(title:"30 day focus streak",progress:0.8,
//          current:24,target:30,daysLeft:6,status:.onTrack),
//    .init(title:"Reduce distractions by 50%",progress:0.35,
//          current:35,target:50,daysLeft:10,status:.needsAttention)
//]
//struct Device: Identifiable {
//    var id=UUID(); var name:String; var subtitle:String
//    var icon:String; var primary:Bool=false
//}
//let sampleDevices:[Device] = [
//    .init(name:"iPhone 14 Pro",subtitle:"Currently active",
//          icon:"iphone",primary:true),
//    .init(name:"MacBook Pro",subtitle:"Last active: 2 h ago",
//          icon:"laptopcomputer"),
//    .init(name:"iPad Air",subtitle:"Last active: 3 days ago",
//          icon:"ipad")
//]
