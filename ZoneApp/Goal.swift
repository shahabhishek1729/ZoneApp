////
////  Goal.swift
////  ZoneApp
////
////  Created by Abhishek on 5/17/25.
////
//
import SwiftUI
//
//struct Goal: Identifiable {
//    enum Status:String{case onTrack="On track",
//                       needsAttention="Needs attention",
//                       done="Done"}
//    var id = UUID(); var title:String; var progress:Double
//    var current:Double; var target:Double; var daysLeft:Int
//    var status:Status
//}
//
//extension Goal.Status {
//    var badgeStyle:Badge.Style {
//        switch self { case .onTrack:.active
//                      case .needsAttention:.inactive
//                      case .done:.neutral }
//    }
//    var barColor:Color {
//        switch self { case .onTrack:.successGreen
//                      case .needsAttention:.warningAmber
//                      case .done:.primaryPurple }
//    }
//}
struct Goal: Identifiable {
    enum Status:String{case onTrack="On track",
                       needsAttention="Needs attention",
                       done="Done"}
    var id = UUID(); var title:String; var progress:Double
    var current:Double; var target:Double; var daysLeft:Int
    var status:Status
}
extension Goal.Status {
    var badgeStyle:Badge.Style {
        switch self { case .onTrack:.active
                      case .needsAttention:.inactive
                      case .done:.neutral }
    }
    var barColor:Color {
        switch self { case .onTrack:.successGreen
                      case .needsAttention:.warningAmber
                      case .done:.primaryPurple }
    }
}
let sampleGoals:[Goal] = [
    .init(title:"40 hours focus time weekly",progress:0.8,
          current:32,target:40,daysLeft:2,status:.onTrack),
    .init(title:"30 day focus streak",progress:0.8,
          current:24,target:30,daysLeft:6,status:.onTrack),
    .init(title:"Reduce distractions by 50%",progress:0.35,
          current:35,target:50,daysLeft:10,status:.needsAttention)
]
