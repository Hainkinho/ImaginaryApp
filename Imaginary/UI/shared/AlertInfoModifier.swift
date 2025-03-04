//
//
//  CustomAlertInfo + ViewModifier.swift
//  Imaginary
//
//  Created by Haipp on 04.03.25.
//  
	
import SwiftUI

extension View {
	
	func customAlertInfo(_ alertInfo: Binding<UIAlertInformation?>) -> some View {
		self.modifier(AlertInfoModifier(alertInfo: alertInfo))
	}
}



struct AlertInfoModifier: ViewModifier {
	
	@Binding var alertInfo: UIAlertInformation?
	
	var customBinding: Binding<Bool> {
		Binding<Bool>(
			get: { self.alertInfo != nil },
			set: { isShowingAlert in
				if !isShowingAlert {
					self.alertInfo = nil
				}
			}
		)
	}

	func body(content: Content) -> some View {
		content
			.alert(isPresented: customBinding) {
				Alert(
					title: Text(alertInfo?.localizedTitle ?? ""),
					message: Text(alertInfo?.localizedMessage ?? ""),
					dismissButton: .default(Text("OK"))
				)
			}
	}
}
