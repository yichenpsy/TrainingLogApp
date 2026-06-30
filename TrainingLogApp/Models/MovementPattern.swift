enum MovementPattern: String, CaseIterable, Identifiable {
    case squat = "Squat"
    case hinge = "Hinge"
    case lunge = "Lunge"
    case push = "Push"
    case pull = "Pull"
    case rotation = "Rotation"
    case carry = "Carry"
    
    var id: String {
        rawValue
    }
}
