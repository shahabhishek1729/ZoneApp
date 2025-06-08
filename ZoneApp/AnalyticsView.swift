////
////  AnalyticsView.swift
////  ZoneApp
////
////  Created by Abhishek on 5/17/25.
////
//
import SwiftUI
//
//// MARK:- ANALYTICS (scroll enabled)
//struct AnalyticsView: View {
//    @State private var range      = "This Week"
//    @State private var zoneFilter = "All Zones"
//    private let ranges      = ["Today","This Week","Last Week","This Month"]
//    private let zoneOptions = ["All Zones","Home Office","Study Room"]
//
//    var body: some View {
//        NavigationStack {
//            ScrollView(.vertical, showsIndicators: true) {          // ← scrollable
//                VStack(spacing: 20) {
//
//                    // 1. Filters
//                    HStack(spacing: 12) {
//                        picker($range, options: ranges)
//                        picker($zoneFilter, options: zoneOptions)
//                    }
//
//                    // 2. Stat grid
//                    LazyVGrid(columns:[GridItem(.flexible()),
//                                       GridItem(.flexible())],spacing:12) {
//                        statTile("32h 45m", "Total Focus Time")
//                        statTile("87%",     "Success Rate")
//                        statTile("4 of 5",  "Active Zones")
//                        Card {
//                            VStack(alignment: .leading, spacing: 4) {
//                                Text("Home Office").font(.subheadline.weight(.semibold))
//                                Text("Most Productive")
//                                    .font(.caption).foregroundColor(.textSecondary)
//                            }
//                        }
//                    }
//
//                    // 3. Time distribution
//                    Card {
//                        header("Time Distribution", action:"Compare")
//                        TimeDistributionChart().frame(height:170)
//                        HStack {
//                            legend(.primaryPurple,"GPS")
//                            legend(.blue,"BLE")
//                            legend(.warningAmber,"Schedule")
//                        }
//                    }
//
//                    // 4. Productivity trend
//                    Card {
//                        header("Productivity Trends", caption:"Last 4 Weeks")
//                        ProductivityChart().frame(height:150)
//                        HStack {
//                            legend(.successGreen,"Peak: 2-4 PM")
//                            Spacer()
//                            Badge(text:"Goal achieved: 5/7 days", style:.neutral)
//                        }
//                        .padding(.top,4)
//                    }
//
//                    // 5. Zone performance
//                    Card {
//                        header("Zone Performance", action:"View All")
//                        ForEach(sampleZones) { zone in
//                            VStack(alignment: .leading, spacing: 4) {
//                                HStack {
//                                    Text(zone.name)
//                                        .font(.callout.weight(.semibold))
//                                    Badge(text:"\(Int(zone.successRate*100))%",
//                                          style:.neutral)
//                                    Spacer()
//                                }
//                                HorizontalBar(progress:zone.successRate)
//                                    .frame(height:6)
//                                Text(zone.type.rawValue.uppercased())
//                                    .font(.caption2).foregroundColor(.textSecondary)
//                            }
//                            .padding(.vertical,6)
//                        }
//                    }
//
//                    // 6. App blocking donut
//                    Card {
//                        header("App Blocking", caption:"Top 5 Apps")
//                        HStack {
//                            DonutChart(data:appStats).frame(width:120,height:120)
//                            Spacer()
//                            VStack(alignment: .leading, spacing: 8) {
//                                ForEach(appStats,id:\.name) { s in
//                                    HStack {
//                                        Circle().fill(s.color)
//                                            .frame(width:6,height:6)
//                                        Text(s.name).font(.caption)
//                                            .frame(width:70,alignment:.leading)
//                                        HorizontalBar(progress:s.percent,
//                                                      tint:s.color)
//                                            .frame(width:80,height:4)
//                                        Text(String(format:"%0.0f%%",s.percent*100))
//                                            .font(.caption2)
//                                    }
//                                }
//                            }
//                        }
//                        Divider().padding(.vertical,6)
//                        HStack(spacing:16) {
//                            smallStat("124","Block attempts")
//                            smallStat("87%","Success rate")
//                            smallStat("8h 15m","Time saved")
//                        }
//                    }
//
//                    // 7. Daily activity
//                    Card {
//                        header("Daily Activity", action:"Details")
//                        VStack(spacing:8) {
//                            activity("Morning (6-12)",0.75)
//                            activity("Afternoon (12-6)",0.92,.primaryPurple)
//                            activity("Evening (6-12)",0.45,.warningAmber)
//                        }
//                        Text("Peak productivity: Tue & Thu afternoons")
//                            .font(.caption2).foregroundColor(.textSecondary)
//                    }
//
//                    // Export
//                    Button { } label: {
//                        Text("⬇︎ Export Analytics Data")
//                            .font(.subheadline.weight(.semibold))
//                            .foregroundColor(.primaryPurple)
//                            .padding(.vertical,12)
//                            .frame(maxWidth:.infinity)
//                            .overlay(RoundedRectangle(cornerRadius:10)
//                                        .stroke(Color.primaryPurple))
//                    }
//                    .padding(.top,4)
//
//                }
//                .padding()
//            }
//            .navigationTitle("Analytics")
//            .toolbar { ToolbarItem(placement:.navigationBarLeading) { Logo() } }
//            .toolbar {
//                ToolbarItemGroup(placement:.navigationBarTrailing) {
//                    Button {} label: { Image(systemName:"bell") }
//                    Button {} label: { Image(systemName:"gearshape") }
//                }
//            }
//            .background(Color.bgMain)
//        }
//    }
//
//    // Analytics helpers (unchanged) … ————————————————
//    private func picker(_ b:Binding<String>, options:[String]) -> some View {
//        Menu {
//            ForEach(options,id:\.self) { o in Button(o){ b.wrappedValue=o } }
//        } label: {
//            HStack { Text(b.wrappedValue); Image(systemName:"chevron.down") }
//                .font(.caption)
//                .padding(.horizontal,12).padding(.vertical,6)
//                .background(RoundedRectangle(cornerRadius:8).fill(Color.bgCard))
//                .overlay(RoundedRectangle(cornerRadius:8).stroke(Color.bgSecondary))
//        }
//    }
//    @ViewBuilder private func header(_ t:String,
//                                     caption:String? = nil,
//                                     action:String? = nil) -> some View {
//        HStack {
//            Text(t).font(.subheadline.weight(.semibold))
//            Spacer()
//            if let caption = caption {
//                Text(caption).font(.caption).foregroundColor(.textSecondary)
//            }
//            if let action = action {
//                Button(action) {}.font(.caption).foregroundColor(.primaryPurple)
//            }
//        }
//    }
//    private func legend(_ c:Color,_ label:String)->some View {
//        HStack(spacing:4){ Circle().fill(c).frame(width:6,height:6)
//            Text(label).font(.caption2) }
//    }
//    private func statTile(_ v:String,_ l:String)->some View {
//        Card{ VStack(alignment:.leading,spacing:4){
//            Text(v).font(.title3.bold())
//            Text(l).font(.caption).foregroundColor(.textSecondary) } }
//    }
//    private func smallStat(_ v:String,_ l:String)->some View {
//        VStack{ Text(v).font(.headline.bold())
//            Text(l).font(.caption).foregroundColor(.textSecondary) }
//            .frame(maxWidth:.infinity)
//    }
//    private func activity(_ l:String,_ pct:Double,_ tint:Color = .primaryPurple)->some View{
//        VStack(alignment:.leading,spacing:2){
//            HStack{
//                Text(l).font(.caption)
//                Spacer()
//                Text(String(format:"%0.0f%%",pct*100))
//                    .font(.caption2).foregroundColor(.textSecondary)
//            }
//            HorizontalBar(progress:pct,tint:tint)
//        }
//    }
//}
//
// MARK:- ANALYTICS (scroll enabled)
struct AnalyticsView: View {
    @State private var range      = "This Week"
    @State private var zoneFilter = "All Zones"
    private let ranges      = ["Today","This Week","Last Week","This Month"]
    private let zoneOptions = ["All Zones","Home Office","Study Room"]
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: true) {          // ← scrollable
                VStack(spacing: 20) {
                    // 1. Filters
                    HStack(spacing: 12) {
                        picker($range, options: ranges)
                        picker($zoneFilter, options: zoneOptions)
                    }
                    // 2. Stat grid
                    LazyVGrid(columns:[GridItem(.flexible()),
                                       GridItem(.flexible())],spacing:12) {
                        statTile("32h 45m", "Total Focus Time")
                        statTile("87%",     "Success Rate")
                        statTile("4 of 5",  "Active Zones")
                        Card {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Home Office").font(.subheadline.weight(.semibold))
                                Text("Most Productive")
                                    .font(.caption).foregroundColor(.textSecondary)
                            }
                        }
                    }
                    // 3. Time distribution
                    Card {
                        header("Time Distribution", action:"Compare")
                        TimeDistributionChart().frame(height:170)
                        HStack {
                            legend(.primaryPurple,"GPS")
                            legend(.blue,"BLE")
                            legend(.warningAmber,"Schedule")
                        }
                    }
                    // 4. Productivity trend
                    Card {
                        header("Productivity Trends", caption:"Last 4 Weeks")
                        ProductivityChart().frame(height:150)
                        HStack {
                            legend(.successGreen,"Peak: 2-4 PM")
                            Spacer()
                            Badge(text:"Goal achieved: 5/7 days", style:.neutral)
                        }
                        .padding(.top,4)
                    }
                    // 5. Zone performance
                    Card {
                        header("Zone Performance", action:"View All")
                        ForEach(sampleZones) { zone in
                            VStack(alignment: .leading, spacing: 4) {
                                HStack {
                                    Text(zone.name)
                                        .font(.callout.weight(.semibold))
                                    Badge(text:"\(Int(zone.successRate*100))%",
                                          style:.neutral)
                                    Spacer()
                                }
                                HorizontalBar(progress:zone.successRate)
                                    .frame(height:6)
                                Text(zone.type.rawValue.uppercased())
                                    .font(.caption2).foregroundColor(.textSecondary)
                            }
                            .padding(.vertical,6)
                        }
                    }
                    // 6. App blocking donut
                    Card {
                        header("App Blocking", caption:"Top 5 Apps")
                        HStack {
                            DonutChart(data:appStats).frame(width:120,height:120)
                            Spacer()
                            VStack(alignment: .leading, spacing: 8) {
                                ForEach(appStats,id:\.name) { s in
                                    HStack {
                                        Circle().fill(s.color)
                                            .frame(width:6,height:6)
                                        Text(s.name).font(.caption)
                                            .frame(width:70,alignment:.leading)
                                        HorizontalBar(progress:s.percent,
                                                      tint:s.color)
                                            .frame(width:80,height:4)
                                        Text(String(format:"%0.0f%%",s.percent*100))
                                            .font(.caption2)
                                    }
                                }
                            }
                        }
                        Divider().padding(.vertical,6)
                        HStack(spacing:16) {
                            smallStat("124","Block attempts")
                            smallStat("87%","Success rate")
                            smallStat("8h 15m","Time saved")
                        }
                    }
                    // 7. Daily activity
                    Card {
                        header("Daily Activity", action:"Details")
                        VStack(spacing:8) {
                            activity("Morning (6-12)",0.75)
                            activity("Afternoon (12-6)",0.92,.primaryPurple)
                            activity("Evening (6-12)",0.45,.warningAmber)
                        }
                        Text("Peak productivity: Tue & Thu aternoons")
                            .font(.caption2).foregroundColor(.textSecondary)
                    }
                    // Export
                    Button { } label: {
                        Text("⬇︎ Export Analytics Data")
                            .font(.subheadline.weight(.semibold))
                            .foregroundColor(.primaryPurple)
                            .padding(.vertical,12)
                            .frame(maxWidth:.infinity)
                            .overlay(RoundedRectangle(cornerRadius:10)
                                        .stroke(Color.primaryPurple))
                    }
                    .padding(.top,4)
                }
                .padding()
            }
            .navigationTitle("Analytics")
            .toolbar { ToolbarItem(placement:.navigationBarLeading) { Logo() } }
            .toolbar {
                ToolbarItemGroup(placement:.navigationBarTrailing) {
                    Button {} label: { Image(systemName:"bell") }
                    Button {} label: { Image(systemName:"gearshape") }
                }
            }
            .background(Color.bgMain)
        }
    }
    // Analytics helpers (unchanged) … ————————————————
    private func picker(_ b:Binding<String>, options:[String]) -> some View {
        Menu {
            ForEach(options,id:\.self) { o in Button(o){ b.wrappedValue=o } }
        } label: {
            HStack { Text(b.wrappedValue); Image(systemName:"chevron.down") }
                .font(.caption)
                .padding(.horizontal,12).padding(.vertical,6)
                .background(RoundedRectangle(cornerRadius:8).fill(Color.bgCard))
                .overlay(RoundedRectangle(cornerRadius:8).stroke(Color.bgSecondary))
        }
    }
    @ViewBuilder private func header(_ t:String,
                                     caption:String? = nil,
                                     action:String? = nil) -> some View {
        HStack {
            Text(t).font(.subheadline.weight(.semibold))
            Spacer()
            if let caption = caption {
                Text(caption).font(.caption).foregroundColor(.textSecondary)
            }
            if let action = action {
                Button(action) {}.font(.caption).foregroundColor(.primaryPurple)
            }
        }
    }
    private func legend(_ c:Color,_ label:String)->some View {
        HStack(spacing:4){ Circle().fill(c).frame(width:6,height:6)
            Text(label).font(.caption2) }
    }
    private func statTile(_ v:String,_ l:String)->some View {
        Card{ VStack(alignment:.leading,spacing:4){
            Text(v).font(.title3.bold())
            Text(l).font(.caption).foregroundColor(.textSecondary) } }
    }
    private func smallStat(_ v:String,_ l:String)->some View {
        VStack{ Text(v).font(.headline.bold())
            Text(l).font(.caption).foregroundColor(.textSecondary) }
            .frame(maxWidth:.infinity)
    }
    private func activity(_ l:String,_ pct:Double,_ tint:Color = .primaryPurple)->some View{
        VStack(alignment:.leading,spacing:2){
            HStack{
                Text(l).font(.caption)
                Spacer()
                Text(String(format:"%0.0f%%",pct*100))
                    .font(.caption2).foregroundColor(.textSecondary)
            }
            HorizontalBar(progress:pct,tint:tint)
        }
    }
}
