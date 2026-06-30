/**
 Plan A
 → Pull-up
 → Squat
 → Row
 → Core
 
 */

import Foundation

struct TrainingPlan: Identifiable, Hashable {
    let id: UUID
    var name: String
    var exercises: [Exercise]
    
    init(
        id: UUID = UUID(),
        name: String,
        exercises: [Exercise] = []
    ) {
        self.id = id
        self.name = name
        self.exercises = exercises
    }
}
