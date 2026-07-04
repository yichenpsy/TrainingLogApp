/// High-level movement categories used to organize exercises and plans.
enum MovementPattern: String, CaseIterable, Identifiable, Codable {
    case squat = "Squat"
    case hinge = "Hinge"
    case lunge = "Lunge"
    case push = "Push"
    case pull = "Pull"
    case rotation = "Rotation"
    case carry = "Carry"
    
    /// Uses the display name as the stable ID for SwiftUI lists and pickers.
    var id: String {
        rawValue
    }
}
