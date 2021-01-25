//
//  BigChunkApp.swift
//  BigChunk
//
//  Created by Lahari Ganti on 11/23/20.
//

import SwiftUI

@main
struct BigChunkApp: App {
  @StateObject var dataController: DataController
  
  init() {
    let dataController = DataController()
    _dataController = StateObject(wrappedValue: dataController)
  }
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(\.managedObjectContext, dataController.container.viewContext)
        .environmentObject(dataController)
    }
  }
}
