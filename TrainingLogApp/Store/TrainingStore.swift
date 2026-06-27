import Foundation

@Observable
class TrainingStore {
    var plans: [TrainingPlan] = TrainingPlan.examplePlans
    var session: [TrainingSession] = []
    var movement: [Movement] = Movement.exampleMovements
}
