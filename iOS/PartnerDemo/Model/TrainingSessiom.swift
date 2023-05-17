//
//  TrainingSession.swift
//  PartnerDemo
//
//  Created by Pedro Gutiérrez on 16/5/23.
//

import Foundation

/** A set of training sessions.
 @remark This is NOT a comprehensive list, please use the API to get the list of keys
 @see https://cognifitapiv2.docs.apiary.io/#reference/0/brain-training-programs/training-list
 */
enum TrainingSession: String, CaseIterable {
    case concentration = "CONCENTRATION"
    case coordination = "SPORTS_COORDINATION"
    case driving = "DRIVING_FOCUS"
    case memory = "MEMORY"
    case perception = "SPATIAL_PERCEPTION"
    case personalized = "NORMAL"
    case reading = "MENTAL_ARITHMETIC"
    case reasoning = "MENTAL_PLANNING"
    case standardizedExam = "GMAT"
}

/** Provides a human-readable name for each training session.
 */
func getTrainingSessionName(_ trainingSession: TrainingSession) -> String {
    switch trainingSession {
    case .concentration:
        return "Concentration"
    case .coordination:
        return "Coordination"
    case .driving:
        return "Driving"
    case .memory:
        return "Memory"
    case .perception:
        return "Perception"
    case .personalized:
        return "Personalized"
    case .reading:
        return "Reading"
    case .reasoning:
        return "Reasoning"
    case .standardizedExam:
        return "Standardized Exam"
    }
}
