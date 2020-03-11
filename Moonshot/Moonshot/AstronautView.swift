//
//  AstronautView.swift
//  Moonshot
//
//  Created by Lahari Ganti on 3/11/20.
//  Copyright © 2020 Lahari Ganti. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
  let astronaut: Astronaut
  
  var body: some View {
    GeometryReader { geometry in
      ScrollView(.vertical) {
        VStack {
          Image(self.astronaut.id)
          .resizable()
          .scaledToFit()
          .frame(width: geometry.size.width)
          
          Text(self.astronaut.description)
          .padding()
        }
      }
    }
    .navigationBarTitle(Text(self.astronaut.name), displayMode: .inline)
  }
}

struct AstronautView_Previews: PreviewProvider {
  static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
  static var previews: some View {
    AstronautView(astronaut: astronauts[0])
  }
}
