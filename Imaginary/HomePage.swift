//
//
//  HomePage.swift
//  Imaginary
//
//  Created by Haipp on 04.03.25.
//

import SwiftUI

struct HomePage: View {
	
	var body: some View {
		NavigationStack {
			List {
				ForEach(1 ... 100, id: \.self) { i in
					Button(action: {}) {
						HomeListCell(
							title: "Titel",
							description: "Short Description",
							imageURL: URL.placeholderImageURL,
							endDate: Date(),
							localizedPrice: "XX€"
						)
					}
				}
			}
			.listStyle(.plain)
			.navigationTitle("Imaginary")
			.navigationBarTitleDisplayMode(.inline)
		}
	}
}


struct HomeListCell: View {
	
	let title: String
	let description: String
	let imageURL: URL
	let endDate: Date
	let localizedPrice: String
	
	
	var body: some View {
		HStack(alignment: .top) {
			Rectangle()
				.frame(width: 70, height: 50)
				.layoutPriority(1)
			
			VStack(alignment: .leading) {
				Text(title)
					.fontWeight(.bold)
				
				Text(description)
				
				Text("Available Till", comment: "HomeListCell")
			}
			.frame(maxWidth: .infinity, alignment: .leading)
			.layoutPriority(0)
			
			HStack {
				Text("PRICE:", comment: "Price - HomeListCell")
			}
			.layoutPriority(1)
			Text(localizedPrice)
		}
		.foregroundStyle(.black)
	}
	
}


#Preview {
	HomePage()
}
