//
//  ContentView.swift
//  iExpense
//
//  Created by Lahari Ganti on 3/6/20.
//  Copyright © 2020 Lahari Ganti. All rights reserved.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
  let id = UUID()
  let name: String
  let type: String
  let amount: Int
}

class Expenses: ObservableObject {
  @Published var items = [ExpenseItem]() {
    didSet {
      let encoder = JSONEncoder()
       
      if let encoded = try? encoder.encode(items) {
        UserDefaults.standard.set(encoded, forKey: "items")
      }
    }
  }
  
  init() {
    if let items = UserDefaults.standard.data(forKey: "items") {
      let decoder = JSONDecoder()
      if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
        self.items = decoded
        return
      }
      
      self.items = []
    }
  }
}

struct ContentView: View {
  @ObservedObject var expenses = Expenses()
  @State private var showingAddExpense = false
  
  var body: some View {
    NavigationView {
      List {
        ForEach(expenses.items) { item in
          HStack {
            VStack(alignment: .leading) {
              Text(item.name)
                .font(.headline)
              Text(item.type)
            }
            Spacer()
            Text("$\(item.amount)")
          }
        }.onDelete(perform: removeItems)
      }
      .navigationBarTitle("iExpense")
      .navigationBarItems(trailing:
        Button(action: {
          self.showingAddExpense.toggle()
        }) {
          Image(systemName: "plus")
        }
      )
        .sheet(isPresented: $showingAddExpense) {
          SheetView(expenses: self.expenses)
      }
    }
  }
  
  func removeItems(at offsets: IndexSet) {
    self.expenses.items.remove(atOffsets: offsets)
  }
}

struct SheetView: View {
  @Environment(\.presentationMode) var presentationMode
  @ObservedObject var expenses: Expenses
  @State private var name = ""
  @State private var type = ""
  @State private var amount = ""
  static let types = ["Business", "Personal"]
  
  var body: some View {
    NavigationView {
      Form {
        TextField("Name", text: $name)
        
        Picker("Type", selection: $type) {
          ForEach(Self.types, id: \.self) {
            Text($0)
          }
        }
        
        TextField("Amount", text: $amount)
          .keyboardType(.numberPad)
      }
    .navigationBarTitle("Add Expenses")
    .navigationBarItems(trailing:
      Button("Save") {
        if let actualAmount = Int(self.amount) {
          let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
          self.expenses.items.append(item)
        }
        
        self.presentationMode.wrappedValue.dismiss()
      })
    }
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
