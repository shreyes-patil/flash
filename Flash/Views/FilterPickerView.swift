//
//  FilterPickerView.swift
//  Flash
//
//  Created by Shreyas Patil on 10/13/24.
//

import SwiftUI

struct FilterPickerView: View {
    @Binding var selectedFilter: PrebuiltFilter

    var body: some View {
        Picker("Pre-built Filter", selection: $selectedFilter) {
            Text("None").tag(PrebuiltFilter.none)
            Text("Vivid").tag(PrebuiltFilter.vivid)
            Text("Vivid Warm").tag(PrebuiltFilter.vividWarm)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
}
