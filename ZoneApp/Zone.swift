////
////  Zone.swift
////  ZoneApp
////
////  Created by Abhishek on 5/17/25.
////
//
import SwiftUI
//
//// MARK:- Mock Models & Data (unchanged)
//struct Zone: Identifiable {
//    enum ZoneType:String{case gps,ble}
//    var id = UUID()
//    var name:String; var type:ZoneType; var lastActive:String
//    var successRate:Double; var radiusDescription:String; var isActive:Bool
//}
// MARK:- Mock Models & Data (unchanged)
struct Zone: Identifiable {
    enum ZoneType:String{case gps,ble}
    var id = UUID()
    var name:String; var type:ZoneType; var lastActive:String
    var successRate:Double; var radiusDescription:String; var isActive:Bool
}
let sampleZones:[Zone] = [
    .init(name:"Home Office", type:.gps,
          lastActive:"Today 10:45 AM", successRate:0.92,
          radiusDescription:"250 m radius", isActive:true),
    .init(name:"Study Room", type:.ble,
          lastActive:"Today 8:30 AM", successRate:0.85,
          radiusDescription:"Beacon ID BL-45X", isActive:true),
    .init(name:"Work Office", type:.gps,
          lastActive:"Yesterday", successRate:0.78,
          radiusDescription:"300 m radius", isActive:false)
]
let appStats:[(name:String,percent:Double,color:Color)] = [
    ("Instagram",0.32,.primaryPurple),
    ("Twitter",  0.24,.blue),
    ("TikTok",   0.18,.successGreen),
    ("Reddit",   0.14,.errorRed),
    ("Other",    0.12,.warningAmber)
]
