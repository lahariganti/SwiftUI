//
//  Order+CoreDataProperties.swift
//  CoreDataSwiftUI
//
//  Created by Lahari Ganti on 1/25/21.
//
//

import Foundation
import CoreData

extension Order {
  @nonobjc public class func fetchRequest() -> NSFetchRequest<Order> {
    return NSFetchRequest<Order>(entityName: "Order")
  }
  
  @NSManaged public var id: UUID
  @NSManaged public var numberOfSlices: Int16
  @NSManaged public var pizzaType: String
  @NSManaged public var tableNumber: String
}

extension Order : Identifiable {
  @NSManaged public var status: String
  
  var orderStatus: Status {
    get {
      Status(rawValue: status) ?? .pending
    }
    
    set {
      status = newValue.rawValue
    }
  }
}

enum Status: String {
  case pending = "Pending"
  case preparing = "Preparing"
  case completed = "Completed"
}
