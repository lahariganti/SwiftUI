//
//  ContentView.swift
//  PublishedObserved
//
//  Created by Lahari Ganti on 10/19/19.
//  Copyright © 2019 Lahari Ganti. All rights reserved.
//

import SwiftUI

let api = "https://api.letsbuildthatapp.com/static/courses.json"

struct Course: Identifiable, Decodable {
	let id = UUID()
	let name: String
}


class CoursesViewModel: ObservableObject {
	@Published var courses: [Course] = [Course(name: "fsdfdf"),
									   Course(name: "dadasd"),
									   Course(name: "vvvv")]

	func fetchCourses() {
		guard let url = URL(string: api) else { return }
		URLSession.shared.dataTask(with: url) { (data, response, error) in
			if let data = data {
				if let courses = try? JSONDecoder().decode([Course].self, from: data) {
					DispatchQueue.main.async {
						self.courses = courses
					}
				}
			}
		}.resume()
	}
}

struct ContentView: View {
	@ObservedObject var coursesVM = CoursesViewModel()

    var body: some View {
		NavigationView {
			ScrollView {
				ForEach(coursesVM.courses) { course in
					Text(course.name)
				}
			}.navigationBarTitle(Text("Courses"))
				.navigationBarItems(trailing: Button(action: {
					self.coursesVM.fetchCourses()
				}, label: {
					Text("Fetch Courses")
				}))
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
