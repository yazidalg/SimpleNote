//
//  NoteView.swift
//  SimpleNote
//
//  Created by Yazid Al Ghozali on 07/02/24.
//

import SwiftUI
import CoreData

struct NoteView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    
    @State var item: Item
    
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var timestamp: Date = Date()
    
    var body: some View {
        VStack {
            HStack(spacing: 6) {
                Text("Last Edited")
                Text(timestamp, style: .date)
            }
            .font(.caption)
            .foregroundColor(.secondary)
            
            TextField("New Note", text: $title)
                .font(.title)
            
            TextEditor(text: $content)
        }
        // Ketika halaman ini muncul maka akan di execute bagian ini
        .onAppear {
            title = item.title ?? ""
            content = item.content ?? ""
            timestamp = item.timestamp ?? Date()
        }
        // Ketika tampilannya tidak terbuka / terpencet back maka akan tersimpan
        // Kebalikan dari .onAppear()
        .onDisappear {
            saveUpdate()
        }
    }
    
    // Save update 
    private func saveUpdate() {
        item.title = title
        item.timestamp = Date()
        item.content = content
        
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
