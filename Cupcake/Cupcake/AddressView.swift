//
//  AddressView.swift
//  Cupcake
//
//  Created by Lahari Ganti on 3/16/20.
//  Copyright © 2020 Lahari Ganti. All rights reserved.
//

import SwiftUI

struct AddressView: View {
  @ObservedObject var order: Order
  
  var body: some View {
    Form {
      Section {
        TextField("Name", text: $order.name)
        TextField("Street Address", text: $order.streetAddress)
        TextField("City", text: $order.city)
        TextField("Zip", text: $order.zip)
      }
      
      Section {
        NavigationLink(destination: CheckoutView(order: order)) {
          Text("Check out order")
        }
      }
      .disabled(!order.hasValidAddress)
    }
  }
}

struct AddressView_Previews: PreviewProvider {
  static var previews: some View {
    AddressView(order: Order())
  }
}
