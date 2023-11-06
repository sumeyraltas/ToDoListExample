//
//  ContentView.swift
//  ToDoListExample
//
//  Created by Sumeyra Altas on 6.11.2023.
//
import SwiftUI

struct TodoItem: Identifiable {
    let id = UUID()
    var title: String
    var isChecked: Bool = false
}

struct ContentView: View {
    @State var todos = [
        TodoItem(title: "Örnek görev 1"),
        TodoItem(title: "Örnek görev 2"),
    ]
    @State private var newTodoTitle: String = ""
    @State private var isAddingNote = false
    
    var body: some View {
        NavigationView {
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
            .navigationBarItems(leading: EditButton(), trailing:
                Button(action: {
                    isAddingNote = true
                }) {
                    Image(systemName: "plus")
                }
            )
            .navigationBarTitle("Checklist")
        }
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
            let newItem = TodoItem(title: newTodoTitle)
            todos.append(newItem)
            newTodoTitle = ""
            isAddingNote = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

#Preview {
    ContentView()
}
