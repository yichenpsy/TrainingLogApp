/**
 Today
 Plan A
 
 RPE 6–7
 Pull-up: 5 + 4 + 3
 Squat: 10 + 12
 Row: 8 + 8 / side
 Core: 30 + 25 sec
 */

import Foundation

/// Captures one completed workout, including the plan name, effort, and sets.
struct TrainingSession: Identifiable, Hashable, Codable {
    let id: UUID
    var date: Date
    var planName: String
    /// Rate of perceived exertion for the whole session.
    var rpe: String
    var exerciseRecords: [ExerciseTrainingRecord]
    
    init(
        id: UUID = UUID(),
        date: Date = Date(),
        planName: String,
        rpe: String = "",
        exerciseRecords: [ExerciseTrainingRecord] = []
    ) {
        self.id = id
        self.date = date
        self.planName = planName
        self.rpe = rpe
        self.exerciseRecords = exerciseRecords
    }
}
