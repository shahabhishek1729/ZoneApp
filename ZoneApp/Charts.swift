//
//  Charts.swift
//  ZoneApp
//
//  Created by Abhishek on 6/7/25.
//
import SwiftUI
import Charts

// MARK:- Charts (unchanged, scroll-safe)
struct TimeDistributionChart: View {
    let data:[[Double]] = [ [1,0.6,0.4],[1.1,0.5,0.4],[1.2,0.4,0.5],
                            [1.3,0.4,0.4],[1,0.3,0.3],[0.4,0.1,0.2],
                            [0.3,0.1,0.1] ]
    var body: some View {
        Chart {
            ForEach(Array(data.enumerated()), id:\.offset) { d,segs in
                ForEach(0..<segs.count,id:\.self) { i in
                    BarMark(x:.value("Day",d),
                            y:.value("Min",segs[i]),
                            stacking:.normalized)
                        .foregroundStyle(i==0 ? Color.primaryPurple
                                      : i==1 ? Color.blue
                                             : Color.warningAmber)
                }
            }
        }.chartXAxis(.hidden).chartYAxis(.hidden)
    }
}
struct ProductivityChart: View {
    let pts:[Double] = [0.65,0.7,0.75,0.82]
    var body: some View {
        Chart {
            ForEach(Array(pts.enumerated()), id:\.offset) { w,v in
                LineMark(x:.value("Week",w),y:.value("Score",v))
                    .lineStyle(.init(lineWidth:2))
                    .interpolationMethod(.catmullRom)
                    .foregroundStyle(Color.primaryPurple)
                AreaMark(x:.value("Week",w),y:.value("Score",v))
                    .foregroundStyle(Color.primaryPurple.opacity(0.15))
            }
        }.chartXAxis(.hidden).chartYAxis(.hidden)
    }
}
struct DonutChart: View {
    let data:[(name:String,percent:Double,color:Color)]
    var body: some View {
        Chart {
            ForEach(Array(data.enumerated()),id:\.offset) { _,e in
                SectorMark(angle:.value("v",e.percent))
                    .foregroundStyle(e.color)
            }
        }.chartLegend(.hidden)
    }
}
struct FocusBarChart: View {
    let data:[Double] = [10,20,30,40,55,35,15]
    var body: some View {
        Chart {
            ForEach(Array(data.enumerated()),id:\.offset) { d,v in
                BarMark(x:.value("Day",d),y:.value("Min",v))
                    .foregroundStyle(Color.primaryPurple)
            }
        }.chartXAxis(.hidden).chartYAxis(.hidden)
    }
}
