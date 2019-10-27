//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Lahari Ganti on 10/26/19.
//  Copyright © 2019 Lahari Ganti. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	@State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Russia", "Poland", "UK", "Spain", "US"].shuffled()
	@State private var correctAnswer = Int.random(in: 0...2)
	@State private var showningScore = false
	@State private var scoreTitle = ""
	@State private var score = 0

    var body: some View {
		ZStack {
			LinearGradient(gradient: Gradient(colors: [.black, .blue]), startPoint: .top, endPoint: .bottom)
				.edgesIgnoringSafeArea(.all)

			VStack(spacing: 30) {
				Spacer()
	
				VStack {
					Text("Tap the flag of")
						.foregroundColor(.white)
					Text(countries[correctAnswer])
						.foregroundColor(.white)
						.font(.largeTitle)
						.fontWeight(.black)
				}

				ForEach(0 ..< 3) { number in
					Button(action: {
						self.flagTapped(number)
					}) {
						Image(self.countries[number])
							.renderingMode(.original)
							.clipShape(Capsule())
							.overlay(Capsule().stroke(Color.black, lineWidth: 1))
							.shadow(color: .gray, radius: 2, x: 0, y: 0)
					}
				}

				Spacer()
			}
		}
		.alert(isPresented: $showningScore) { () -> Alert in
			Alert(title: Text("Score Title"),
				  message: Text("Your score is \(score)"),
				  dismissButton: .default(Text("Continue"), action: {
					self.askQuestion()
				}))
		}
    }

	func flagTapped(_ number: Int) {
		if number == correctAnswer {
			scoreTitle = "Correct"
			score += 1
		} else {
			scoreTitle = "InCorrect"
			score -= 1
		}

		showningScore = true
	}

	func askQuestion() {
		countries.shuffle()
		correctAnswer = Int.random(in: 0...2)
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
