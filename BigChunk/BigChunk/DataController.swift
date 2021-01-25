//
//  DataController.swift
//  BigChunk
//
//  Created by Lahari Ganti on 11/23/20.
//

import CoreData
import SwiftUI

class DataController: ObservableObject {
  let container: NSPersistentCloudKitContainer
  
  init(inMemory: Bool = false) {
    container = NSPersistentCloudKitContainer(name: "Main")
    
    if inMemory {
      container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
    }
    
    container.loadPersistentStores { storeDescription, error in
      if let error = error {
        fatalError(error.localizedDescription)
      }
    }
  }
  
  static var preview: DataController {
    let dataController = DataController(inMemory: true)
    
    do {
      try dataController.createSampleData()
    } catch {
      fatalError(error.localizedDescription)
    }
    
    return Data
  }()
  
  func createSampleData() throws {
    let viewContext = container.viewContext
    
    for i in 1...5 {
      let project = Project(context: viewContext)
      project.title = "Project \(i)"
      project.items = []
      project.creationDate = Date()
      project.closed = Bool.random()
      
      for j in 1...10 {
        let item = Item(context: viewContext)
        item.title = "Project \(i)"
        item.project = project
        item.creationDate = Date()
        item.closed = Bool.random()
        item.priority = Int16.random(in: 1...3)
      }
      
      try viewContext.save()
    }
  }
  
  func save() {
    if container.viewContext.hasChanges {
      try? container.viewContext.save()
    }
  }
  
  func delete(_ object: NSManagedObject) {
    container.viewContext.delete(object)
  }
  
  func deleteAll() {
    let fetchRequest1: NSFetchRequest<NSFetchRequestResult> = Item.fetchRequest()
    let batchDelteRequest1 = NSBatchDeleteRequest(fetchRequest: fetchRequest1)
    _ = try? container.viewContext.execute(batchDelteRequest1)
    
    let fetchRequest2: NSFetchRequest<NSFetchRequestResult> = Project.fetchRequest()
    let batchDelteRequest2 = NSBatchDeleteRequest(fetchRequest: fetchRequest2)
    _ = try? container.viewContext.execute(batchDelteRequest2)
  }
}
