//
//  DominantColorView.swift
//  Flash
//
//  Created by Shreyas Patil on 10/15/24.
//

import SwiftUI
import UIKit

struct DominantColorView: View {
    @Binding var selectedImage: UIImage? // The selected image
    @Binding var filterSettings: FilterSettings // Bind the filter settings to get the modified image
    @State private var dominantColor: UIColor? = nil

    var body: some View {
        HStack {
            if let dominantColor = dominantColor {
                // Display the detected dominant color as a small color swatch
                Color(dominantColor)
                    .frame(width: 30, height: 30)
                    .cornerRadius(5)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                    .padding(.trailing, 5)

                Text("Dominant Color")
                    .foregroundColor(.black)
            } else {
                Text("No Dominant Color")
                    .foregroundColor(.gray)
            }

            Spacer()

            // Button to detect dominant color
            Button(action: detectDominantColor) {
                Image(systemName: "eyedropper.full")
                    .foregroundColor(.blue)
                    .frame(width: 40, height: 40)
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
        .onAppear {
            detectDominantColor() // Automatically detect dominant color when the view appears
        }
    }

    // Function to detect the dominant color from the filtered image
    private func detectDominantColor() {
        guard let image = selectedImage else { return }
        
        // Apply the current filters to the selected image
        let filteredImage = ImageFilteringHelper.applyFilters(to: image, with: filterSettings)
        
        // Detect the dominant color from the filtered image
        if let filteredImage = filteredImage {
            dominantColor = DominantColorHelper.dominantColor(from: filteredImage)
        }
    }
}
