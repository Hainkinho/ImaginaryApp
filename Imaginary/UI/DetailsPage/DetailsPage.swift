//
//
//  DetailsPage.swift
//  Imaginary
//
//  Created by Haipp on 04.03.25.
//  
	

import SwiftUI


struct DetailsPage: View {
	
	let showcaseImageURL: URL
	let title: String
	let description: String
	let startDate: Date
	let endDate: Date
	
	var dateRangeText: String {
		let startDateString = startDate.formatted(date: .numeric, time: .shortened)
		let endDateString = endDate.formatted(date: .numeric, time: .shortened)
		
		return "\(startDateString) - \(endDateString)"
	}
	
	var body: some View {
		ScrollView {
			VStack(spacing: 0) {
				AsyncImage(
					url: showcaseImageURL,
					content: { image in
						image
							.resizable()
							.scaledToFit()
							.frame(maxWidth: .infinity)
					},
					placeholder: {
						Rectangle()
							.foregroundStyle(.gray)
							.frame(maxWidth: .infinity)
							.frame(height: 100)
					}
				)
				
				VStack(alignment: .leading, spacing: 8) {
					Text(title)
						.fontWeight(.bold)
					
					Text(description)
						.frame(minHeight: 150, alignment: .top)
						.padding(.bottom, 10)
					
					Text("Bookable", comment: "Section header text - DetailsPage")
						.fontWeight(.bold)
					
					Text(dateRangeText)
				}
				.frame(maxWidth: .infinity, alignment: .leading)
				.padding(.vertical, 40)
				
				Button(action: {}) {
					Text("CALL TO BOOK", comment: "Call to action button title - DetailsPage")
						.foregroundStyle(.white)
						.fontWeight(.bold)
						.font(.title3)
						.frame(maxWidth: .infinity)
						.padding(.horizontal, 50) // Prevents image from overlapping text if it becomes too long
						.overlay(alignment: .leading) {
							Image(Constants.companyLogoImageString)
								.resizable()
								.frame(width: 40, height: 40)
								.padding(.leading)
						}
						.frame(maxWidth: .infinity)
						.frame(minHeight: 65)
						.background(Color.blue)
				}
			}
			.padding(.horizontal)
			.padding(.vertical)
		}
	}
}


#Preview {
	DetailsPage(
		showcaseImageURL: URL.placeholderImageURL,
		title: "Title",
		description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam",
		startDate: .now.addingTimeInterval(-1000),
		endDate: .now
	)
}
