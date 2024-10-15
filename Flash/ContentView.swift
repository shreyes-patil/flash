import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PhotoEditorViewModel() // ViewModel instance

    var body: some View {
        VStack {
            ImageDisplayView(selectedImage: $viewModel.selectedImage, filterSettings: viewModel.filterSettings)

            // Display the compact DominantColorView and pass filter settings to get the filtered dominant color
            if viewModel.selectedImage != nil {
                DominantColorView(selectedImage: $viewModel.selectedImage, filterSettings: $viewModel.filterSettings)
                    .padding(.vertical, 5) // Add some padding between sections
            }

            ChoosePhotoButton(isImagePickerPresented: $viewModel.isImagePickerPresented)

            FilterPickerView(selectedFilter: $viewModel.filterSettings.selectedFilter)

            if let activeAdjustment = viewModel.activeAdjustment {
                FilterControlsView(activeAdjustment: activeAdjustment, filterSettings: $viewModel.filterSettings)
            }

            AdjustmentIconsView(activeAdjustment: $viewModel.activeAdjustment)
                .padding(.top, 5)
        }
        .padding(.horizontal)
        .sheet(isPresented: $viewModel.isImagePickerPresented) {
            ImagePickerView(selectedImage: $viewModel.selectedImage)
        }
    }
}
