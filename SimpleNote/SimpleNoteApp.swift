//
//  SimpleNoteApp.swift
//  SimpleNote
//
//  Created by Yazid Al Ghozali on 07/02/24.
//

import SwiftUI

@main
struct SimpleNoteApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
