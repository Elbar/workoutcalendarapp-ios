//
//  MockAPIService.swift
//  WorkoutCalendar
//
//  Created by Elbar on 13/12/25.
//
import Foundation

class MockAPIService {
    static let shared = MockAPIService()
    
    private init() {}
    
    func loadWorkouts() -> [Workout] {
        let jsonString = """
        [
            {"workoutKey": "7823456789012345", "workoutActivityType": "Walking/Running", "workoutStartDate": "2025-11-25 09:30:00"},
            {"workoutKey": "7823456789012346", "workoutActivityType": "Yoga", "workoutStartDate": "2025-11-25 18:00:00"},
            {"workoutKey": "7823456789012347", "workoutActivityType": "Water", "workoutStartDate": "2025-11-24 07:15:00"},
            {"workoutKey": "7823456789012348", "workoutActivityType": "Walking/Running", "workoutStartDate": "2025-11-24 17:45:00"},
            {"workoutKey": "7823456789012349", "workoutActivityType": "Cycling", "workoutStartDate": "2025-11-23 10:00:00"},
            {"workoutKey": "7823456789012350", "workoutActivityType": "Walking/Running", "workoutStartDate": "2025-11-22 08:30:00"},
            {"workoutKey": "7823456789012351", "workoutActivityType": "Yoga", "workoutStartDate": "2025-11-22 19:00:00"},
            {"workoutKey": "7823456789012352", "workoutActivityType": "Water", "workoutStartDate": "2025-11-21 06:45:00"},
            {"workoutKey": "7823456789012353", "workoutActivityType": "Strength", "workoutStartDate": "2025-11-21 16:30:00"}
        ]
        """
        
        guard let data = jsonString.data(using: .utf8),
              let workouts = try? JSONDecoder().decode([Workout].self, from: data) else {
            return []
        }
        return workouts
    }
    
    func loadMetadata(for workoutKey: String) -> WorkoutMetadata? {
        let metadataDict: [String: WorkoutMetadata] = [
            "7823456789012345": WorkoutMetadata(
                workoutKey: "7823456789012345",
                workoutActivityType: .walkingRunning,
                workoutStartDate: "2025-11-25 09:30:00",
                distance: "5230.50",
                duration: "2700.00",
                comment: "Утренняя пробежка в парке",
                avgTemp: "12.50",
                avgHumidity: "65.00"
            ),
            "7823456789012346": WorkoutMetadata(
                workoutKey: "7823456789012346",
                workoutActivityType: .yoga,
                workoutStartDate: "2025-11-25 18:00:00",
                distance: "0.00",
                duration: "3600.00",
                comment: "Вечерняя йога для расслабления",
                avgTemp: "22.00",
                avgHumidity: "45.00"
            ),
            "7823456789012347": WorkoutMetadata(
                workoutKey: "7823456789012347",
                workoutActivityType: .water,
                workoutStartDate: "2025-11-24 07:15:00",
                distance: "1500.00",
                duration: "2400.00",
                comment: "Моржевание в озере",
                avgTemp: "4.50",
                avgHumidity: "80.00"
            ),
            "7823456789012348": WorkoutMetadata(
                workoutKey: "7823456789012348",
                workoutActivityType: .walkingRunning,
                workoutStartDate: "2025-11-24 17:45:00",
                distance: "8120.00",
                duration: "4200.00",
                comment: "Вечерний бег по набережной",
                avgTemp: "8.00",
                avgHumidity: "58.00"
            ),
            "7823456789012349": WorkoutMetadata(
                workoutKey: "7823456789012349",
                workoutActivityType: .cycling,
                workoutStartDate: "2025-11-23 10:00:00",
                distance: "25430.00",
                duration: "5400.00",
                comment: "Велопрогулка за городом",
                avgTemp: "14.00",
                avgHumidity: "55.00"
            ),
            "7823456789012350": WorkoutMetadata(
                workoutKey: "7823456789012350",
                workoutActivityType: .walkingRunning,
                workoutStartDate: "2025-11-22 08:30:00",
                distance: "10250.00",
                duration: "5040.00",
                comment: "Длинная пробежка",
                avgTemp: "6.00",
                avgHumidity: "70.00"
            ),
            "7823456789012351": WorkoutMetadata(
                workoutKey: "7823456789012351",
                workoutActivityType: .yoga,
                workoutStartDate: "2025-11-22 19:00:00",
                distance: "0.00",
                duration: "2700.00",
                comment: "Хатха-йога",
                avgTemp: "21.00",
                avgHumidity: "42.00"
            ),
            "7823456789012352": WorkoutMetadata(
                workoutKey: "7823456789012352",
                workoutActivityType: .water,
                workoutStartDate: "2025-11-21 06:45:00",
                distance: "800.00",
                duration: "1800.00",
                comment: "Утреннее закаливание",
                avgTemp: "3.00",
                avgHumidity: "85.00"
            ),
            "7823456789012353": WorkoutMetadata(
                workoutKey: "7823456789012353",
                workoutActivityType: .strength,
                workoutStartDate: "2025-11-21 16:30:00",
                distance: "0.00",
                duration: "4500.00",
                comment: "Силовая тренировка в зале",
                avgTemp: "20.00",
                avgHumidity: "40.00"
            )
        ]
        return metadataDict[workoutKey]
    }
    
    func loadDiagramData(for workoutKey: String) -> WorkoutDiagramData? {
        // Simplified sample data for heart rate chart
        let sampleData: [String: [WorkoutDiagramData.DataPoint]] = [
            "7823456789012345": [
                WorkoutDiagramData.DataPoint(timeNumeric: 0, heartRate: 72, speedKmh: 0.0, distanceMeters: 0, steps: 0, currentTimestamp: "2025-11-25 09:30:00"),
                WorkoutDiagramData.DataPoint(timeNumeric: 5, heartRate: 105, speedKmh: 9.1, distanceMeters: 525, steps: 590, currentTimestamp: "2025-11-25 09:35:00"),
                WorkoutDiagramData.DataPoint(timeNumeric: 10, heartRate: 135, speedKmh: 11.0, distanceMeters: 1555, steps: 1758, currentTimestamp: "2025-11-25 09:40:00"),
                WorkoutDiagramData.DataPoint(timeNumeric: 15, heartRate: 145, speedKmh: 9.2, distanceMeters: 2380, steps: 2718, currentTimestamp: "2025-11-25 09:45:00"),
                WorkoutDiagramData.DataPoint(timeNumeric: 20, heartRate: 128, speedKmh: 7.4, distanceMeters: 3059, steps: 3528, currentTimestamp: "2025-11-25 09:50:00")
            ]
        ]
        
        guard let points = sampleData[workoutKey] else { return nil }
        return WorkoutDiagramData(data: points)
    }
}
