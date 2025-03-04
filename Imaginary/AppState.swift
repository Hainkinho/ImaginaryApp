//
//
//  AppState.swift
//  Imaginary
//
//  Created by Haipp on 04.03.25.
//  
	
import Foundation


struct AppState: Equatable {
	
	let toursDict: [TourID: Tour]
	let top5ToursIDs: [TourID]
	let tourDetailsDict: [TourID: TourDetails]
	
	var allTours: [Tour] {
		Array(toursDict.values).sorted { $0.id < $1.id }
	}
	
	var allTourDetails: [TourDetails] {
		Array(tourDetailsDict.values).sorted { $0.id < $1.id }
	}
	
	
	static let empty = AppState(toursDict: [:], top5ToursIDs: [], tourDetailsDict: [:])
}


extension AppState {
	
	func set(tours: [Tour]) -> AppState {
		var toursDict = [TourID : Tour]()
		for tour in tours {
			toursDict[tour.id] = tour
		}
		return AppState(toursDict: toursDict, top5ToursIDs: self.top5ToursIDs, tourDetailsDict: self.tourDetailsDict)
	}
	
	
	func insert(tour: Tour) -> AppState {
		var newToursDict = toursDict
		newToursDict[tour.id] = tour
		
		return AppState(toursDict: newToursDict, top5ToursIDs: self.top5ToursIDs, tourDetailsDict: self.tourDetailsDict)
	}
	
	
	func insert(tourDetails: TourDetails) -> AppState {
		var newTourDetailsDict = self.tourDetailsDict
		newTourDetailsDict[tourDetails.id] = tourDetails
		
		return AppState(toursDict: self.toursDict, top5ToursIDs: self.top5ToursIDs, tourDetailsDict: newTourDetailsDict)
	}
	
	
	func set(top5TourIDs: [TourID]) -> AppState {
		return AppState(toursDict: self.toursDict, top5ToursIDs: top5TourIDs, tourDetailsDict: self.tourDetailsDict)
	}
}
