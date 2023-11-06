//
//  ToggleButton.swift
//  ToDoListExample
//
//  Created by Sumeyra Altas on 6.11.2023.
//

import SwiftUI
struct ToggleButton: View {
    @Binding var isOn: Bool

    var body: some View {
        Button(action: { isOn.toggle() }) {
            Image(systemName: isOn ? "checkmark.circle.fill" : "circle")
        }
    }
}
