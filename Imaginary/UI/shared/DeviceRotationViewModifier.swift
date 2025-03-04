//
//
//  DeviceRotationViewModifier.swift
//  Imaginary
//
//  Created by Haipp on 04.03.25.
//  
	
import SwiftUI


enum DeviceOrientation {
	case Portrait
	case Landscape
}


/// Source: https://www.hackingwithswift.com/quick-start/swiftui/how-to-detect-device-rotation
struct DeviceRotationViewModifier: ViewModifier {
	
	@Binding var deviceOrientation: DeviceOrientation

	func body(content: Content) -> some View {
		content
			.onAppear {
				if let newValidOrientation = getCurrentValue() {
					self.deviceOrientation = newValidOrientation
				}
			}
			.onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
				if let newValidOrientation = getCurrentValue() {
					self.deviceOrientation = newValidOrientation
				}
			}
	}
	
	func getCurrentValue() -> DeviceOrientation? {
		switch UIDevice.current.orientation {
		case .landscapeLeft, .landscapeRight:
			return .Landscape
		case .portrait, .portraitUpsideDown:
			return .Portrait
			
		default:
			return nil
		}
	}
}


extension View {
	func deviceOrientation(value: Binding<DeviceOrientation>) -> some View {
		self.modifier(DeviceRotationViewModifier(deviceOrientation: value))
	}
}
