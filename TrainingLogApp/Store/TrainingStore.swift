import Foundation
import Observation

enum AppTab: Hashable {
    case plans
    case records
    case exercises
}


@Observable
/// Shared in-memory app state for exercises, plans, and recorded sessions.
class TrainingStore {
    var exercises: [Exercise] = []
    var plans: [TrainingPlan] = []
    var sessions: [TrainingSession] = []
    
    var selectedTab: AppTab = .plans
    
    init() {
        if loadSavedData() {
            return
        }
        
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
        saveData()
    }
    
    func addPlan(_ plan: TrainingPlan) {
        plans.append(plan)
        saveData()
    }
    
    func addSession(_ session: TrainingSession) {
        sessions.append(session)
        saveData()
    }
    
    func updatePlan(_ updatedPlan: TrainingPlan) {
        if let index = plans.firstIndex(where: { $0.id == updatedPlan.id }) {
            plans[index] = updatedPlan
            saveData()
        }
    }

    func deletePlan(_ plan: TrainingPlan) {
        plans.removeAll { $0.id == plan.id }
        saveData()
    }

    func updateExercise(_ updatedExercise: Exercise) {
        var didUpdate = false
        
        if let index = exercises.firstIndex(where: { $0.id == updatedExercise.id }) {
            exercises[index] = updatedExercise
            didUpdate = true
        }
        
        for planIndex in plans.indices {
            for exerciseIndex in plans[planIndex].exercises.indices {
                if plans[planIndex].exercises[exerciseIndex].id == updatedExercise.id {
                    plans[planIndex].exercises[exerciseIndex] = updatedExercise
                    didUpdate = true
                }
            }
        }
        
        if didUpdate {
            saveData()
        }
    }

    func isExerciseUsedInPlan(_ exercise: Exercise) -> Bool {
        plans.contains { plan in
            plan.exercises.contains { $0.id == exercise.id }
        }
    }

    func deleteExercise(_ exercise: Exercise) -> Bool {
        if isExerciseUsedInPlan(exercise) {
            return false
        }
        
        exercises.removeAll { $0.id == exercise.id }
        saveData()
        return true
    }
    
    private var dataFileURL: URL {
        let documentsDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        )[0]
        
        return documentsDirectory.appendingPathComponent("training-data.json")
    }
    
    private func loadSavedData() -> Bool {
        do {
            let data = try Data(contentsOf: dataFileURL)
            let trainingData = try JSONDecoder().decode(TrainingData.self, from: data)
            
            exercises = trainingData.exercises
            plans = trainingData.plans
            sessions = trainingData.sessions
            
            return true
        } catch CocoaError.fileReadNoSuchFile {
            return false
        } catch {
            print("Could not load training data: \(error.localizedDescription)")
            return false
        }
    }
    
    private func saveData() {
        do {
            let trainingData = TrainingData(
                exercises: exercises,
                plans: plans,
                sessions: sessions
            )
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
            
            let data = try encoder.encode(trainingData)
            try data.write(to: dataFileURL, options: [.atomic])
        } catch {
            print("Could not save training data: \(error.localizedDescription)")
        }
    }
}
