//
//  ColorExtension.swift
//  DzliEra
//
//  Created by Levan Loladze on 17.01.24.
//

import SwiftUI

struct AppColors {
    static let gray = Color(hex: 0x1C1C1C)
    static let black = Color(hex: 0x191B1F)
    static let yellow = Color(hex: 0xD2FF10)
    static let authPageBackground = Color(hex: 0x313131)
    static let authFieldHeader = Color(hex: 0x4F4F4F)
    static let authButtonColor = Color(hex: 0x5D9CFF)
    static let backgroundColor = Color(hex: 0x181922)
    static let secondaryBackgroundColor = Color(hex: 0x21212F)
    static let secondaryRed = Color(hex: 0xD9435C)
}

extension Color {
    init(hex: UInt32, alpha: Double = 1.0) {
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue, opacity: alpha)
    }
}
