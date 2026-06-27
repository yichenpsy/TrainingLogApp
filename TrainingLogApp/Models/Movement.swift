import Foundation

struct Movement: Identifiable, Hashable {
    let id = UUID()
    
    var name: String
    var pattern: String
    var warmUp: String
    var intensityUnit: String
    var instruction: String
    
    static let exampleMovements: [Movement] = [
        Movement(
            name: "Band-assisted Pull-up",
            pattern: "Pull Vertical",
            warmUp: "Scapular Pull-up × 5",
            intensityUnit: "Band / free text",
            instruction: "Full hang → pull → chin over bar. Keep shoulder stable."
        ),
        Movement(
            name: "Squat",
            pattern: "Squat",
            warmUp: "Bodyweight Squat × 10",
            intensityUnit: "kg / free text",
            instruction: "Keep chest upright and knees stable."
        ),
        Movement(
            name: "Row",
            pattern: "Pull Horizontal",
            warmUp: "Light Row × 10",
            intensityUnit: "kg / free text",
            instruction: "Pull elbows back and keep torso stable."
        ),
        Movement(
            name: "Core",
            pattern: "Core",
            warmUp: "Dead Bug × 8",
            intensityUnit: "sec / free text",
            instruction: "Keep core tight and move slowly."
        ),
        Movement(
            name: "Push-up",
            pattern: "Push Horizontal",
            warmUp: "Incline Push-up × 8",
            intensityUnit: "reps / free text",
            instruction: "Keep body straight and control the movement."
        ),
        Movement(
            name: "Hinge",
            pattern: "Hinge",
            warmUp: "Hip Hinge Drill × 10",
            intensityUnit: "kg / free text",
            instruction: "Push hips back and keep back neutral."
        ),
        Movement(
            name: "Lunge",
            pattern: "Lunge",
            warmUp: "Reverse Lunge × 6 each side",
            intensityUnit: "kg / free text",
            instruction: "Step back, keep balance and control the knee."
        )
    ]
}
