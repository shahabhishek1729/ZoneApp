//
//  Device.swift
//  ZoneApp
//
//  Created by Abhishek on 6/7/25.
//

import SwiftUI

struct Device: Identifiable {
    var id=UUID(); var name:String; var subtitle:String
    var icon:String; var primary:Bool=false
}
let sampleDevices:[Device] = [
    .init(name:"iPhone 14 Pro",subtitle:"Currently active",
          icon:"iphone",primary:true),
    .init(name:"MacBook Pro",subtitle:"Last active: 2 h ago",
          icon:"laptopcomputer"),
    .init(name:"iPad Air",subtitle:"Last active: 3 days ago",
          icon:"ipad")
]
