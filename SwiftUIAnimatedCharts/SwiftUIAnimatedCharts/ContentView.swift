//
//  ContentView.swift
//  SwiftUIAnimatedCharts
//
//  Created by Lahari Ganti on 10/21/19.
//  Copyright © 2019 Lahari Ganti. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	@State var pickerSelectedItem = 0
	@State var dataPoints: [[CGFloat]] = [[50, 100, 150], [150, 20, 10], [120, 10, 150]]

    var body: some View {
		ZStack {
			
			Color("appBackground").edgesIgnoringSafeArea(.all)

			VStack {
				Text("Calorie Intake")
				.fontWeight(.heavy)
				.font(.system(size: 34))

				Picker(selection: $pickerSelectedItem, label: Text("")) {
					Text("Weekday").tag(0)
					Text("Afternoon").tag(1)
					Text("Evening").tag(2)
				}.pickerStyle(SegmentedPickerStyle())
					.padding(.horizontal, 24)

				HStack(spacing: 16) {
					BarView(value: dataPoints[pickerSelectedItem][0])
					BarView(value: dataPoints[pickerSelectedItem][1])
					BarView(value: dataPoints[pickerSelectedItem][2])
				}.padding(.top, 8)
					.animation(.default)
			}
		}
    }
}

struct BarView: View {
	var value: CGFloat = 0

	var body: some View {
		VStack {
			ZStack(alignment: .bottom) {
				Capsule().frame(width: 30, height: 200)
					.foregroundColor(Color(#colorLiteral(red: 0.4535143971, green: 0.9497105479, blue: 0.5234261155, alpha: 1)))
				Capsule().frame(width: 30, height: value)
					.foregroundColor(.white)
			}.padding(.top, 16)

			Text("D")
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
