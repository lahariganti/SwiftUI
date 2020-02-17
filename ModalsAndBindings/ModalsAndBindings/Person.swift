//
//  Person.swift
//  ModalsAndBindings
//
//  Created by Lahari Ganti on 10/19/19.
//  Copyright © 2019 Lahari Ganti. All rights reserved.
//

import UIKit

struct Person: Identifiable {
	let id = UUID()
	let firstName: String
	let lastName: String
	let image: UIImage
	let jobTitle: String
}
