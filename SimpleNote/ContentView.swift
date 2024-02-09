//
//  ContentView.swift
//  SimpleNote
//
//  Created by Yazid Al Ghozali on 07/02/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    
    // Properti wrapper untuk memanggil data yang ada di local storage
    @FetchRequest(
        // Sorting logic berdasarkan timestamp secara ascending
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: false)],
        animation: .default)
    // Fetch Results yang bernama Item (Entity)
    private var items: FetchedResults<Item>
    
    @State private var searchText: String = ""
    
    private var searchItem: [Item] {
        if searchText.isEmpty {
            // Perulangan dalam items map lalu setiap item
            // ditandai dengan $0 dan dilakukan mapping perubahan
            // sesuai dengan bentuk yang diinginkan, dan dalam kasus ini
            // bentuknya adalah array item  [Item]
            return items.compactMap({ $0 })
        } else {
            return items.filter { item in
                (item.title ?? "").lowercased().contains(searchText.lowercased()) ||
                (item.content ?? "").lowercased().contains(searchText.lowercased())
            }
        }
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(searchItem) { item in
                    NavigationLink {
                        NoteView(item: item)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(item.title ?? "")
                                .font(.headline)
                            
                            Text(item.content ?? "")
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("All Notes")
            .searchable(text: $searchText)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.title = "New Note"
            newItem.content = "your new note for this application"

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            // untuk swipe delete based on data
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
