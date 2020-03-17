//
//  ContentView.swift
//  Cupcake
//
//  Created by Lahari Ganti on 3/13/20.
//  Copyright © 2020 Lahari Ganti. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @ObservedObject var order = Order()
  
  var body: some View {
    NavigationView {
      Form {
        Section {
          Picker("Cake type", selection: $order.type) {
            ForEach(0..<Order.types.count, id: \.self) {
              Text("\(Order.types[$0])")
            }
          }
          
          Stepper(value: $order.quantity, in: 3...20) {
            Text("Number of cakes: \(order.quantity)")
          }
        }
        
        Section {
          Toggle(isOn: $order.specialRequestEnabled.animation()) {
            Text("Any special request")
          }
          
          if order.specialRequestEnabled {
            Toggle(isOn: $order.extraFrosting) {
              Text("Add extra frosting")
            }
            
            Toggle(isOn: $order.addSprinkles) {
              Text("Add sprinkles")
            }
          }
        }
        
        Section {
          NavigationLink(destination: AddressView(order: order)) {
            Text("Delivery details")
          }
        }
      }
      .navigationBarTitle("Cupcake")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
