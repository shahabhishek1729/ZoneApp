//
//  ScreenTime.swift
//  ScreenTime
//
//  Created by Abhishek on 6/1/25.
//

import DeviceActivity
import SwiftUI

@main
struct ScreenTime: DeviceActivityReportExtension {
    var body: some DeviceActivityReportScene {
        // Create a report for each DeviceActivityReport.Context that your app supports.
        TotalActivityReport { totalActivity in
            TotalActivityView(totalActivity: totalActivity)
        }
        // Add more reports here...
    }
}
