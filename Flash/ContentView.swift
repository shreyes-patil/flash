import SwiftUI

struct ContentView: View {
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false
    @State private var filterSettings = FilterSettings() // Holds filter settings
    @State private var activeAdjustment: AdjustmentType? // Tracks which adjustment is active

    var body: some View {
        VStack {
            if let selectedImage = selectedImage {
                Image(uiImage: applyFilters(to: selectedImage))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
            } else {
                Text("Select an Image")
                    .font(.headline)
                    .foregroundColor(.black)
            }

            Button("Choose Photo") {
                isImagePickerPresented = true
            }
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
                        SliderView(title: "Black Point", value: $filterSettings.blackPoint, range: 0...0.5, step: 0.001)
                    }
                }
                .padding()
            }

            // Scrollable icons for adjustment options
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    adjustmentButton(type: .brightness, icon: "sun.max")
                    adjustmentButton(type: .contrast, icon: "circle.lefthalf.fill")
                    adjustmentButton(type: .exposure, icon: "sun.haze")
                    adjustmentButton(type: .saturation, icon: "eyedropper")
                    adjustmentButton(type: .vibrance, icon: "paintbrush")
                    adjustmentButton(type: .highlights, icon: "sunrise")
                    adjustmentButton(type: .shadows, icon: "cloud.fill")
                    adjustmentButton(type: .warmth, icon: "thermometer")
                    adjustmentButton(type: .tint, icon: "paintpalette")
                    adjustmentButton(type: .blackPoint, icon: "moon.fill")
                }
                .padding()
            }
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePickerView(selectedImage: $selectedImage)
            }
        }
    }

    // Helper function to create buttons for adjustments
    func adjustmentButton(type: AdjustmentType, icon: String) -> some View {
        Button(action: {
            activeAdjustment = type // Set active adjustment when the button is clicked
        }) {
            Image(systemName: icon)
                .font(.title2)
                .padding()
                .background(Circle().fill(Color.gray.opacity(0.2)))
        }
    }

    // Apply the filters using the helper
    func applyFilters(to image: UIImage) -> UIImage {
        return ImageFilteringHelper.applyFilters(to: image, with: filterSettings) ?? image
    }
}
