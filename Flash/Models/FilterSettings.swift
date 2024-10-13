//
//  FilterSettings.swift
//  Flash
//
//  Created by Shreyas Patil on 10/12/24.
//

import Foundation

struct FilterSettings {
    var brightness: Float = 0.0
    var contrast: Float = 1.0
    var exposure: Float = 0.0
    var saturation: Float = 1.0
    var vibrance: Float = 0.0
    var highlights: Float = 0.0
    var shadows: Float = 0.0
    var warmth: Float = 6500.0 // Default color temperature
    var tint: Float = 0.0
    var blackPoint: Float = 0.0
}
