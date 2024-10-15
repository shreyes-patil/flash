//
//  PhotoEditorViewModel.swift
//  Flash
//
//  Created by Shreyas Patil on 10/14/24.
//
import SwiftUI
import UIKit

class PhotoEditorViewModel: ObservableObject {
    @Published var selectedImage: UIImage? = nil
    @Published var isImagePickerPresented: Bool = false
    @Published var filterSettings = FilterSettings() // Holds filter settings
    @Published var activeAdjustment: AdjustmentType? = nil // Tracks which adjustment is active
    @Published var saveStatusMessage: String? = nil // Holds status message for saving
    @Published var dominantColor: UIColor? = nil
    
    // Function to apply filters to the selected image
    func applyFilters(to image: UIImage) -> UIImage {
        return ImageFilteringHelper.applyFilters(to: image, with: filterSettings) ?? image
    }

    // Function to reset all adjustments
    func resetFilters() {
        filterSettings = FilterSettings() // Resets to default settings
        activeAdjustment = nil
    }

    // Function to save edited image to the photo library
    func saveEditedImage() {
        guard let image = selectedImage else { return }
        let editedImage = applyFilters(to: image) // Apply filters before saving

        UIImageWriteToSavedPhotosAlbum(editedImage, nil, #selector(saveImageCompletion(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    // Function to detect dominant color
        func detectDominantColor() {
            guard let image = selectedImage else { return }
            dominantColor = DominantColorHelper.dominantColor(from: image)
        }

    // Completion handler for saving image
    @objc private func saveImageCompletion(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // Handle the error
            saveStatusMessage = "Save failed: \(error.localizedDescription)"
        } else {
            // Successfully saved
            saveStatusMessage = "Image saved successfully to Photos"
        }
    }
}
