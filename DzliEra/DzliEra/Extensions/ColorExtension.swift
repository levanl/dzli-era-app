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
}

extension Color {
    init(hex: UInt32, alpha: Double = 1.0) {
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue, opacity: alpha)
    }
}
