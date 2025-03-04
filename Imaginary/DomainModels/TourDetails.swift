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
