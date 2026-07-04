//
//  ExerciseTrainingRecord.swift
//  TrainingLogApp
//
//  Created by Yichen Zhong on 30.06.26.
//

/**
Pull-up
→ 6 reps, yellow band
→ 5 reps, yellow band
→ 4 reps, yellow band
 */

import Foundation

/// Stores the performed sets for a single exercise inside one training session.
struct ExerciseTrainingRecord: Identifiable, Hashable, Codable {
    let id: UUID
    var exercise: Exercise
    var sets: [TrainingSet]
    
    init(
        id: UUID = UUID(),
        exercise: Exercise,
        sets: [TrainingSet] = []
    ) {
        self.id = id
        self.exercise = exercise
        self.sets = sets
    }
}
