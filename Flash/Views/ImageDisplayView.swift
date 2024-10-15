import SwiftUI

struct ImageDisplayView: View {
    @Binding var selectedImage: UIImage?
    var filterSettings: FilterSettings

    var body: some View {
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
    }
    
    // Use ViewModel's function for applying filters
    func applyFilters(to image: UIImage) -> UIImage {
        return ImageFilteringHelper.applyFilters(to: image, with: filterSettings) ?? image
    }
}
