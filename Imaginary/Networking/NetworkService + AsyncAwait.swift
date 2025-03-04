//
//
//  NetworkService.swift
//  Imaginary
//
//  Created by Haipp on 04.03.25.
//  
	

extension NetworkService {
	
	func fetchAllTours() async throws -> [Tour] {
		return try await withCheckedThrowingContinuation { continuation in
			self.fetchAllTours(completion: { result in
				switch result {
				case .success(let tours):
					continuation.resume(returning: tours)
					return
				case .failure(let error):
					continuation.resume(throwing: error)
					return
				}
			})
		}
	}
	
	
	func fetchTop5Tours() async throws -> [Tour] {
		return try await withCheckedThrowingContinuation { continuation in
			self.fetchTop5Tours(completion: { result in
				switch result {
				case .success(let tours):
					continuation.resume(returning: tours)
					return
				case .failure(let error):
					continuation.resume(throwing: error)
					return
				}
			})
		}
	}
	
}
