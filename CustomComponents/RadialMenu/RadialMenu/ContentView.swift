//
//  ContentView.swift
//  RadialMenu
//
//  Created by Lahari Ganti on 8/21/20.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding()
      .font(.title)
      .background(Color.green.opacity(configuration.isPressed ? 0.5 : 1))
      .clipShape(Circle())
      .foregroundColor(.white)
  }
}

struct RadialButton {
  var label: String
  var image: Image
  var action: () -> Void
}


struct RadialMenu: View {
  var title: String
  let closedImage: Image
  let openImage: Image
  let buttons: [RadialButton]
  var direction = Angle(degrees: 315)
  var range = Angle(degrees: 90)
  var distance = 100.0
  var animation = Animation.default
  @State private var isExpanded = false
  
  func offset(for index: Int) -> CGSize {
    guard isExpanded else { return .zero }
    
    // θ = n(index) * 2 * pi / N(total items)
    let theta = Double(index) * direction.radians / 2 * -1 / Double(buttons.count)
    
    // offset
    let finalAngle = theta - .pi / 2
    
    // rcosθ, rsinθ
    let finalX = cos(finalAngle) * distance
    let finalY = sin(finalAngle) * distance
    return CGSize(width: finalX, height: finalY)
  }
  
  var body: some View {
    ZStack {
      Button {
        isExpanded.toggle()
      } label: {
        isExpanded ? openImage : closedImage
      }
      .accessibility(label: Text(title))
      
      ForEach(0..<buttons.count, id: \.self) { i in
        Button {
          buttons[i].action()
          isExpanded.toggle()
        } label: {
          buttons[i].image
        }
        .accessibility(hidden: isExpanded == false)
        .accessibility(label: Text(buttons[i].label))
        .offset(offset(for: i))
      }
      .opacity(isExpanded ? 1 : 0)
      .animation(animation)
    }
  }
}



struct ContentView: View {
  var buttons: [RadialButton] {
    [
      RadialButton(label: "Photo", image: Image(systemName: "photo"), action: photoTapped),
      RadialButton(label: "Video", image: Image(systemName: "video"), action: videoTapped),
      RadialButton(label: "Document", image: Image(systemName: "doc"), action: docTapped)
    ]
  }
  var body: some View {
    ZStack(alignment: .bottomTrailing) {
      Color.black.edgesIgnoringSafeArea(.all)
      RadialMenu(title: "Attach",
                 closedImage: Image(systemName: "ellipsis.circle"),
                 openImage: Image(systemName: "multiply.circle"),
                 buttons: buttons,
                 animation: .interactiveSpring(response: 0.3, dampingFraction: 0.5))
        .offset(x: -20, y: -20)
        .buttonStyle(CustomButtonStyle())
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
  
  func photoTapped() {
    print("photo tapped")
  }
  
  func videoTapped() {
    print("video tapped")
  }
  
  func docTapped() {
    print("doc tapped")
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
