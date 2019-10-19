//
//  ContentView.swift
//  ModalsAndBindings
//
//  Created by Lahari Ganti on 10/19/19.
//  Copyright © 2019 Lahari Ganti. All rights reserved.
//

import SwiftUI
import UIKit

struct ContentView: View {
	@State var people: [Person] = [
									Person(firstName: "Lahari", lastName: "Ganti", image: UIImage(imageLiteralResourceName: "404"), jobTitle: "Engineer"),
									Person(firstName: "Lazaro", lastName: "Ganti", image: UIImage(imageLiteralResourceName: "404"), jobTitle: "Artist"),
									Person(firstName: "Leh", lastName: "Ganti", image: UIImage(imageLiteralResourceName: "404"), jobTitle: "Film Maker"),
									Person(firstName: "L", lastName: "Ganti", image: UIImage(imageLiteralResourceName: "404"), jobTitle: "Dreamer")]

	@State var isPresentingAddModal: Bool = false

    var body: some View {
		NavigationView {
			List(people) { person in
				PersonRow(person: person) { _ in
					self.people.removeAll { (selectedPerson) -> Bool in
						selectedPerson.id == person.id
					}
				}
			}.navigationBarTitle("People")
				.navigationBarItems(trailing: Button(action: {

					self.isPresentingAddModal = true
				}, label: {
					Text("Add")
						.foregroundColor(.white)
						.fontWeight(.bold)
						.padding(.all, 12)
						.background(Color.green)
						.cornerRadius(3)
				}))
				.sheet(isPresented: $isPresentingAddModal, content: {
					ModalView(isPresented: self.$isPresentingAddModal, didAddPerson: { person in
						self.people.append(person)
					})
				})
		}
    }
}


struct ModalView: View {
	@Binding var isPresented: Bool
	@State var firstName = ""
	@State var lastName = ""
	var didAddPerson: (Person) -> ()

	var body: some View {
		NavigationView {
			VStack {
				HStack(alignment: .center, spacing: 32, content: {
					Text("First Name")
					TextField("First Name", text: $firstName)
				}).padding(12)


				HStack(alignment: .center, spacing: 32, content: {
					Text("Last Name")
					TextField("Last Name", text: $lastName)
				}).padding(12)

				VStack(alignment: .center, spacing: 16, content: {
					Button(action: {
						self.isPresented = false
						self.didAddPerson(Person(firstName: self.firstName, lastName: self.lastName, image: UIImage(), jobTitle: "Youtuber"))
					}, label: {
						Text("Add")
							.foregroundColor(.white)
							.fontWeight(.bold)
							.padding(.all, 12)
							.background(Color.green)
							.cornerRadius(3)
					})

					Button(action: {
						self.isPresented = false
					}, label: {
						Text("Cancel")
							.foregroundColor(.white)
							.fontWeight(.bold)
							.padding(.all, 12)
							.background(Color.red)
							.cornerRadius(3)
					}).frame(minWidth: 0, maxWidth: .infinity)
				}).padding(12)

				Spacer()
			}.padding(.all, 16)
			.navigationBarTitle("Create Person")
		}
	}
}

struct PersonRow: View {
	var person: Person
	var didDelete: (Person) -> ()

	var body: some View {
		HStack {
			Image(uiImage: person.image)
			.resizable()
				.frame(width: 60.0, height: 60.0, alignment: .center)
			.scaledToFill()
			.overlay(RoundedRectangle(cornerRadius: 60)
				.stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round))
				.foregroundColor(.black))
			.cornerRadius(60)

			VStack(alignment: .leading, spacing: 8, content: {
				Text("\(person.firstName) \(person.lastName)").fontWeight(.bold)
				Text(person.jobTitle).fontWeight(.light)
			}).layoutPriority(1)

			Spacer()

			Button(action: {
				self.didDelete(self.person)
			}, label: {
				Text("Delete")
					.foregroundColor(.white)
					.fontWeight(.bold)
					.padding(.all, 12)
					.background(Color.red)
					.cornerRadius(3)
			})
		}.padding(.vertical, 8)
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
