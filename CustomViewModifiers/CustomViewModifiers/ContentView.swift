//
//  ContentView.swift
//  CustomViewModifiers
//
//  Created by Lahari Ganti on 10/20/19.
//  Copyright © 2019 Lahari Ganti. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
		VStack {
			HStack {
				Button(action: {

				}, label: {
					Text("Continue")
					.modifier(CustomModifier())
				})

				Button(action: {

				}, label: {
					Text("More")
						.modifier(CustomModifier(backgroundColor: .green))
				})

				Button(action: {

				}, label: {
					Text("Cancel")
						.modifier(CustomModifier(backgroundColor: .red))
				})
			}
		}
    }
}

struct CustomModifier: ViewModifier {
	@State var backgroundColor = Color.blue

	func body(content: Content) -> some View {
		return content
			.foregroundColor(.white)
			.font(.system(size: 16))
			.padding(.horizontal, 14)
			.padding(.vertical, 16)
			.background(backgroundColor)
			.overlay(RoundedRectangle(cornerRadius: 3)
				.strokeBorder(style: StrokeStyle(lineWidth: 1))
				.foregroundColor(Color(.sRGB, red: 0.1, green: 0.1, blue: 0.1, opacity: 1)))
			.cornerRadius(4)
				.shadow(color: .init(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.5), radius: 5, x: 0, y: 0)
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
