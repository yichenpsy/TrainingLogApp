import Foundation
import Observation

@Observable
/// Shared in-memory app state for exercises, plans, and recorded sessions.
class TrainingStore {
    var exercises: [Exercise] = []
    var plans: [TrainingPlan] = []
    var sessions: [TrainingSession] = []
    
    init() {
        // Seed data keeps the app usable immediately and provides preview content.
        let pullUp = Exercise(
            name: "Band-assisted Pull-up",
            movementPattern: .pull,
            warmUp: "Scapular Pull-up × 5",
            intensityUnit: "band",
            defaultIntensity: "yellow",
            howTo: "Full hang → pull → chin over bar. Keep shoulder stable."
        )
        
        let frontSquat = Exercise(
            name: "Squat",
            movementPattern: .squat,
            warmUp: "Bodyweight Squat × 10",
            intensityUnit: "kg",
            defaultIntensity: "20 kg",
            howTo: "Keep chest up and knees stable."
        )
        
        let row = Exercise(
            name: "Row",
            movementPattern: .pull,
            warmUp: "Light row × 10",
            intensityUnit: "kg",
            defaultIntensity: "15 kg",
            howTo: "Pull elbows back and keep back stable."
        )
        
        let plank = Exercise(
            name: "Plank",
            movementPattern: .rotation,
            warmUp: "Dead Bug × 10",
            intensityUnit: "sec",
            defaultIntensity: "30 sec",
            howTo: "Keep core tight and avoid lower back arching."
        )
        
        exercises = [pullUp, frontSquat, row, plank]
        
        // Starter plans reuse the same exercise values so records can copy them later.
        plans = [
            TrainingPlan(
                name: "Plan A",
                exercises: [pullUp, frontSquat, row, plank ]
            ),
            TrainingPlan(
                name: "Plan B",
                exercises: [frontSquat, row, plank ]
            )
        ]
    }
    
    func addExercise(_ exercise: Exercise) {
        exercises.append(exercise)
    }
    
    func addPlan(_ plan: TrainingPlan) {
        plans.append(plan)
    }
    
    func addSession(_ session: TrainingSession) {
        sessions.append(session)
    }
}
