//
//
//  UIAlertInformation.swift
//  Imaginary
//
//  Created by Haipp on 04.03.25.
//  
	
import Foundation

struct UIAlertInformation: Equatable {
	let localizedTitle: String
	let localizedMessage: String
	
	init(localizedTitle: String, localizedMessage: String = "") {
		self.localizedTitle = localizedTitle
		self.localizedMessage = localizedMessage
	}
	
	init(title: LocalizedStringResource, message: LocalizedStringResource? = nil) {
		self.localizedTitle = String(localized: title)
		
		if let message = message {
			self.localizedMessage = String(localized: message)
		} else {
			self.localizedMessage = ""
		}
	}
}


extension UIAlertInformation {
	
	static private let errorText = String(localized: "Error", comment: "text - Alert")
	static private let somethingWentWrongText = String(localized: "Something went Wrong", comment: "text - Alert")
	static private let cancelText = String(localized: "Cancel", comment: "text - Alert")
	static private let okText = String(localized: "OK", comment: "text - Alert")
	
	static func somethingWentWrong(localizedMessage: String? = nil) -> UIAlertInformation {
		UIAlertInformation(
			localizedTitle: Self.somethingWentWrongText,
			localizedMessage: localizedMessage ?? ""
		)
	}
	
	static func somethingWentWrong(message: LocalizedStringResource) -> UIAlertInformation {
		.somethingWentWrong(localizedMessage: String(localized: message))
	}
	
	static func error(message: LocalizedStringResource) -> UIAlertInformation {
		.error(localizedMessage: String(localized: message))
	}
	
	static func error(localizedMessage: String) -> UIAlertInformation {
		UIAlertInformation(
			localizedTitle: Self.errorText,
			localizedMessage: localizedMessage
		)
	}
}

