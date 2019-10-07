//
//  ContentView.swift
//  ComplexLayout
//
//  Created by Lahari Ganti on 10/6/19.
//  Copyright © 2019 Lahari Ganti. All rights reserved.
//

import SwiftUI

struct Post: Identifiable {
	var id: Int
	let username, text, imageName: String
}


struct ContentView: View {
	init() {
		UITableView.appearance().separatorColor = .clear
	}

	let posts: [Post] = [.init(id: 0, username: "misa", text: "misa text misa text misa text misa text", imageName: "burger"),
						 .init(id: 1, username: "lisa", text: "lisa text misa text misa text misa text", imageName: "post_puppy")]

    var body: some View {
		NavigationView {
			List {
				ScrollView(.horizontal, showsIndicators: false) {
					VStack (alignment: .leading) {
						Text("Trending")
						HStack {
//							use for each
							NavigationLink(destination: DetailView()) {
								GroupedView()
							}

							NavigationLink(destination: DetailView()) {
								GroupedView()
							}

							NavigationLink(destination: DetailView()) {
								GroupedView()
							}
						}
					}
				}.frame(height: 200)

				ForEach(posts, id: \.id) { post in
					PostView(post: post)
				}
			}.navigationBarTitle(Text("Groups"))
		}
    }
}


struct DetailView: View {
	var body: some View {
		Text("Detail View")
	}
}

struct GroupedView: View {
	var body: some View {
		VStack(alignment: .leading) {
			Image("hike").renderingMode(.original).cornerRadius(8)
			Text("Group 1 yad ayada adasd asdas").font(.subheadline).lineLimit(nil).padding(.leading, 0)
		}.frame(width: 110, height: 170)
	}
}

struct PostView: View {
	let post: Post

	var body: some View {
		VStack (alignment: .leading, spacing: 16) {
			HStack {
				Image(post.imageName)
					.resizable()
					.clipShape(Circle())
					.frame(width: 50, height: 50)
					.clipped()
				VStack (alignment: .leading, spacing: 4) {
					Text(post.username).font(.headline)
					Text("Post time").font(.subheadline)
				}.padding(.leading, 10)
			}.padding(.leading, 16).padding(.top, 16)
			Text(post.text).lineLimit(nil).padding(.leading, 16).padding(.trailing, 16)
			Image(post.imageName).frame(height: 300).clipped().scaledToFill()
		}.padding(.leading, -20)
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
