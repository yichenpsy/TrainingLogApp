import Foundation

struct TrainingSession: Identifiable, Hashable {
    let id = UUID()
    
    var date: Date
    var planName: String
    var sets: [TrainingSet]
}
