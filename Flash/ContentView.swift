import SwiftUI

struct ContentView: View {
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false
    @State private var filterSettings = FilterSettings() // Holds filter settings
    @State private var activeAdjustment: AdjustmentType? // Tracks which adjustment is active

    var body: some View {
        VStack {
            // Main image container with shadow and rounded corners
            if let selectedImage = selectedImage {
                Image(uiImage: applyFilters(to: selectedImage))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 20)) // Rounded corners
                    .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 10) // Soft shadow
                    .padding(.bottom, 20)
            } else {
                Text("Select an Image")
                    .font(.headline)
                    .foregroundColor(.gray)
            }

            // Choose Photo button
            Button(action: {
                isImagePickerPresented = true
            }) {
                Text("Choose Photo")
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .cornerRadius(12)
                    .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 5) // Soft shadow
            }
            .padding(.bottom, 20)

            // Pre-built filter picker
            FilterPickerView(selectedFilter: $filterSettings.selectedFilter)

            // Show the slider for the selected adjustment
            if let activeAdjustment = activeAdjustment {
                VStack {
                    switch activeAdjustment {
                    case .brightness:
                        SliderView(title: "Brightness", value: $filterSettings.brightness, range: -1...1, step: 0.1)
                    case .contrast:
                        SliderView(title: "Contrast", value: $filterSettings.contrast, range: 0.5...2, step: 0.1)
                    case .exposure:
                        SliderView(title: "Exposure", value: $filterSettings.exposure, range: -2...2, step: 0.1)
                    case .saturation:
                        SliderView(title: "Saturation", value: $filterSettings.saturation, range: 0...2, step: 0.1)
                    case .vibrance:
                        SliderView(title: "Vibrance", value: $filterSettings.vibrance, range: -1...1, step: 0.1)
                    case .highlights:
                        SliderView(title: "Highlights", value: $filterSettings.highlights, range: -1...1, step: 0.1)
                    case .shadows:
                        SliderView(title: "Shadows", value: $filterSettings.shadows, range: -1...1, step: 0.1)
                    case .warmth:
                        SliderView(title: "Warmth", value: $filterSettings.warmth, range: 2000...10000, step: 100)
                    case .tint:
                        SliderView(title: "Tint", value: $filterSettings.tint, range: -100...100, step: 1)
                    case .blackPoint:
                        SliderView(title: "Black Point", value: $filterSettings.blackPoint, range: 0...1.0, step: 0.05)
                    }
                }
                .padding()
                .background(Color.white) // Background for the slider area
                .cornerRadius(12)
                .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 5)
            }

            // Scrollable icons for adjustment options with improved background and padding
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
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 5)
            }
            .padding(.top, 10)
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePickerView(selectedImage: $selectedImage)
            }
        }
        .padding(.horizontal)
    }

    // Helper function to create buttons for adjustments
    func adjustmentButton(type: AdjustmentType, icon: String, color: Color) -> some View {
        Button(action: {
            activeAdjustment = type // Set active adjustment when the button is clicked
        }) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
                .frame(width: 50, height: 50)
                .background(Circle().fill(Color.gray.opacity(0.2)))
                .shadow(color: color.opacity(0.4), radius: 5, x: 0, y: 5) // Button shadow
        }
    }

    // Apply the filters using the helper
    func applyFilters(to image: UIImage) -> UIImage {
        return ImageFilteringHelper.applyFilters(to: image, with: filterSettings) ?? image
    }
}
