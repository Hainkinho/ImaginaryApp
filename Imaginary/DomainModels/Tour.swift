//
//
//  Tour.swift
//  Imaginary
//
//  Created by Haipp on 04.03.25.
//  
	

import Foundation

struct TourID: Equatable, Hashable, Comparable {
	static func < (lhs: TourID, rhs: TourID) -> Bool {
		return lhs.value < rhs.value
	}
	
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
	
	private static let priceFormatter: NumberFormatter = {
		let numberFormatter = NumberFormatter()
		numberFormatter.numberStyle = .currency
		numberFormatter.currencyCode = "USD"
		numberFormatter.locale = Locale(identifier: "en_US")
		return numberFormatter
	}()
	
	
	var localizedPrice: String {
		return Self.priceFormatter.string(from: price as NSNumber) ?? price.description
	}
}


extension Tour {
	
	static func createExample(withID id: String) -> Tour {
		Tour(
			id: TourID(value: id),
			title: "Title",
			shortDescription: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam",
			snapshotImageURL: URL.placeholderImageURL,
			startDate: .now.addingTimeInterval(-1000),
			endDate: .now,
			price: 100
		)
	}
}
