//
//  AdjustmentIconsView.swift
//  Flash
//
//  Created by Shreyas Patil on 10/14/24.
//

import SwiftUI

struct AdjustmentIconsView: View {
    @Binding var activeAdjustment: AdjustmentType?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                adjustmentButton(type: .brightness, icon: "sun.max.fill", color: .yellow)
                adjustmentButton(type: .contrast, icon: "circle.lefthalf.fill", color: .gray)
                adjustmentButton(type: .exposure, icon: "sun.haze.fill", color: .orange)
                adjustmentButton(type: .saturation, icon: "eyedropper.full", color: .blue)
                adjustmentButton(type: .vibrance, icon: "paintbrush.fill", color: .pink)
                adjustmentButton(type: .highlights, icon: "sunrise.fill", color: .purple)
                adjustmentButton(type: .shadows, icon: "cloud.fill", color: .black)
                adjustmentButton(type: .warmth, icon: "thermometer", color: .red)
                adjustmentButton(type: .tint, icon: "paintpalette.fill", color: .green)
                adjustmentButton(type: .blackPoint, icon: "moon.fill", color: .black)
                adjustmentButton(type: .gradient, icon: "circle.lefthalf.filled", color: .orange)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 5)
        }
    }

    func adjustmentButton(type: AdjustmentType, icon: String, color: Color) -> some View {
        Button(action: {
            activeAdjustment = type
        }) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
                .frame(width: 50, height: 50)
                .background(Circle().fill(Color.gray.opacity(0.2)))
                .shadow(color: color.opacity(0.4), radius: 5, x: 0, y: 5)
        }
    }
}
