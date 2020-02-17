//
//  ContentView.swift
//  SwiftUIDynamicLists
//
//  Created by Lahari Ganti on 10/6/19.
//  Copyright © 2019 Lahari Ganti. All rights reserved.
//

import SwiftUI
import Foundation

struct User: Hashable {
	var id: Int
	let username, message, imageName: String
}

struct ContentView: View {
	let users: [User] = [.init(id: 0, username: "Lain", message: "Lain Nakamura 404 to 200", imageName: "404"), .init(id: 1, username: "Misa", message: "Lain's sister Lain's sister Lain's sister Lain's sister Lain's sister Lain's sister Lain's sister Lain's sister Lain's sister Lain's sister Lain's sister Lain's sister", imageName: "404")]
    var body: some View {
		NavigationView {
			List {
				Text("Users").font(.title).padding(.leading, 6)
				ForEach(users, id: \.self) { user in
					UserRow(user: user)
				}
			}.navigationBarTitle(Text("Dynamic List"))
		}
    }
}

struct UserRow: View {
	let user: User
	var body: some View {
		HStack {
			Image(user.imageName)
				.resizable()
				.clipShape(Circle())
				.frame(width: 60, height: 60).clipped()
			VStack (alignment: .leading) {
				Text(user.username).font(.headline)
				Text(user.message).font(.subheadline).lineLimit(nil)
			}.padding(.leading, 8)
		}.padding(.init(top: 12, leading: 0, bottom: 12, trailing: 0))
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
