//
//
//  TourDetails.swift
//  Imaginary
//
//  Created by Haipp on 04.03.25.
//  
	

import Foundation


struct TourDetails: Identifiable, Equatable {
	let id: TourID
	let longDescription: String
	let fullResImageURL: URL
}


extension TourDetails {
	
	static func createExample(withID id: String) -> TourDetails {
		TourDetails(
			id: .init(value: id),
			longDescription: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.",
			fullResImageURL: URL.placeholderImageURL
		)
	}
}

