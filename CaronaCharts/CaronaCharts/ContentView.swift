//
//  ContentView.swift
//  CaronaCharts
//
//  Created by Lahari Ganti on 3/25/20.
//  Copyright © 2020 Lahari Ganti. All rights reserved.
//

import SwiftUI

struct TimeSeries: Decodable {
  let US: [DayData]
}

struct DayData: Decodable, Hashable {
  let date: String
  let confirmed, deaths, recovered: Int
}

class ChartViewModel: ObservableObject {
  @Published var dataSet = [DayData]()
  var max = 0
  
  init() {
    let urlString = "https://pomber.github.io/covid19/timeseries.json"
    guard let url = URL(string: urlString) else {
      fatalError("Could not convert to URL")
    }
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      guard let data = data else { return }
      do {
        let timeSeries = try JSONDecoder().decode(TimeSeries.self, from: data)
        timeSeries.US.forEach { (dayData) in
          DispatchQueue.main.async {
            self.dataSet = timeSeries.US.filter { $0.deaths > 0}
            self.max = self.dataSet.max(by: { (dayData1, dayData2) -> Bool in
              return dayData2.deaths > dayData1.deaths
            })?.deaths ?? 0
          }
        }
      } catch {
        fatalError("Decoding failed")
      }
    }.resume()
  }
}



struct ContentView: View {
  @ObservedObject var viewModel = ChartViewModel()
  
  var body: some View {
    VStack {
      Text("Carona Deaths")
        .font(.system(.title))
      Text("Total Deaths: \(viewModel.max)")
      if !viewModel.dataSet.isEmpty {
        ScrollView(.horizontal) {
          HStack(alignment: .bottom, spacing: 4) {
            ForEach(viewModel.dataSet, id: \.self) { day in
              HStack {
                Spacer()
              }
               .frame(width: 8, height: (CGFloat(day.deaths) / CGFloat(self.viewModel.max)) * 200)
              .background(Color.red)
            }
          }
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
