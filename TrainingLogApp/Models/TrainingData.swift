import Foundation

/// Stored JSON snapshot of the user's training data.
struct TrainingData: Codable {
    var exercises: [Exercise]
    var plans: [TrainingPlan]
    var sessions: [TrainingSession]
}
