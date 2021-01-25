//
//  CoreDataSwiftUIApp.swift
//  CoreDataSwiftUI
//
//  Created by Lahari Ganti on 1/25/21.
//

import SwiftUI

@main
struct CoreDataSwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
