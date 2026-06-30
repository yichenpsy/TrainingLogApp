//
//  RecordDetailView.swift
//  TrainingLogApp
//
//  Created by Yichen Zhong on 30.06.26.
//

import SwiftUI

struct RecordDetailView: View {
    let session: TrainingSession
    
    var body: some View {
        List {
            Section("Session") {
                Text(session.planName)
                Text(session.date, format: .dateTime.day().month().year().hour().minute())
                
                if !session.rpe.isEmpty {
                    Text("RPE: \(session.rpe)")
                }
            }
            
            Section("Exercises") {
                ForEach(session.exerciseRecords) { record in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(record.exercise.name)
                            .font(.headline)
                        
                        Text(record.exercise.movementPattern.rawValue)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        
                        ForEach(record.sets) { set in
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Reps: \(set.reps)")
                                Text("Intensity: \(set.intensity)")
                                
                                if !set.note.isEmpty {
                                    Text("Note: \(set.note)")
                                }
                            }
                            .font(.subheadline)
                            .padding(.leading)
                        }
                    }
                    .padding(.vertical, 6)
                }
            }
        }
        .navigationTitle("Record Detail")
    }
}

#Preview {
    let store = TrainingStore()
    let plan = store.plans[0]
    
    let session = TrainingSession(
        planName: plan.name,
        rpe: "7",
        exerciseRecords: plan.exercises.map {
            ExerciseTrainingRecord(
                exercise: $0,
                sets: [
                    TrainingSet(reps: "10", intensity: "20 kg", note: "Good")
                ]
            )
        }
    )
    
    NavigationStack {
        RecordDetailView(session: session)
    }
}
