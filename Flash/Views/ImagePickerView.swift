import SwiftUI
import UIKit

// This struct bridges UIImagePickerController with SwiftUI
struct ImagePickerView: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage? // The image selected by the user
    @Environment(\.presentationMode) var presentationMode // To dismiss the picker

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator // Set the delegate to handle image picking
        picker.sourceType = .photoLibrary // Open the photo library
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // No need to update the UI view controller for this simple example
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self) // Create a coordinator to handle delegate callbacks
    }

    // Coordinator class to handle delegate methods
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePickerView

        init(_ parent: ImagePickerView) {
            self.parent = parent
        }

        // Called when the user selects an image
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image // Assign the selected image
            }
            parent.presentationMode.wrappedValue.dismiss() // Dismiss the picker
        }

        // Called when the user cancels the picker
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss() // Dismiss the picker
        }
    }
}
