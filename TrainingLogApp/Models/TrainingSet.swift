/**
 6 reps, yellow band, level 7
 10 reps, 20 kg
 30 sec
 8 + 8 / side
 */


import Foundation

struct TrainingSet: Identifiable, Hashable {
    let id: UUID
    var reps: String
    var intensity: String
    var note: String
    
    init(
        id: UUID = UUID(),
        reps: String = "",
        intensity: String = "",
        note: String = ""
    ) {
        self.id = id
        self.reps = reps
        self.intensity = intensity
        self.note = note
    }
}
