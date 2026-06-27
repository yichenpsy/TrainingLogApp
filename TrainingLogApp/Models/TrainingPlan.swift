import Foundation

struct TrainingPlan: Identifiable, Hashable {
    let id = UUID()
    
    var name: String
    var description: String
    var movements: [Movement]
    
    static let examplePlans: [TrainingPlan] = [
        TrainingPlan(
            name: "Plan A",
            description: "Pull-up + Squat + Row + Core",
            movements: [
                Movement.exampleMovements[0],
                Movement.exampleMovements[1],
                Movement.exampleMovements[2],
                Movement.exampleMovements[3]
            ]
        ),
        TrainingPlan(
            name: "Plan B",
            description: "Push-up + Hinge + Lunge + Core",
            movements: [
                Movement.exampleMovements[4],
                Movement.exampleMovements[5],
                Movement.exampleMovements[6],
                Movement.exampleMovements[3]
            ]
        )
    ]
}
