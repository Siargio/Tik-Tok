//
//  HapticsManager.swift
//  Tik-Tok
//
//  Created by Sergio on 15.05.23.
//

import Foundation
import UIKit

import FirebaseAuth

final class HapticsManager {
    static let shared = HapticsManager()
    
    private init() {}
    
    //Public
    
    public func vibrateForSelection() {
        DispatchQueue.main.async {
            let generator = UISelectionFeedbackGenerator()
            generator.prepare()
            generator.selectionChanged()
        }
    }
    
    public func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType) {
        DispatchQueue.main.async {
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            generator.notificationOccurred(type)
        }
    }
}
