//
//  AddTaskView.swift
//  ToDoListExample
//
//  Created by Sumeyra Altas on 6.11.2023.
//

import SwiftUI
struct AddTaskView: View {
    @Binding var tasks: [String]
    @Binding var newTask: String
    @Binding var isAddingTask: Bool

    var body: some View {
        NavigationView {
            VStack {
                TextField("Yeni görev ekle", text: $newTask)
                    .padding()
                Button("Ekle") {
                    if !newTask.isEmpty {
                        tasks.append(newTask)
                        newTask = ""
                        isAddingTask = false
                    }
                }
                .padding()
            }
            .navigationBarItems(leading:
                Button("İptal") {
                    isAddingTask = false
                }
            )
        }
    }
}


#Preview {
    ContentView()
}
