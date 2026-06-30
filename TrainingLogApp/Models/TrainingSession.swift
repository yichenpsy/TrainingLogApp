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

struct TrainingSession: Identifiable, Hashable {
    let id: UUID
    var date: Date
    var planName: String
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
