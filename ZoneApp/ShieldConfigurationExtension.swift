//
//  ShieldConfigurationExtension 2.swift
//  ZoneApp
//
//  Created by Abhishek on 6/8/25.
//


// In your ShieldConfigurationExtension
import ManagedSettings
import ManagedSettingsUI
import UIKit

class ShieldConfigurationExtension: ShieldConfigurationDataSource {
    
    override func configuration(shielding application: Application) -> ShieldConfiguration {
        return ShieldConfiguration(
            backgroundBlurStyle: .systemMaterial,
            backgroundColor: UIColor.systemBlue, // Your brand color
            title: ShieldConfiguration.Label(
                text: "App Blocked",
                color: .white
            ),
            subtitle: ShieldConfiguration.Label(
                text: "Managed by Zone",
                color: .white.withAlphaComponent(0.8)
            ),
            primaryButtonLabel: ShieldConfiguration.Label(
                text: "Ok",
                color: .white
            ),
        )
    }
}
