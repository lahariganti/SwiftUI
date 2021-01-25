//
//  ContentView.swift
//  ThinkingInSwiftUI
//
//  Created by Lahari Ganti on 10/17/20.
//

import SwiftUI

struct ContentView: View {
  @State private var isLinkActive = false
  var body: some View {
    NavigationView {
      List {
        ZStack {
          NavigationLink(destination: Text("")) {
            Text("Hello1")
          }
          .buttonStyle(PlainButtonStyle())
        }
        
        
      }
    }
  }
}

extension View {
  func debug() -> Self {
    print(Mirror(reflecting: self).subjectType)
    return self
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
