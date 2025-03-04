//
//
//  DetailsPageViewModel.swift
//  Imaginary
//
//  Created by Haipp on 04.03.25.
//  
	

import Combine


class DetailsPageViewModel: ObservableObject {
	
	@Published var tour: Tour
	@Published var tourDetails: TourDetails? = nil
	
	@Published var activeAlert: UIAlertInformation? = nil
	
	private let tourID: TourID
	private let fetchTourDetailsUsecase: FetchTourDetailsUsecase
	private var subscription: AnyCancellable? = nil
	
	init(tour: Tour, fetchTourDetailsUsecase: FetchTourDetailsUsecase) {
		self.tour = tour
		self.tourID = tour.id
		self.fetchTourDetailsUsecase = fetchTourDetailsUsecase
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
	
	
	func fetchTourDetails() async {
		do {
			let tourDetails = try await fetchTourDetailsUsecase.fetch(tourID: tourID)
			
			await MainActor.run {
				self.tourDetails = tourDetails
			}
		} catch let error {
			print(error)
			await MainActor.run {
				self.activeAlert = .somethingWentWrong(
					localizedMessage: String(
						localized: "We could not fetch the current tour details. Please try again later.",
						comment: "Alert message - DetailsPageViewModel"
					)
				)
			}
		}
	}
	
	
	func callToActionButtonTapped() async {
		await MainActor.run {
			self.activeAlert = .init(
				localizedTitle: String(localized: "Want to book a Trip?", comment: "Alert title - DetailsPage"),
				localizedMessage: String(localized: "To book a trip, please call us at +43 666 1234567", comment: "Alert body - DetailsPage")
			)
		}
	}
	
}
