//
//  FilterControlsView.swift
//  Flash
//
//  Created by Shreyas Patil on 10/14/24.
//

import SwiftUICore

struct FilterControlsView: View {
    var activeAdjustment: AdjustmentType
    @Binding var filterSettings: FilterSettings

    var body: some View {
        VStack {
            switch activeAdjustment {
            case .brightness:
                CustomSliderView(value: $filterSettings.brightness, range: -0.25...0.25, step: 0.05, title: "Brightness", displayRange: -100...100)
            case .contrast:
                CustomSliderView(value: $filterSettings.contrast, range: 0.75...1.5, step: 0.05, title: "Contrast", displayRange: -100...100)
            case .exposure:
                CustomSliderView(value: $filterSettings.exposure, range: -2...2, step: 0.1, title: "Exposure", displayRange: -100...100)
            case .saturation:
                CustomSliderView(value: $filterSettings.saturation, range: 0...2, step: 0.1, title: "Saturation", displayRange: -100...100)
            case .vibrance:
                CustomSliderView(value: $filterSettings.vibrance, range: -1...1, step: 0.1, title: "Vibrance", displayRange: -100...100)
            case .highlights:
                CustomSliderView(value: $filterSettings.highlights, range: -1...1, step: 0.1, title: "Highlights", displayRange: -100...100)
            case .shadows:
                CustomSliderView(value: $filterSettings.shadows, range: -1...1, step: 0.1, title: "Shadows", displayRange: -100...100)
            case .warmth:
                CustomSliderView(value: $filterSettings.warmth, range: 2000...10000, step: 100, title: "Warmth", displayRange: -100...100)
            case .tint:
                CustomSliderView(value: $filterSettings.tint, range: -100...100, step: 1, title: "Tint", displayRange: -100...100)
            case .blackPoint:
                CustomSliderView(value: $filterSettings.blackPoint, range: 0...1.0, step: 0.05, title: "Black Point", displayRange: 0...100)
            case .gradient:
                CustomSliderView(value: $filterSettings.gradientIntensity, range: 0...1.0, step: 0.05, title: "Vignette", displayRange: 0...100)


            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 5)
    }
}
