//
//
//  DetailsPage.swift
//  Imaginary
//
//  Created by Haipp on 04.03.25.
//  
	

import SwiftUI

import Combine
class DetailsPageViewModel: ObservableObject {
	
	@Published var tour: Tour
	@Published var tourDetails: TourDetails? = nil
	
	let tourID: TourID
	private var subscription: AnyCancellable? = nil
	
	init(tour: Tour) {
		self.tour = tour
		self.tourID = tour.id
	}
	
	func subcribe(appStatePublisher: AnyPublisher<AppState, Never>) {
		self.subscription = appStatePublisher
			.sink { [weak self] newAppState in
				self?.update(withNewAppState: newAppState)
			}
	}
	
	
	func update(withNewAppState newAppState: AppState) {
		if let newTour = newAppState.toursDict[self.tourID] {
			self.tour = newTour
		}
		self.tourDetails = newAppState.tourDetailsDict[self.tourID]
	}
	
}



struct DetailsContainerPage: View {
	
	@ObservedObject var vm: DetailsPageViewModel
	
	var body: some View {
		DetailsPage(
			showcaseImageURL: vm.tourDetails?.fullResImageURL ?? vm.tour.snapshotImageURL,
			title: vm.tour.title,
			description: vm.tourDetails?.longDescription ?? vm.tour.shortDescription,
			isBookable: true, // TODO:
			startDate: vm.tour.startDate,
			endDate: vm.tour.endDate
		)
	}
}


struct DetailsPage: View {
	
	let showcaseImageURL: URL
	let title: String
	let description: String
	let isBookable: Bool
	let startDate: Date
	let endDate: Date
	
	var body: some View {
		ScrollView {
			VStack(spacing: 0) {
				Rectangle()
					.frame(maxWidth: .infinity)
					.frame(height: 300)
				
				VStack(alignment: .leading, spacing: 8) {
					Text(title)
						.fontWeight(.bold)
					
					Text(description)
						.frame(minHeight: 150, alignment: .top)
					
					Text(isBookable ? "Bookable" : "Not Bookable")
						.fontWeight(.bold)
					
					Text("Start - End")
				}
				.frame(maxWidth: .infinity, alignment: .leading)
				.padding(.vertical, 40)
				
				Button(action: {}) {
					Text("CALL TO BOOK")
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
		isBookable: true,
		startDate: .now.addingTimeInterval(-1000),
		endDate: .now
	)
}
