import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PhotoEditorViewModel() // ViewModel instance

    var body: some View {
        VStack {
            ImageDisplayView(selectedImage: $viewModel.selectedImage, filterSettings: viewModel.filterSettings)

            ChoosePhotoButton(isImagePickerPresented: $viewModel.isImagePickerPresented)

            FilterPickerView(selectedFilter: $viewModel.filterSettings.selectedFilter)

            if let activeAdjustment = viewModel.activeAdjustment {
                FilterControlsView(activeAdjustment: activeAdjustment, filterSettings: $viewModel.filterSettings)
            }

            AdjustmentIconsView(activeAdjustment: $viewModel.activeAdjustment)
                .padding(.top, 10)

            .sheet(isPresented: $viewModel.isImagePickerPresented) {
                ImagePickerView(selectedImage: $viewModel.selectedImage)
            }
        }
        .padding(.horizontal)
    }
}
