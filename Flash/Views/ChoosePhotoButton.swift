//
//  ChoosePhotoButton.swift
//  Flash
//
//  Created by Shreyas Patil on 10/14/24.
//

import SwiftUI

struct ChoosePhotoButton: View {
    @Binding var isImagePickerPresented: Bool

    var body: some View {
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
    }
}
