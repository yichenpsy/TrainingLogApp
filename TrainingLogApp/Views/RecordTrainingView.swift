import SwiftUI

struct RecordTrainingView: View {
    @Environment(TrainingStore.self) private var store
    
    let plan: TrainingPlan
    
    @State private var exerciseRecords: [ExerciseTrainingRecord]
    @State private var rpe: String = ""
    @State private var saved = false
    
    init(plan: TrainingPlan) {
        self.plan = plan
        
        let records = plan.exercises.map { exercise in
            ExerciseTrainingRecord(
                exercise: exercise,
                sets: [TrainingSet()]
            )
        }
        
        _exerciseRecords = State(initialValue: records)
    }
    
    var body: some View {
        Form {
            Section("Plan") {
                Text(plan.name)
            }
            
            Section("Exercises") {
                ForEach($exerciseRecords) { $record in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(record.exercise.name)
                            .font(.headline)
                        
                        Text(record.exercise.movementPattern.rawValue)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        ForEach($record.sets) { $set in
                            TextField("Reps", text: $set.reps)
                            TextField("Intensity", text: $set.intensity)
                            TextField("Note", text: $set.note)
                        }
                        
                        Button("Add Set") {
                            record.sets.append(TrainingSet())
                        }
                    }
                    .padding(.vertical, 6)
                }
            }
            
            Section("RPE") {
                TextField("e.g. 6-7", text: $rpe)
            }
            
            Button("Save Training Session") {
                let session = TrainingSession(
                    planName: plan.name,
                    rpe: rpe,
                    exerciseRecords: exerciseRecords
                )
                
                store.addSession(session)
                saved = true
            }
            
            if saved {
                Text("Saved")
                    .foregroundStyle(.green)
            }
        }
        .navigationTitle("Record Training")
    }
}

#Preview {
    RecordTrainingView(plan: TrainingStore().plans[0])
        .environment(TrainingStore())
}
