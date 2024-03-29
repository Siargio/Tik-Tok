//
//  HapticsManager.swift
//  Tik-Tok
//
//  Created by Sergio on 15.05.23.
//

import Foundation
import UIKit

import FirebaseAuth

/// Object that deals with haptic feedback
final class HapticsManager {
    /// Share singleton instance
    static let shared = HapticsManager()
    
    private init() {}
    
    //Public

    /// Vibrate for light selection of item
    public func vibrateForSelection() {
        DispatchQueue.main.async {
            let generator = UISelectionFeedbackGenerator()
            generator.prepare()
            generator.selectionChanged()
        }
    }

    /// Trigger feedback vibration based on event type
    /// - Parameter type: Success, Error or Warning type
    public func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType) {
        DispatchQueue.main.async {
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            generator.notificationOccurred(type)
        }
    }
}
