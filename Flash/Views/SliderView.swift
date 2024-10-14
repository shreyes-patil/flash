//
//  SliderView.swift
//  Flash
//
//  Created by Shreyas Patil on 10/13/24.
//

import SwiftUI

struct SliderView: View {
    let title: String
    @Binding var value: Float
    let range: ClosedRange<Float>
    let step: Float

    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.black) // Set text color
            Slider(value: $value, in: range, step: step)
        }
        .padding()
    }
}

