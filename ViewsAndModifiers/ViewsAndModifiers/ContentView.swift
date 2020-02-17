//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Lahari Ganti on 10/27/19.
//  Copyright © 2019 Lahari Ganti. All rights reserved.
//

import SwiftUI

struct GridView<Content: View>: View {
	let rows: Int
	let columns: Int
	let content: (Int, Int) -> Content

	var body: some View {
		VStack {
			ForEach(0 ..< rows) { row in
				HStack {
					ForEach(0 ..< self.columns) { col in
						self.content(row, col)
					}
				}
			}
		}
	}

	init(rows: Int, columns: Int, @ViewBuilder content: @escaping(Int, Int) -> Content ) {
		self.rows = rows
		self.columns = columns
		self.content = content
	}
}

struct ContentView: View {
    var body: some View {
		GridView(rows: 4, columns: 4) { row, col in
			Image(systemName: "\(row * 4 + col).circle")
			Text("R\(row) C\(col)")
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
