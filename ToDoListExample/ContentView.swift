//
//  ContentView.swift
//  ToDoListExample
//
//  Created by Sumeyra Altas on 6.11.2023.
//
import SwiftUI
struct ChecklistItem: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var isChecked: Bool = false
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: ChecklistItem, rhs: ChecklistItem) -> Bool {
        return lhs.id == rhs.id
    }
}

struct ChecklistCategory: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var items: [ChecklistItem]
}

struct ContentView: View {
    @State var categories = [
        ChecklistCategory(title: "Checklist 1", items: [
            ChecklistItem(title: "Örnek görev 1"),
            ChecklistItem(title: "Örnek görev 2"),
        ]),
        ChecklistCategory(title: "Checklist 2", items: [
            ChecklistItem(title: "Örnek görev 3"),
            ChecklistItem(title: "Örnek görev 4"),
        ]),
    ]

    @State private var isAddingChecklist = false
    @State private var newChecklist: String = ""
    @State private var itemsToDelete: Set<ChecklistItem> = []
    
    var body: some View {
        
        ZStack {
            VStack {
                NavigationView {
                    List {
                        ForEach(categories) { category in
                            NavigationLink(destination: ChecklistView(category: category)) {
                                Text(category.title)
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .navigationBarTitle("Checklists")
                    .navigationBarItems(leading: EditButton())

                }
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        isAddingChecklist = true
                       
                        
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 48, height: 48)
                            .padding()
                    }
                }
            }
        }.sheet(isPresented: $isAddingChecklist) {
            NavigationView {
                Form {
                    Section(header: Text("New Checklist")) {
                        TextField("Checklist Name", text: $newChecklist)
                    }
                }
                .navigationBarTitle("Add Checklist")
                .navigationBarItems(leading:
                                        Button("Cancel") {
                    isAddingChecklist = false
                },
                                    trailing:
                                        Button("Save") {
                    addNewChecklist()
                }
                )
            }
        }
        }
    
    func addNewChecklist() {
        if !newChecklist.isEmpty {
            let newItem =     ChecklistCategory(title: newChecklist, items: [])
            categories.append(newItem)
            newChecklist = ""
            isAddingChecklist = false
        }
    }
        func deleteItems(whichElement: IndexSet) {
            categories.remove(atOffsets: whichElement)
        }
}

#Preview {
    ContentView()
}

