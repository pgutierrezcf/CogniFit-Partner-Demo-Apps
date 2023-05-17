//
//  ActivityType.swift
//  PartnerDemo
//
//  Created by Pedro Gutiérrez on 16/5/23.
//

import Foundation

/** The standard set of CogniFit activities.
 */
enum ActivityType: String, CaseIterable {
    case assessment = "ASSESSMENT"
    case trainingSession = "TRAINING"
    case trainingTask = "GAME"
}

/** Provides a human-readable name for each assessment type.
 */
func activityTypeName(_ type: ActivityType) -> String {
    switch type {
    case .assessment:
        return "Assessment"
    case .trainingSession:
        return "Training"
    case .trainingTask:
        return "Game"
    }
}
