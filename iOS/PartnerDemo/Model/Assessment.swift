//
//  Assessment.swift
//  PartnerDemo
//
//  Created by Pedro Gutiérrez on 16/5/23.
//

import Foundation

/** A set of assessments.
 @remark This is NOT a comprehensive list, please use the API to get the list of keys
 @see https://cognifitapiv2.docs.apiary.io/#reference/0/cognitive-assessments/assessments-list
 */
enum Assessment: String, CaseIterable {
    case concentration = "CONCENTRATION_ASSESSMENT"
    case coordination = "COORDINATION_ASSESSMENT"
    case dearyLiewald = "DEARY_LIEWALD_TASK_ASSESSMENT"
    case driving = "DRIVING"
    case eriksenFlanker = "ERIKSEN_FLANKER_TASK_ASSESSMENT"
    case general = "GENERAL"
    case inhibitionOfReturn = "INHIBITION_OF_RETURN_TASK_ASSESSMENT"
    case memory = "MEMORY_ASSESSMENT"
    case perception = "PERCEPTION_ASSESSMENT"
    case reading = "MENTAL_ARITHMETIC_ASSESSMENT"
    case reasoning = "REASONING_ASSESSMENT"
    case simonTask = "SIMON_TASK_TASK_ASSESSMENT"
    case towerOfHanoi = "TOWER_OF_HANOI_TASK_ASSESSMENT"
    case trailMaking = "TRAIL_MAKING_TASK_ASSESSMENT"
    case visualEpisodic = "VISUAL_EPISODIC_TASK_ASSESSMENT"
}

/** Provides a human-readable name for each assessment.
 */
func getAssessmentName(_ assessment: Assessment) -> String {
    switch assessment {
    case .concentration:
        return "Concentration"
    case .coordination:
        return "Coordination"
    case .dearyLiewald:
        return "Deary-Liewald Task"
    case .driving:
        return "Driving"
    case .eriksenFlanker:
        return "Eriksen Flanker"
    case .general:
        return "General"
    case .inhibitionOfReturn:
        return "Inhibition of Return Task"
    case .memory:
        return "Memory"
    case .perception:
        return "Perception"
    case .reading:
        return "Reading"
    case .reasoning:
        return "Reasoning"
    case .simonTask:
        return "Simon Task"
    case .towerOfHanoi:
        return "Tower of Hanoi"
    case .trailMaking:
        return "Trail Making Test"
    case .visualEpisodic:
        return "Visual Episodic Memory Test"
    }
}
