//
//  MockAPIService.swift
//  WorkoutCalendar
//
//  Created by Elbar on 13/12/25.
//


class MockAPIService {
    static let shared = MockAPIService()
    
    private let workoutsJSON = """
    [
        {
            "workoutKey": "7823456789012345",
            "workoutActivityType": "Walking/Running",
            "workoutStartDate": "2025-11-25 09:30:00"
        },
        {
            "workoutKey": "7823456789012346",
            "workoutActivityType": "Yoga",
            "workoutStartDate": "2025-11-25 18:00:00"
        },
        {
            "workoutKey": "7823456789012347",
            "workoutActivityType": "Water",
            "workoutStartDate": "2025-11-24 07:15:00"
        },
        {
            "workoutKey": "7823456789012348",
            "workoutActivityType": "Walking/Running",
            "workoutStartDate": "2025-11-24 17:45:00"
        },
        {
            "workoutKey": "7823456789012349",
            "workoutActivityType": "Cycling",
            "workoutStartDate": "2025-11-23 10:00:00"
        },
        {
            "workoutKey": "7823456789012350",
            "workoutActivityType": "Walking/Running",
            "workoutStartDate": "2025-11-22 08:30:00"
        },
        {
            "workoutKey": "7823456789012351",
            "workoutActivityType": "Yoga",
            "workoutStartDate": "2025-11-22 19:00:00"
        },
        {
            "workoutKey": "7823456789012352",
            "workoutActivityType": "Water",
            "workoutStartDate": "2025-11-21 06:45:00"
        },
        {
            "workoutKey": "7823456789012353",
            "workoutActivityType": "Strength",
            "workoutStartDate": "2025-11-21 16:30:00"
        }
    ]
    """
    
    private let metadataDict: [String: WorkoutMetadata] = [
        "7823456789012345": WorkoutMetadata(
            workoutKey: "7823456789012345",
            activityType: "Walking/Running",
            startDate: "2025-11-25 09:30:00",
            distance: "5230.50",
            duration: "2700.00",
            comment: "Утренняя пробежка в парке"
        ),
        "7823456789012346": WorkoutMetadata(
            workoutKey: "7823456789012346",
            activityType: "Yoga",
            startDate: "2025-11-25 18:00:00",
            distance: "0.00",
            duration: "3600.00",
            comment: "Вечерняя йога для расслабления"
        ),
        "7823456789012349": WorkoutMetadata(
            workoutKey: "7823456789012349",
            activityType: "Cycling",
            startDate: "2025-11-23 10:00:00",
            distance: "25430.00",
            duration: "5400.00",
            comment: "Велопрогулка за городом"
        ),
        "7823456789012350": WorkoutMetadata(
            workoutKey: "7823456789012350",
            activityType: "Walking/Running",
            startDate: "2025-11-22 08:30:00",
            distance: "10250.00",
            duration: "5040.00",
            comment: "Длинная пробежка"
        )
    ]
    
    func fetchWorkouts() async throws -> [Workout] {
        try await Task.sleep(nanoseconds: 500_000_000)
        let data = workoutsJSON.data(using: .utf8)!
        return try JSONDecoder().decode([Workout].self, from: data)
    }
    
    func fetchMetadata(for workoutId: String) async -> WorkoutMetadata? {
        try? await Task.sleep(nanoseconds: 300_000_000)
        return metadataDict[workoutId]
    }
    
    func fetchDiagramData(for workoutId: String) async -> DiagramData? {
        try? await Task.sleep(nanoseconds: 300_000_000)
        
        // Симуляция данных пульса для демонстрации
        let heartRates = [72, 85, 92, 98, 105, 112, 118, 122, 128, 132, 135, 138, 140, 142, 144, 145, 143, 140, 136, 132, 128]
        let dataPoints = heartRates.enumerated().map { index, hr in
            DiagramData.DataPoint(
                timeNumeric: index,
                heartRate: hr,
                speedKmh: Double.random(in: 6...12),
                distanceMeters: index * 150,
                currentTimestamp: "2025-11-25 09:\(30 + index):00"
            )
        }
        
        return DiagramData(data: dataPoints)
    }
}
