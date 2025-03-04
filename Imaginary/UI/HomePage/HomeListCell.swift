//
//
//  HomeListCell.swift
//  Imaginary
//
//  Created by Haipp on 04.03.25.
//  
	
import SwiftUI


struct HomeListCell: View {
	
	let title: String
	let description: String
	let imageURL: URL
	let endDate: Date
	let localizedPrice: String
	
	
	var body: some View {
		HStack(alignment: .top) {
			AsyncImage(
				url: imageURL,
				content: { image in
					image
						.resizable()
						.scaledToFit()
						.frame(width: 100, height: 50)
				},
				placeholder: {
					Rectangle()
						.foregroundStyle(.gray)
						.frame(width: 100, height: 50)
				}
			)
			
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
