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
	let startDate: Date
	let endDate: Date
	let localizedPrice: String
	
	
	var availableTillDateString: String {
		return endDate.formatted(date: .numeric, time: .shortened)
	}
	
	
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
				
				HStack {
					Text(title)
						.frame(maxWidth: .infinity, alignment: .leading)
						.lineLimit(1)
					
					HStack(spacing: 2) {
						Text("PRICE:", comment: "Price - HomeListCell")
							.lineLimit(1)
							
						Text(localizedPrice)
					}
					.layoutPriority(1)
				}
				.fontWeight(.bold)
				
				Text(description)
					.frame(maxWidth: .infinity, alignment: .leading)
				
				Text("Available Till: \(availableTillDateString)", comment: "Text - HomeListCell")
					.frame(maxWidth: .infinity, alignment: .leading)
					.opacity(0.85)
			}
			.frame(maxWidth: .infinity, alignment: .leading)
			.layoutPriority(0)
		}
		.foregroundStyle(.black)
	}
	
}
