//
//
//  NetworkService.swift
//  Imaginary
//
//  Created by Haipp on 04.03.25.
//  
	

import Foundation
import Alamofire

struct NetworkService {
	
	enum CustomError: Error {
		case InvalidResponse
		case ObjectParsingError
	}
	
	
	func fetchAllTours(completion: @escaping (Result<[Tour], Error>) -> Void) {
		let headers: HTTPHeaders = [
			"Accept": "application/json"
		]
		
		AF.request("https://bitsfabrik.com/projekte/imaginary/api/tours/", method: .get, headers: headers)
			.validate()
			.response { response in
				do {
					let jsonData = try getData(fromResponse: response)
					
					let tours = try JSONDecoder().decode([JsonTour].self, from: jsonData)
					let domainTours = tours.compactMap { $0.mapToDomain() }
					completion(.success(domainTours))
					
				} catch let error {
					print(error)
					completion(.failure(error))
				}
			}
	}
	
	
	func fetchTop5Tours(completion: @escaping (Result<[Tour], Error>) -> Void) {
		let headers: HTTPHeaders = [
			"Accept": "application/json"
		]
		
		AF.request("https://bitsfabrik.com/projekte/imaginary/api/tours/top5/", method: .get, headers: headers)
			.validate()
			.response { response in
				do {
					let jsonData = try getData(fromResponse: response)
					
					let tours = try JSONDecoder().decode([JsonTour].self, from: jsonData)
					let domainTours = tours.compactMap { $0.mapToDomain() }
					completion(.success(domainTours))
					
				} catch let error {
					print(error)
					completion(.failure(error))
				}
			}
	}
	
	
	func fetchTourDetails(forTourID tourID: TourID, completion: @escaping (Result<TourDetails, Error>) -> Void) {
		let headers: HTTPHeaders = [
			"Accept": "application/json"
		]
		let urlString = "https://bitsfabrik.com/projekte/imaginary/api/tours/\(tourID.value)/"
		
		AF.request(urlString, method: .get, headers: headers)
			.validate()
			.response { response in
				do {
					let jsonData = try getData(fromResponse: response)
					
					let tourDetails = try JSONDecoder().decode(JsonTourDetails.self, from: jsonData)
					
					guard let domainTourDetails = tourDetails.mapToDomain() else {
						completion(.failure(CustomError.ObjectParsingError))
						return
					}
					completion(.success(domainTourDetails))
					
				} catch let error {
					print(error)
					completion(.failure(error))
				}
			}
	}
	
	
	
	private func getData(fromResponse response: AFDataResponse<Data?>) throws -> Data {
		switch response.result {
		case .failure(let error):
			throw error
			
		case .success(let data):
			guard let data = data else {
				throw CustomError.InvalidResponse
			}
			
			return data
		}
	}
	
}
