//
//  ContentView.swift
//  FormBinding
//
//  Created by Lahari Ganti on 10/17/19.
//  Copyright © 2019 Lahari Ganti. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	@State var firstName = ""
	@State var lastName = ""
	@State var users = [String]()

    var body: some View {
		NavigationView {
			VStack {
				VStack {
					VStack {
						Group {
							TextField("First Name", text: $firstName).padding(12)
							}.background(Color.white).clipped().clipShape(RoundedRectangle(cornerRadius: 5))

						Group {
							TextField("Last Name", text: $lastName).padding(12)
						}.background(Color.white).clipShape(RoundedRectangle(cornerRadius: 5))
					}.padding(12)

					HStack {
						Button(action: {
							self.users.append("\(self.firstName) \(self.lastName)")
						}) {
							Group {
								Text("Create User").padding(12).foregroundColor(.white)
							}.background(Color.blue).clipShape(RoundedRectangle(cornerRadius: 5))
						}

						Button(action: {
							self.users.removeAll()
						}) {
							Group {
								Text("Delete User").padding(12).foregroundColor(.white)
							}.background(Color.red).clipShape(RoundedRectangle(cornerRadius: 5))
						}
					}.padding(12)

				}.background(Color.gray)

				List {
					ForEach(users, id: \.self) { user in
						Text(user)
					}
				}
			}.navigationBarTitle(Text("Credit Form"))
			.navigationBarItems(leading: HStack{
				Text("First Name: ")
				Text(firstName).foregroundColor(.red)
				Text("Last Name: ")
				Text(lastName).foregroundColor(.red)
			})
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
