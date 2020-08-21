//
//  ContentView.swift
//  RemoteImage
//
//  Created by Lahari Ganti on 8/21/20.
//

import SwiftUI

struct RemoteImage: View {
  private enum LoadState {
    case loading, success, failure
  }
  
  private class Loader: ObservableObject {
    var data = Data()
    var state = LoadState.loading
    
    init(url: String) {
      guard let parsedURL = URL(string: url) else {
        fatalError("Invalild URL: \(url)")
      }
      
      URLSession.shared.dataTask(with: parsedURL) { data, response, error in
        if let data = data, data.count > 0 {
          self.data = data
          self.state = .success
        } else {
          self.state = .failure
        }
        
        DispatchQueue.main.async {
          self.objectWillChange.send()
        }
      }.resume()
    }
  }
  
  @StateObject private var loader: Loader
  var loading: Image
  var failure: Image
  
  var body: some View {
    selectImage()
      .resizable()
  }
  
  init(url: String, loading: Image = Image(systemName: "photo"), failure: Image = Image(systemName: "multiply.circle")) {
    _loader = StateObject(wrappedValue: Loader(url: url))
    self.loading = loading
    self.failure = failure
  }
  
  private func selectImage() -> Image {
    switch loader.state {
    case .loading:
      return loading
    case .failure:
      return failure
    default:
      if let image = UIImage(data: loader.data) {
        return Image(uiImage: image)
      } else {
        return failure
      }
    }
  }
}

struct ContentView: View {
  var body: some View {
    RemoteImage(url: "https://images.unsplash.com/photo-1456613820599-bfe244172af5?ixlib=rb-1.2.1&auto=format&fit=crop&w=1953&q=80")
      .aspectRatio(contentMode: .fit)
      .frame(width: 200)
      .cornerRadius(10)
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
