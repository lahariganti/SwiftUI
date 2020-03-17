//
//  CheckoutView.swift
//  Cupcake
//
//  Created by Lahari Ganti on 3/16/20.
//  Copyright © 2020 Lahari Ganti. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
  @ObservedObject var order: Order
  @State private var confirmationMessage = ""
  @State private var showingConfirmationMessage = false
  
  var body: some View {
    GeometryReader { geo in
      ScrollView {
        VStack {
          Image("cupcakes")
            .resizable()
            .scaledToFit()
            .frame(width: geo.size.width)
          
          Text("Your total is $\(self.order.cost, specifier: "%.2f" )")
            .font(.title)
          
          Button("Place order") {
            self.placeOrder()
          }
          .padding()
          
        }
      }
    }
    .navigationBarTitle("Checkout", displayMode: .inline)
    .alert(isPresented: $showingConfirmationMessage) {
      Alert(title: Text("Thank you"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
    }
  }
  
  func placeOrder() {
    guard let encoded = try? JSONEncoder().encode(order) else {
      print("Failed to encode order")
      return
    }
    
    guard let url = URL(string: "https://reqres.in/api/cupcakes") else { return }
    
    var request = URLRequest(url: url)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    request.httpBody = encoded
    
    URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data else {
        print(error?.localizedDescription ?? "Unknown error")
        return
      }
      
     if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
          self.confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
          self.showingConfirmationMessage = true
      } else {
          print("Invalid response from server")
      }
    }.resume()
  }
}

struct CheckoutView_Previews: PreviewProvider {
  static var previews: some View {
    CheckoutView(order: Order())
  }
}
