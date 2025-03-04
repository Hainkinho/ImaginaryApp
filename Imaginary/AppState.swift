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
	let tourDetailsDict: [TourID: TourDetails]
	
	static let empty = AppState(toursDict: [:], tourDetailsDict: [:])
}


extension AppState {
	
	func insert(tour: Tour) -> AppState {
		var newToursDict = toursDict
		newToursDict[tour.id] = tour
		
		return AppState(toursDict: newToursDict, tourDetailsDict: self.tourDetailsDict)
	}
	
	
	func insert(tourDetails: TourDetails) -> AppState {
		var newTourDetailsDict = self.tourDetailsDict
		newTourDetailsDict[tourDetails.id] = tourDetails
		
		return AppState(toursDict: self.toursDict, tourDetailsDict: newTourDetailsDict)
	}
}
