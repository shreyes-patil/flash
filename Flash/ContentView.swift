import SwiftUI

struct ContentView: View {
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false
    @State private var filterSettings = FilterSettings() // Holds filter settings

    var body: some View {
        VStack {
                   // Display the filtered image if there is one
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

                   // Brightness slider with label on the left
                   HStack {
                       Text("Brightness")
                           .foregroundColor(.black) // Set text color
                       Slider(value: $filterSettings.brightness, in: -1...1, step: 0.1)
                   }.padding()

            Slider(value: $filterSettings.contrast, in: 0.5...2, step: 0.1) {
                Text("Contrast")
            }.padding()

            Slider(value: $filterSettings.exposure, in: -2...2, step: 0.1) {
                Text("Exposure")
            }.padding()
            
            Slider(value: $filterSettings.saturation, in: 0...2, step: 0.1) {
                Text("Saturation")
            }.padding()
            
            Slider(value: $filterSettings.vibrance, in: -1...1, step: 0.1) {
                Text("Vibrance")
            }.padding()

            Slider(value: $filterSettings.highlights, in: -1...1, step: 0.1) {
                Text("Highlights")
            }.padding()

            Slider(value: $filterSettings.shadows, in: -1...1, step: 0.1) {
                Text("Shadows")
            }.padding()

            Slider(value: $filterSettings.warmth, in: 2000...10000, step: 100) {
                Text("Warmth")
            }.padding()

            Slider(value: $filterSettings.tint, in: -100...100, step: 1) {
                Text("Tint")
            }.padding()
            
            Slider(value: $filterSettings.blackPoint, in: 0...0.5, step: 0.01) {
                Text("Black Point")
            }.padding()

            Button("Choose Photo") {
                isImagePickerPresented = true
            }
            .padding()
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePickerView(selectedImage: $selectedImage)
            }
        }
    }
    
    // Apply the filters using the helper
    func applyFilters(to image: UIImage) -> UIImage {
        return ImageFilteringHelper.applyFilters(to: image, with: filterSettings) ?? image
    }
}
