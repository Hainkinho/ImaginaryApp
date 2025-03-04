//
//
//  Models.swift
//  Imaginary
//
//  Created by Haipp on 04.03.25.
//  
	

import Foundation


struct JsonTour: Codable {
	let id: Int
	let title: String
	let shortDescription: String
	let thumb: String
	let startDate: String
	let endDate: String
	let price: String
}

extension JsonTour {
	
	static let dateFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
		return formatter
	}()
	
	func mapToDomain() -> Tour? {
		
		guard let startDate = Self.dateFormatter.date(from: self.startDate),
			  let endDate = Self.dateFormatter.date(from: self.endDate),
			  let price =  Double(self.price),
			  let imageURL = URL(string: self.thumb) else {
			assertionFailure("Should not happen!")
			return nil
		}
		
		return Tour(
			id: .init(value: String(self.id)),
			title: self.title,
			shortDescription: self.shortDescription,
			snapshotImageURL: imageURL,
			startDate: startDate,
			endDate: endDate,
			price: Decimal(price)
		)
	}
}




struct JsonTourDetails: Codable {
	var id: Int
	var title: String
	var shortDescription: String
	var description: String
	var thumb: String
	var image: String
	var startDate: String
	var endDate: String
	var price: String
}

extension JsonTourDetails {
	
	static let dateFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
		return formatter
	}()
	
	func mapToDomain() -> TourDetails? {
		guard let fullResImageURL = URL(string: self.image) else {
			assertionFailure("Should never happen!")
			return nil
		}
		
		return TourDetails(
			id: .init(value: "\(self.id)"),
			longDescription: self.description,
			fullResImageURL: fullResImageURL
		)
	}
}
