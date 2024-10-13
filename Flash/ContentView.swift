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
            Picker("Pre-built Filter", selection: $filterSettings.selectedFilter) {
                           Text("None").tag(PrebuiltFilter.none)
                           Text("Vivid").tag(PrebuiltFilter.vivid)
                           Text("Vivid Warm").tag(PrebuiltFilter.vividWarm)
                       }
                       .pickerStyle(SegmentedPickerStyle())
                       .padding()
            Button("Choose Photo") {
                isImagePickerPresented = true
            }
            .padding()
                   // Brightness slider with label on the left
                   HStack {
                       Text("Brightness")
                           .foregroundColor(.black) // Set text color
                       Slider(value: $filterSettings.brightness, in: -1...1, step: 0.1)
                   }.padding()
            HStack{
                Text("Contrast")
            Slider(value: $filterSettings.contrast, in: 0.5...2, step: 0.1)
                
            }.padding()

            HStack{
                Text("Exposure")
            Slider(value: $filterSettings.exposure, in: -2...2, step: 0.1)
                
            }.padding()
            
            HStack{
                Text("Saturation")
            Slider(value: $filterSettings.saturation, in: 0...2, step: 0.1)
                
            }.padding()
            
            HStack{
                Text("Vibrance")
            Slider(value: $filterSettings.vibrance, in: -1...1, step: 0.1)
                
            }.padding()

            HStack{
                Text("Highlights")
            Slider(value: $filterSettings.highlights, in: -1...1, step: 0.1)
                
            }.padding()

            HStack{
                Text("Shadows")
            Slider(value: $filterSettings.shadows, in: -1...1, step: 0.1)
                
            }.padding()

            HStack{
                Text("Warmth")
            Slider(value: $filterSettings.warmth, in: 2000...10000, step: 100)
                
            }.padding()

            HStack{
                Text("Tint")
                Slider(value: $filterSettings.tint, in: -100...100, step: 1)
                
            }.padding()
            
            HStack{
                Text("Black Point")
            Slider(value: $filterSettings.blackPoint, in: 0...0.5, step: 0.01)
                
            }.padding()

            
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
