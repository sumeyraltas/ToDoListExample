//
//  ChecklistView.swift
//  ToDoListExample
//
//  Created by Sumeyra Altas on 6.11.2023.
//


import SwiftUI

struct Checklist: Identifiable {
    let id = UUID()
    var title: String
    var isChecked: Bool = false
}

struct ChecklistView: View {
    @State var todos = [
        Checklist(title: "Example")
    ]
    @State private var newTodoTitle: String = ""
    @State private var isAddingNote = false
    var category: ChecklistCategory
    var body: some View {
            List {
                ForEach(todos) { item in
                    HStack {
                        Image(systemName: item.isChecked ? "checkmark.circle" : "circle")
                        Text(item.title)
                        Spacer()
                    }
                    .background(Color(.systemBackground))
                    .onTapGesture {
                        if let matchingIndex = self.todos.firstIndex(where: { $0.id == item.id }) {
                            self.todos[matchingIndex].isChecked.toggle()
                        }
                    }
                }
                .onDelete(perform: deleteListItem)
                .onMove(perform: moveListItem)
            }
            .navigationBarItems(trailing:
                          HStack {
                              Button(action: {
                                  isAddingNote = true
                              }) {
                                  Image(systemName: "plus")
                              }
                              EditButton()
                          }
            )
            .navigationBarTitle(category.title)
        .sheet(isPresented: $isAddingNote) {
            NavigationView {
                Form {
                    Section(header: Text("New To Do")) {
                        TextEditor(text: $newTodoTitle)
                    }
                }
                .navigationBarTitle("Add To Do")
                .navigationBarItems(leading:
                    Button("Cancel") {
                        isAddingNote = false
                    },
                trailing:
                    Button("Save") {
                        addNewItem()
                    }
                )
            }
        }
    }
    
    func deleteListItem(whichElement: IndexSet) {
        todos.remove(atOffsets: whichElement)
    }
    
    func moveListItem(whichElement: IndexSet, destination: Int) {
        todos.move(fromOffsets: whichElement, toOffset: destination)
    }
    
    func addNewItem() {
        if !newTodoTitle.isEmpty {
            let newItem = Checklist(title: newTodoTitle)
            todos.append(newItem)
            newTodoTitle = ""
            isAddingNote = false
        }
    }
}
