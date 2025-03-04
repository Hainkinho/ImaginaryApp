//
//
//  Tour.swift
//  Imaginary
//
//  Created by Haipp on 04.03.25.
//  
	

import Foundation

struct TourID: Equatable, Hashable {
	let value: String
}

struct Tour: Identifiable, Equatable {
	
	let id: TourID
	let title: String
	let shortDescription: String
	let snapshotImageURL: URL
	let startDate: Date
	let endDate: Date
	let price: Decimal
	
}
