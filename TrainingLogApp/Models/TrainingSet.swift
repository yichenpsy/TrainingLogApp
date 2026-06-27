import Foundation

struct TrainingSet: Identifiable, Hashable {
    let id = UUID()
    
    var movementName: String
    var reps: String
    var intensity: String
    var note: String
}
